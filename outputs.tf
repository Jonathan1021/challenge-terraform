output "vpc_arn" {
  description = "ARN VPC"
  value       = aws_vpc.vpc.arn
}

output "vpc_id" {
  description = "ID VPC"
  value       = aws_vpc.vpc.id
}
