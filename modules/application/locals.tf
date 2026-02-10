locals {
  ssh_sg_id = one([
    for sg in var.sgs : sg.id
    if sg.name != null && sg.name != "" && can(sg.name) && endswith(sg.name, "ssh-sg")
  ])

  private_http_sg_id = one([
    for sg in var.sgs : sg.id
    if sg.name != null && sg.name != "" && can(sg.name) && endswith(sg.name, "private-http-sg")
  ])

  public_http_sg_id = one([
    for sg in var.sgs : sg.id
    if sg.name != null && sg.name != "" && can(sg.name) && endswith(sg.name, "public-http-sg")
  ])
}
