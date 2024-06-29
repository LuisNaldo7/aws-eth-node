# aws-eth-node

## Setup

1. Install [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

1. Initialize Terraform

   Run command inside `/terraform`

   ```bash
   terraform init
   ```

1. Generate SSH key pair

   ```bash
   ssh-keygen -t rsa -b 4096 -f "$HOME/.ssh/id_rsa_aws_eth_node" -N ''
   ```

1. Set credentials and export

   Access key must have permission to launch and update ec2 instances (e.g. [AmazonEC2FullAccess](https://docs.aws.amazon.com/aws-managed-policy/latest/reference/AmazonEC2FullAccess.html))

   ```bash
   export AWS_ACCESS_KEY_ID=
   export AWS_SECRET_ACCESS_KEY=
   ```

## Deployment

1. Deploy infrastructure

   Run commands inside `/terraform`

   ```bash
   terraform plan
   terraform apply
   ```
