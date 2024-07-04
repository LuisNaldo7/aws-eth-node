resource "aws_instance" "eth_node_ec2" {
  count         = var.num_instances 
  ami           = var.instance_ami 
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh_keypair.key_name

  vpc_security_group_ids = [
    aws_security_group.eth_node_rpc_sg.id,
    aws_security_group.eth_node_ssh_sg.id,
    aws_security_group.eth_node_protocol_consensus_sg.id,
    aws_security_group.eth_node_protocol_execution_sg.id
  ]

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
    encrypted   = true
  }

  tags = {
    Name = "${var.instance_name_eth_node} ${count.index + 1}"
  }
}


resource "aws_key_pair" "ssh_keypair" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}