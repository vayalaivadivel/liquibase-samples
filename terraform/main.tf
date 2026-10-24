
provider "aws" {
  region = var.aws_region
}

locals {
  environment = var.environment

  resource_prefix = "${var.project_name}-${local.environment}"
  database_name   = "${var.db_name}-${local.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = local.environment
    ManagedBy   = "Terraform"
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_db_subnet_group" "postgres" {
  name       = "${local.resource_prefix}-postgres-subnets"
  subnet_ids = data.aws_subnets.default.ids

  tags = merge(local.common_tags, {
    Name = "${local.resource_prefix}-postgres-subnets"
  })
}

resource "aws_security_group" "postgres" {
  name        = "${local.resource_prefix}-postgres-sg"
  description = "PostgreSQL access for ${local.environment}"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "PostgreSQL access from your public IP"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.allowed_client_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.resource_prefix}-postgres-sg"
  })
}

resource "aws_db_instance" "postgres" {
  identifier = "${local.resource_prefix}-postgres"

  engine         = "postgres"
  engine_version = "16"
  instance_class = var.db_instance_class

  allocated_storage     = var.db_allocated_storage
  max_allocated_storage = 50
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = local.database_name
  username = var.db_username
  password = var.db_password
  port     = 5432

  db_subnet_group_name   = aws_db_subnet_group.postgres.name
  vpc_security_group_ids = [aws_security_group.postgres.id]

  publicly_accessible = var.publicly_accessible
  multi_az            = var.multi_az

  backup_retention_period = var.backup_retention_days

  deletion_protection = local.environment == "prod"
  skip_final_snapshot = local.environment != "prod"

  tags = merge(local.common_tags, {
    Name = "${local.resource_prefix}-postgres"
  })
}