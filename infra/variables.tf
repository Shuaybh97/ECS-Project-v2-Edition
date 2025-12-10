variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "ecs-project-v2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "container_image" {
  description = "Container image for the application"
  type        = string
  default     = "nginx:latest"
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
  default     = 8080
}