locals {
  security_groups = [
    { name_suffix = "ssh-sg", type = "public" },
    { name_suffix = "public-http-sg", type = "public" },
    { name_suffix = "private-http-sg", type = "private" }
  ]

  sg_cidrs = [
    for sg in local.security_groups :
    sg.type == "public" ? var.allowed_ip_range : null
  ]
}
