output "repository_arn" {
  description = "Full ARN of the repository"
  value       = aws_ecr_repository.main.arn
}

output "repository_name" {
  description = "Name of the repository"
  value       = aws_ecr_repository.main.name
}

output "repository_url" {
  description = "URL of the repository"
  value       = aws_ecr_repository.main.repository_url
}

output "registry_id" {
  description = "Registry ID where the repository was created"
  value       = aws_ecr_repository.main.registry_id
}

output "repository_uri" {
  description = "URI of the repository (same as repository_url)"
  value       = aws_ecr_repository.main.repository_url
}

output "additional_repositories" {
  description = "Map of additional repository details"
  value = {
    for name, repo in aws_ecr_repository.additional : name => {
      arn            = repo.arn
      name           = repo.name
      repository_url = repo.repository_url
      registry_id    = repo.registry_id
    }
  }
}

# Useful for building and pushing images
output "docker_login_command" {
  description = "Command to authenticate Docker with ECR"
  value       = "aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${aws_ecr_repository.main.registry_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com"
}

output "docker_build_and_push_commands" {
  description = "Example commands to build and push Docker image"
  value = [
    "docker build -t ${aws_ecr_repository.main.name} .",
    "docker tag ${aws_ecr_repository.main.name}:latest ${aws_ecr_repository.main.repository_url}:latest",
    "docker push ${aws_ecr_repository.main.repository_url}:latest"
  ]
}

# Data source for current region
data "aws_region" "current" {}
