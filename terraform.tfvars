aws_region   = "us-east-1"
project_name = "cmtr-vkkq9lu1"

vpc_cidr = "10.10.0.0/16"



public_subnet_cidrs = ["10.10.1.0/24", "10.10.3.0/24", "10.10.5.0/24"]
public_subnet_azs   = ["us-east-1a", "us-east-1b", "us-east-1c"]

sg_ingress_rules = [

  {
    target_sg_index = 0
    description     = "ssh access"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    use_cidrs       = true
  },

  {
    target_sg_index = 1
    description     = "http access"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    use_cidrs       = true
  },

  {
    target_sg_index   = 2
    description       = "HTTP from public HTTP SG"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    source_sg_indexes = [0, 1]
    use_cidrs         = false
  }
]


instance_type    = "t3.micro"
allowed_ip_range = ["18.153.146.156/32", "109.172.192.49/32"]
