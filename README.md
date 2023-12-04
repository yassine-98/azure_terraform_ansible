# Terraform_Ansible_Azure

## Project Overview:

The goal of this project is to provision a virtual machine in Azure using Terraform and configure this virtual machine with Ansible. The aim is to install and run Docker inside the provisioned virtual machine.

## 1. Prerequisites:

- Ensure Terraform is installed on your local machine.
# Terraform_Ansible_Azure

## Project Overview:

The goal of this project is to provision a virtual machine in Azure using Terraform and configure this virtual machine with Ansible. The aim is to install and run Docker inside the provisioned virtual machine.

## 1. Prerequisites:

- Ensure Terraform is installed on your local machine.
- Make sure to have an Azure subscription and the necessary credentials.
- Install Ansible on your local machine.

### Steps:

1. Configure Azure credentials for Terraform.
   - [Azure Provider Configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret)
   - In my case, I have performed the authentication with Azure using the command: az login.   
2. Set up Ansible for configuration management.
   - Install Ansible:
     ```bash
     sudo apt-get update
     sudo apt-get install ansible
     ```

## 2. Project Execution:

- Navigate to the Terraform directory:
  ```bash
  cd terraform/
  ```

- Initialize Terraform:
  ```bash
  terraform init
  ```

- Plan the Terraform configuration:
  ```bash
  terraform plan
  ```  

- Apply the Terraform configuration to provision the virtual machine:
  ```bash
  terraform apply
  ```

- Navigate to the Ansible directory:
  ```bash
  cd ansible/
  ```

- Execute Ansible playbook to configure the virtual machine and install Docker:
  ```bash
  ansible-playbook playbooks/config_vm.yml
  ```

Feel free to customize the project structure or add more details as needed.
