module "ecr" {
  source = "./modules/ecr"

  project_name    = local.full_project_name
  repository_name = "${local.full_project_name}-app"
  
  image_tag_mutability = "IMMUTABLE"
  scan_on_push         = true
  encryption_type      = "AES256"
}


module "dynamodb" {
  source = "./modules/dynamodb"

  table_name = "${local.full_project_name}-table"
  hash_key   = "url"
  
  attributes = [
    {
      name = "url"
      type = "S"
    }
  ]
  
  environment = var.environment
}

module "vpc" {
  source = "./modules/vpc"

  project_name = local.full_project_name
  vpc_cidr     = "10.0.0.0/16"
  
  availability_zones = [
    "${var.aws_region}a",
    "${var.aws_region}b"
  ]
  
  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
  
  private_subnet_cidrs = [
    "10.0.10.0/24",
    "10.0.20.0/24"
  ]
}

module "alb" {
  source = "./modules/alb"

  project_name       = local.full_project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  
  target_port     = var.container_port
  target_protocol = "HTTP"
  target_type     = "ip"
  
  health_check_path = "/"
  
  enable_deletion_protection = false
}

module "ecs" {
  source = "./modules/ecs"

  project_name       = local.full_project_name
  region             = var.aws_region
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  
  target_group_arn      = module.alb.target_group_arn
  alb_security_group_id = module.alb.security_group_id
  
  # DynamoDB Integration
  dynamodb_table_arn = module.dynamodb.table_arn
  
  container_name  = "app"
  container_image = var.container_image
  container_port  = var.container_port
  
  cpu    = "256"
  memory = "512"
  
  desired_count = 2
  
  health_check_path = "/"
  
  environment_variables = [
    {
      name  = "ENVIRONMENT"
      value = var.environment
    },
    {
      name  = "TABLE_NAME"
      value = module.dynamodb.table_name
    },
    {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_region
    }
  ]
}