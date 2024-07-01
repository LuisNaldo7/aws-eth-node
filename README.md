# aws-eth-node

## Prerequisites

- [Ansible CLI](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

- [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Setup

1. Generate SSH key pair

   ```bash
   ssh-keygen -t rsa -b 4096 -f "$HOME/.ssh/id_rsa_aws_eth_node" -N ''
   ```

1. Initialize Terraform

   _Switch to directory `/terraform`._

   ```bash
   terraform init
   ```

1. Set credentials and export

   _User's access key must have permission to manage ec2 instances (e.g. [AmazonEC2FullAccess](https://docs.aws.amazon.com/aws-managed-policy/latest/reference/AmazonEC2FullAccess.html))_

   ```bash
   export AWS_ACCESS_KEY_ID=
   export AWS_SECRET_ACCESS_KEY=
   ```

## Deployment

### Infrastructure

_Switch to directory `/terraform`._

1. Deploy infrastructure

   ```bash
   terraform plan
   terraform apply
   ```

### Node Software

_Switch to directory `/ansible`._

1. Update hosts in `hosts.ini` with outputs from `terraform apply` command.

1. Rollout clients

   ```bash
   ansible-playbook -i hosts.ini install_nginx.yml
   ```
