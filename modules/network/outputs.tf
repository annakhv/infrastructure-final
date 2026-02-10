output "vpc_id" {
  value = aws_vpc.cmtr_vkkq9lu1_vpc.id
}

output "subnet_ids" {
  description = "IDs of all public subnets"
  value       = [for s in aws_subnet.public : s.id]
}

