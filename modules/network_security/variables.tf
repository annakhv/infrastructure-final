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
    target_sg_index   = number # index of the target SG
    description       = string
    from_port         = number
    to_port           = number
    protocol          = string
    source_sg_indexes = optional(list(number)) # list of source SG indexes
    use_cidrs         = optional(bool)         # allow CIDR blocks
  }))
}


variable "project_name" {
  description = "Project or application name"
  type        = string
}
