
terraform {
  backend "s3" {
    bucket       = "jungle-terraform-bucket"
    key          = "liquibase-samples/dev.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}