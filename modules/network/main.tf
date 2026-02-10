# VPC
resource "aws_vpc" "cmtr_vkkq9lu1_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.name_prefix}-vpc"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.cmtr_vkkq9lu1_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.public_subnet_azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_prefix}-public-subnet-${local.letters[count.index]}"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "cmtr_vkkq9lu1_igw" {
  vpc_id = aws_vpc.cmtr_vkkq9lu1_vpc.id

  tags = {
    Name = "${local.name_prefix}-igw"
  }
}

# Route Table
resource "aws_route_table" "cmtr_vkkq9lu1_rt" {
  vpc_id = aws_vpc.cmtr_vkkq9lu1_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cmtr_vkkq9lu1_igw.id
  }

  tags = {
    Name = "${local.name_prefix}-rt"
  }
}


resource "aws_route_table_association" "public_subnet" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.cmtr_vkkq9lu1_rt.id
}
