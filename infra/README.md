# ECS Infrastructure Modules

This Terraform configuration creates a complete ECS infrastructure with the following components:

## Architecture

- **VPC Module**: Creates a VPC with public and private subnets across 2 availability zones
- **ECS Module**: Creates an ECS cluster with Fargate tasks, Application Load Balancer, and supporting resources
- **Route53 Module**: Manages DNS records and hosted zones (optional)
- **ACM Module**: Provides SSL/TLS certificates with automatic validation (optional)

## Components

### VPC Module (`modules/vpc/`)
- VPC with configurable CIDR
- Internet Gateway
- Public subnets with internet access
- Private subnets with NAT gateway access
- Route tables and associations

### ECS Module (`modules/ecs/`)
- ECS Cluster with Container Insights enabled
- ECS Task Definition for Fargate
- ECS Service with desired count
- Application Load Balancer (ALB) with HTTP/HTTPS support
- Target Group with health checks
- Security Groups for ALB and ECS tasks
- CloudWatch Log Group
- IAM roles for task execution and task
- Automatic HTTP to HTTPS redirect (when SSL is enabled)

### Route53 Module (`modules/route53/`) - Optional
- Hosted Zone creation or existing zone usage
- A records for main domain and www subdomain
- Support for additional subdomains
- CNAME, MX, and TXT record creation
- Alias records pointing to the load balancer

### ACM Module (`modules/acm/`) - Optional
- SSL/TLS certificate provisioning
- DNS validation through Route53
- Support for multiple domain names (SAN)
- Automatic certificate validation

## Usage

1. **Initialize Terraform:**
   ```bash
   cd infra
   terraform init
   ```

2. **Plan the deployment:**
   ```bash
   terraform plan
   ```

3. **Deploy the infrastructure:**
   ```bash
   terraform apply
   ```

4. **Access your application:**
   After deployment, the application will be accessible via the ALB DNS name provided in the outputs.

## Customization

### Variables

You can customize the deployment by modifying variables in `variables.tf` or by creating a `terraform.tfvars` file:

```hcl
# terraform.tfvars
aws_region     = "us-west-2"
project_name   = "my-app"
environment    = "production"
container_image = "my-app:latest"
container_port  = 3000

# Optional: Custom Domain & SSL
domain_name              = "example.com"
create_hosted_zone       = true
enable_ssl               = true
subject_alternative_names = ["www.example.com"]
create_www_record        = true
```

### VPC Configuration
- `vpc_cidr`: CIDR block for the VPC (default: 10.0.0.0/16)
- `availability_zones`: AZs to deploy subnets
- `public_subnet_cidrs`: CIDR blocks for public subnets
- `private_subnet_cidrs`: CIDR blocks for private subnets

### ECS Configuration
- `container_image`: Docker image to deploy
- `container_port`: Port your application listens on
- `cpu`: CPU units (256, 512, 1024, etc.)
- `memory`: Memory in MB
- `desired_count`: Number of tasks to run

### Domain & SSL Configuration (Optional)
- `domain_name`: Your custom domain name (e.g., "example.com")
- `create_hosted_zone`: Whether to create a new Route53 hosted zone
- `enable_ssl`: Enable HTTPS with ACM certificate
- `subject_alternative_names`: Additional domains for the certificate
- `create_www_record`: Create www subdomain record

## SSL/HTTPS Setup

To enable HTTPS with a custom domain:

1. **Set domain variables:**
   ```hcl
   domain_name        = "yourdomain.com"
   enable_ssl         = true
   create_hosted_zone = true  # or false if using existing zone
   ```

2. **Deploy infrastructure:**
   ```bash
   terraform apply
   ```

3. **Update DNS (if using existing domain registrar):**
   If `create_hosted_zone = true`, update your domain's nameservers to point to the Route53 hosted zone nameservers (shown in outputs).

4. **Certificate validation:**
   The ACM certificate will be automatically validated via DNS records created in Route53.

5. **Access your site:**
   Your application will be available at both:
   - `https://yourdomain.com`
   - `https://www.yourdomain.com` (if `create_www_record = true`)
   
   HTTP requests are automatically redirected to HTTPS.

## Outputs

- `vpc_id`: VPC ID
- `public_subnet_ids`: Public subnet IDs
- `private_subnet_ids`: Private subnet IDs
- `ecs_cluster_name`: ECS cluster name
- `load_balancer_dns_name`: ALB DNS name
- `application_url`: Complete URL to access the application

## Security

- ALB accepts traffic on port 80 from anywhere
- ECS tasks only accept traffic from the ALB security group
- Tasks run in private subnets with no direct internet access
- NAT gateways provide outbound internet access for updates

## Monitoring

- Container Insights enabled on ECS cluster
- CloudWatch logs configured for container output
- ALB target group health checks configured

## Clean Up

To destroy the infrastructure:

```bash
terraform destroy
```

**Note**: Make sure to backup any important data before destroying the infrastructure.
