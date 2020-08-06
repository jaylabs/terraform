output "private_dns" {
  description = "List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = aws_instance.rabbitmq.*.private_dns
}

output "tags" {
  description = "List of tags of instances"
  value       = aws_instance.rabbitmq.*.tags
}
