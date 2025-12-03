variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "domain_name" {
  description = "Primary domain name"
  type        = string
}

variable "create_hosted_zone" {
  description = "Whether to create a new hosted zone or use existing one"
  type        = bool
  default     = false
}

variable "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  type        = string
}

variable "load_balancer_zone_id" {
  description = "Zone ID of the load balancer"
  type        = string
}

variable "create_www_record" {
  description = "Whether to create a www subdomain record"
  type        = bool
  default     = true
}

variable "subdomain_names" {
  description = "List of subdomain names to create A records for"
  type        = list(string)
  default     = []
}

variable "cname_records" {
  description = "Map of CNAME records to create"
  type        = map(string)
  default     = {}
}

variable "mx_records" {
  description = "List of MX records for email"
  type        = list(string)
  default     = []
}

variable "txt_records" {
  description = "Map of TXT records to create"
  type        = map(list(string))
  default     = {}
}
