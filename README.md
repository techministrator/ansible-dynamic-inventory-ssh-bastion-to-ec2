# Ansible Dynamic Inventory for EC2 Instance with SSH Bastion Host in Multi-Regions

If you have any questions just let me know. I put this here for personal reference only. 

This repository is a the sample code of using Ansible Dynamic Inventory with the below requirements:
- Able to execute command or run Ansible Playbooks to AWS EC2 Instances via the SSH Bastion Hosts
- EC2 Instances are deployed in multi regions 

## Requirements before Use
- Make sure all SSH private keys for ec2 instances regions are placed within `/home/ubuntu/.ssh/` directory or edit the SSH keys directory or change it any way you like. 

My `/home/ubuntu/.ssh/` looks like this. 
```bash
$ ls /home/ubuntu/.ssh/
authorized_keys         canchain-admin-can.pem     canchain-admin-ind.pem  canchain-admin-swe.pem     
canchain-admin-aus.pem  canchain-admin-deu.pem     canchain-admin-jpn.pem  canchain-admin-usacali.pem
canchain-admin-bhr.pem  canchain-admin-gbrldn.pem  canchain-admin-kor.pem  canchain-admin-usaohio.pem
canchain-admin-bra.pem  canchain-admin-hkg.pem     canchain-admin-sgp.pem  canchain-admin-usavir.pem
```

### Test Connection

The below simple playbook command collect all SSH Bastion Hosts public ip addresses "dynamically" via `ec2_metadata_facts` module and then supply those Public IP addresses as variables to each master bp group variable files. So these Master BPs can be used with Ansible via Bastion Hosts Proxy. (Currently BPs don't expose any port to the Internet) 

```bash
$ ansible-playbook -e "bastion_name=all_SSH_Bastion_Host" -e "group_name=all_Master_Block_Producer" playbook_ping_test.yml 
```

### Create Snapshot for Block Producer(s) Only

For individual Block Producer
```bash
$ ansible-playbook -e "bastion_name=bastion_ap_southeast_1" -e "group_name=block_producer_ap_southeast_1" playbook/block_producer_create_snapshot.yml
```

For all Block Producers 
```bash
$ ansible-playbook -e "bastion_name=all_SSH_Bastion_Host" -e "group_name=all_Master_Block_Producer" playbook/block_producer_create_snapshot.yml
```
