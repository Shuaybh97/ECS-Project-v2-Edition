variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "hash_key" {
  description = "Hash key (partition key) for the table"
  type        = string
}

variable "range_key" {
  description = "Range key (sort key) for the table"
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
  default     = "dev"
}

variable "attributes" {
  description = "Map of attribute definitions for the DynamoDB table. Each value is an object with 'name' and 'type' (e.g., S, N, B)."
  type = map(object({
    name = string
    type = string
  }))
  default = {}
}