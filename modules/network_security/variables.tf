variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "allowed_ip_range" {
  description = "Allowed IP ranges for SSH and HTTP access"
  type        = list(string)
}

variable "sg_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    description = string
    protocol    = string
  }))
}


variable "project_name" {
  description = "Project or application name"
  type        = string
}
