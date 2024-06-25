output "vpc_arn" {
  description = "ARN VPC"
  value       = aws_vpc.main.arn
}

output "vpc_id" {
  description = "ID VPC"
  value       = aws_vpc.main.id
}

# output "public_subnet_a_id" {
#   description = "ID public subnet A"
#   value       = aws_subnet.public_a.id
# }

# output "public_subnet_a_arn" {
#   description = "ARN public subnet A "
#   value       = aws_subnet.public_a.arn
# }

# output "public_subnet_b_id" {
#   description = "ID public subnet B"
#   value       = aws_subnet.public_b.id
# }

# output "public_subnet_b_arn" {
#   description = "ARN public subnet B "
#   value       = aws_subnet.public_b.arn
# }
