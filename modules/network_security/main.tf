
resource "aws_security_group" "sg" {
  count       = length(local.security_groups)
  name        = "${var.project_name}-${local.security_groups[count.index].name_suffix}"
  description = "Allow ${local.security_groups[count.index].name_suffix} access"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = var.sg_ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = local.sg_cidrs[count.index]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${local.security_groups[count.index].name_suffix}"
    meta = local.security_groups[count.index].type
  }
}

