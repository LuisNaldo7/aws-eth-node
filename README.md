# aws-eth-node

## Prerequisites

- [Ansible CLI](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

- [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

- [AWS Account](https://eu-central-1.console.aws.amazon.com/console/home)

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

1. Update hosts IPs in [inventory.yml](ansible/inventory.yml) with outputs from `terraform apply` command.

1. Rollout and configure full node using playbook `setup-node.yml`

   ```bash
   ansible-playbook -i inventory.yml playbooks/setup-node.yml
   ```

## Check Setup

Set environment variables

_Replace `public_host_ip` with host to be checked._

```bash
export host=public_host_ip
export rpc_port=8545
```

### Check Node via RPC

_Execute from any host_

- Node health

   ```bash
   curl -I $host:$rpc_port/health
   ```

- Synching status

   ```bash
   curl -X POST --data '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}' $host:$rpc_port
   ```

### Check Service Logs

Log into vm

   ```bash
   ssh ubuntu@$host
   ```

- Check Nethermind logs

   ```bash
   journalctl -u nethermind.service -n 100 --no-pager -f
   ```

- Check Nimbus logs

   ```bash
   journalctl -u nimbus_beacon.service -n 100 --no-pager -f
   ```

## Client Updates

_Switch to directory `/ansible`. Playbook `setup-node.yml` must have been executed at least once before proceeding!_ 

1. Open [inventory.yml](ansible/inventory.yml) and update both variables `release_version` and the 8 digit `commit_hash` of the respective client to update. You'll find example values as comments.

1. Update clients using playbook `update-clients.yml`. If a client's `release_version` is unchanged the update procedure will be skipped.

   ```bash
   ansible-playbook -i inventory.yml playbooks/update-clients.yml
   ```

## Open Tasks

- secure default user
- run clients with unprivileged user
- automate updating host ips after `terraform apply`
