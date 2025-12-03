locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

  full_project_name = "${var.project_name}-${var.environment}"
}