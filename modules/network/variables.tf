variable "allowed_ip_range" {
  description = "list of Ip address range for secure access"
  type        = list(string)
}

variable "project_name" {
  description = "Project or application name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}


variable "public_subnet_azs" {
  description = "availability zones"
  type        = list(string)
}
variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
}

