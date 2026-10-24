
output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.postgres.endpoint
}

output "rds_address" {
  description = "RDS PostgreSQL hostname"
  value       = aws_db_instance.postgres.address
}

output "rds_port" {
  description = "PostgreSQL port"
  value       = aws_db_instance.postgres.port
}

output "database_name" {
  description = "Environment-specific database name"
  value       = aws_db_instance.postgres.db_name
}

output "rds_identifier" {
  description = "Environment-specific RDS instance identifier"
  value       = aws_db_instance.postgres.identifier
}