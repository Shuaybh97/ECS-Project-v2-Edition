variable "region" {
  description = "AWS region to deploy backend resources"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "ecs-assignment-v2"
}

variable "environment" {
  description = "Environment tag (e.g. dev, prod)"
  type        = string
  default     = "dev"
}

variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
  default     = "Shuaybh97"
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
  default     = "ECS-Project"
}
