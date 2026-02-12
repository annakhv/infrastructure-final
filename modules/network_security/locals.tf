locals {
  security_groups = [
    { name_suffix = "ssh-sg", type = "public" },
    { name_suffix = "public-http-sg", type = "public" },
    { name_suffix = "private-http-sg", type = "private" }
  ]



  sg_to_sg_rules = flatten([
    for rule_index, rule in tolist(var.sg_ingress_rules) : (
      lookup(rule, "source_sg_indexes", null) != null
      ? [
        for src_index in rule.source_sg_indexes : {
          key             = "${rule_index}-sg-${src_index}"
          target_sg_index = rule.target_sg_index
          source_sg_index = src_index
          description     = rule.description
          from_port       = rule.from_port
          to_port         = rule.to_port
          protocol        = rule.protocol
        }
      ]
      : [] # skip iteration if null
    )
  ])



  # Flatten CIDR rules: one rule per CIDR
  cidr_rules = flatten([
    for rule_index, rule in var.sg_ingress_rules : (
      rule.use_cidrs == true ? [
        for cidr in var.allowed_ip_range : {
          key             = "${rule_index}-cidr-${cidr}"
          target_sg_index = rule.target_sg_index
          description     = rule.description
          from_port       = rule.from_port
          to_port         = rule.to_port
          protocol        = rule.protocol
          cidr            = cidr
        }
      ] : []
    )
  ])

}
