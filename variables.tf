variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "project_name" {
  description = "Project name prefix for resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "public_subnet_azs" {
  description = "List of availability zones for public subnets"
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


variable "instance_type" {
  description = "instance type of ec2"
  type        = string
}
variable "allowed_ip_range" {
  description = "list of Ip address range for secure access"
  type        = list(string)
}
