
aws_region             = "ap-south-1"
project_name           = "liquibase-samples"
environment            = "prod"

db_name                = "liquibasedb"
db_username            = "dbadmin"
db_instance_class      = "db.t3.small"
db_allocated_storage   = 20

publicly_accessible    = true
allowed_client_cidr    = "YOUR_PUBLIC_IP/32"

multi_az               = true
backup_retention_days  = 7