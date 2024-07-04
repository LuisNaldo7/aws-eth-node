output "instance_id" {
  description = "ID of the EC2 instance"
  value       = [for instance in aws_instance.eth_node_ec2 : instance.id]
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = [for instance in aws_instance.eth_node_ec2 : instance.public_ip]
}
