resource "aws_launch_template" "cmtr_vkkq9lu1_template" {
  name_prefix   = "cmtr-vkkq9lu1-template"
  instance_type = "t3.micro"

  vpc_security_group_ids = [
    local.ssh_sg_id,
    local.private_http_sg_id
  ]

  user_data = base64encode(file("./application/user.sh"))

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "cmtr-vkkq9lu1-app-instance"
    }
  }
}

resource "aws_lb" "cmtr_vkkq9lu1_lb" {
  name               = "cmtr-vkkq9lu1-lb"
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [local.public_http_sg_id]

  tags = {
    Name = "cmtr-vkkq9lu1-lb"
  }
}

resource "aws_lb_target_group" "cmtr_vkkq9lu1_tg" {
  name     = "cmtr-vkkq9lu1-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.cmtr_vkkq9lu1_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cmtr_vkkq9lu1_tg.arn
  }
}

resource "aws_autoscaling_group" "cmtr_vkkq9lu1_asg" {
  name              = "cmtr-vkkq9lu1-asg"
  desired_capacity  = 2
  min_size          = 2
  max_size          = 2
  health_check_type = "EC2"

  launch_template {
    id      = aws_launch_template.cmtr_vkkq9lu1_template.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns
    ]
  }

  tag {
    key                 = "Name"
    value               = "cmtr-vkkq9lu1-asg-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "cmtr_vkkq9lu1_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.cmtr_vkkq9lu1_asg.name
  lb_target_group_arn    = aws_lb_target_group.cmtr_vkkq9lu1_tg.arn
}
