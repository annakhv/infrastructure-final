output "sg_ids" {
  value = [
    for sg in aws_security_group.sg : {
      id   = sg.id
      type = sg.tags["meta"]
      name = sg.name
    }
  ]
}
