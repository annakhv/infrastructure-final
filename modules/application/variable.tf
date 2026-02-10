variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}


variable "sgs" {
  type = list(object({ id = string, type = string, name = string }))
}

variable "instance_type" {
  description = "instance type of ec2"
  type        = string
}
