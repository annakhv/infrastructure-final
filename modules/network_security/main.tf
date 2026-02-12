
resource "aws_security_group" "sg" {
  count       = length(local.security_groups)
  name        = "${var.project_name}-${local.security_groups[count.index].name_suffix}"
  description = "Allow ${local.security_groups[count.index].name_suffix} access"
  vpc_id      = var.vpc_id

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

resource "aws_security_group_rule" "sg_ingress" {
  for_each = { for r in local.sg_to_sg_rules : r.key => r }

  type                     = "ingress"
  security_group_id        = aws_security_group.sg[each.value.target_sg_index].id
  source_security_group_id = aws_security_group.sg[each.value.source_sg_index].id

  description = each.value.description
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
}

resource "aws_security_group_rule" "cidr_ingress" {
  for_each = { for r in local.cidr_rules : r.key => r }

  type              = "ingress"
  security_group_id = aws_security_group.sg[each.value.target_sg_index].id
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = [each.value.cidr]
}
