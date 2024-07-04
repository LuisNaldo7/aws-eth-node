variable "num_instances" {
  description = "The amount of instances to spin up"
  default     =  2
}

variable "instance_name_eth_node" {
  description = "Name for the EC2 instance"
  type        = string
  default     = "Ethereum Full Node"
}

variable "instance_ami" {
  description = "The instance type to use"
  default     =  "ami-01e444924a2233b07" # Ubuntu 24.04 LTS
}

variable "instance_type" {
  # https://aws.amazon.com/de/ec2/instance-types/
  description = "The instance type to use"
  default     = "t3.xlarge" # Xeon,4 vCPU,16gb RAM
}

variable "volume_type" {
  # https://docs.aws.amazon.com/ebs/latest/userguide/ebs-volume-types.html
  description = "Storage type"
  default     = "gp2" # SSD 250 MiB/s
}

variable "volume_size" {
  description = "Storage size in GiB"
  default     = "200"
}

variable "key_name" {
  description = "The name of the key pair to use"
  default     = "ansible-master"
}

variable "public_key_path" {
  description = "The path to the public key file"
  default     = "~/.ssh/id_rsa_aws_eth_node.pub"
}

variable "private_key_path" {
  description = "The path to the private key file"
  default     = "~/.ssh/id_rsa_aws_eth_node"
}
