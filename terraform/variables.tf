
variable "aws_region" {
  description = "AWS region for infrastructure"
  type        = string
  default     = "ap-south-1"
}


variable "project_name" {
  description = "Project name used for AWS resources"
  type        = string
  default     = "liquibase-samples"
}

variable "environment" {
  description = "Deployment environment selected in CI/CD"
  type        = string

  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "Environment must be dev, qa, or prod."
  }
}

variable "db_name" {
  description = "Base PostgreSQL database name"
  type        = string
  default     = "liquibasedb"
}


variable "db_username" {
  description = "PostgreSQL master username"
  type        = string
  default     = "dbadmin"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Initial RDS storage in GB"
  type        = number
  default     = 20
}

variable "db_password" {
  description = "PostgreSQL master password"
  type        = string
  sensitive   = true
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "backup_retention_days" {
  description = "RDS backup retention in days"
  type        = number
  default     = 1
}

variable "publicly_accessible" {
  description = "Whether RDS is publicly accessible"
  type        = bool
  default     = true
}

variable "allowed_client_cidr" {
  description = "Public IP CIDR allowed to connect to PostgreSQL"
  type        = string

  validation {
    condition     = can(cidrhost(var.allowed_client_cidr, 0))
    error_message = "Provide a valid CIDR, such as your-public-ip/32."
  }
}