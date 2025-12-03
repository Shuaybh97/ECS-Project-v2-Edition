output "hosted_zone_id" {
  description = "ID of the hosted zone"
  value       = local.zone_id
}

output "hosted_zone_name_servers" {
  description = "Name servers of the hosted zone"
  value       = var.create_hosted_zone ? aws_route53_zone.main[0].name_servers : data.aws_route53_zone.existing[0].name_servers
}

output "domain_name" {
  description = "Primary domain name"
  value       = var.domain_name
}

output "main_record_fqdn" {
  description = "FQDN of the main A record"
  value       = aws_route53_record.main.fqdn
}

output "www_record_fqdn" {
  description = "FQDN of the www A record"
  value       = var.create_www_record ? aws_route53_record.www[0].fqdn : null
}

output "subdomain_record_fqdns" {
  description = "FQDNs of subdomain A records"
  value       = { for k, v in aws_route53_record.subdomains : k => v.fqdn }
}
