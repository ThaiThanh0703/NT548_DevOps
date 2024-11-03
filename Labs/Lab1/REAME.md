# Lab 1: Using Terraform or CloudFormation to manage and deploy AWS architecture

## VPC
Create a VPC instance containing the following:
+ Subnets: contains Public Subnet (connect with Internet Gateway) and Private Subnet (use NAT gateway to connect outside).
+ Internet Gateway: connect with Public Subnet to allow internal resources access Internet.
+ Default Security Group: create a default security group for VPC instance.

## Route Table
Create Route Tables for Public and Private Subnets:
+ Public Subnet Route: routing Internet traffic through Internet Gateway.
+ Private Subnet Route: routing Internet traffic trhough NAT Gateway.

## NAT Gateway
Allow resources in Private Subnet to access Internet while ensuring security.

## EC2
Create EC2 instances in Public and Private Subnets, ensure Public instance can be accessed from Internet, and Private instance can be accessed only from Public instance through SSH or other security methods.

## Security Groups
Create Security Groups to control in/out traffic of EC2 instances
+ Public EC2 Security Group: only allow SSH connection (port 22) from specific IPs.
+ Private EC2 Security Group: allow connection from Public EC2 instance through specific ports.

## Requirements
+ All services must be coded as modules.
+ Ensure security for EC2 instances (configure Security Groups).
+ Test cases are required to verify that each service is deployed successfully.

## How to run source code:
+ Step 1: Enter the access key and secret key in provider.tf inside the workload folder.
+ Step 2: Run the terraform init command in the modules you want to deploy within the modules folder.
+ Step 3: Run the terraform plan command to create a plan for the changes to your infrastructure.
+ Step 4: Use the terraform apply command to implement the changes to your infrastructure.
+ Step 5: Use the terraform test command in the tests folder to check your infrastructure.
+ Step 6: Use the terraform destroy command to delete all infrastructure after use to save resources.


## Project Structure

```
.
├───modules
│   ├───aws-ec2-instance
│   ├───aws-keypair
│   ├───aws-nat-gateway
│   ├───aws-route-table
│   ├───aws-security-group
│   ├───aws-vpc-with-subnets
│   └───tests
└───workload
    │   main.tf             # Main Terraform configuration
    │   outputs.tf          # Output definitions
    │   provider.tf         # Provider definition
    │   terraform.tfvars    # Variable values
    │   variables.tf        # Variable definitions

```

## Prerequisites
1. **Configure AWS credentials**
- You must have the Access key and the Secret Access key of IAM user that has appropriate permissions to deploy AWS infrastructure.
- Configure the AWS credentials on your machine using AWS CLI. If you haven't installed AWS CLI before, [check this link](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

2. **Install Terraform CLI**
- You can install Terraform by downloading the latest version from the [official Terraform website](https://developer.hashicorp.com/terraform/install) (version >= 0.12).
- if you prefer using Docker, you can run Terraform commands via a Docker container by using the official Terraform Docker image: `hashicorp/terraform`.

3. **SSH client to connect to the EC2 instance**
- Most Linux distributions have an SSH client pre-installed (typically `ssh`). 
- For macOS, the SSH client is also built-in. 
- Windows users can use [OpenSSH](https://docs.microsoft.com/windows-server/administration/openssh/openssh_install_firstuse) (available in Windows 10 and above) or other SSH tools such as [PuTTY](https://www.putty.org/).


## Steps to Run the Source

1. **Clone the Repository**
```sh
git clone https://github.com/ThaiThanh0703/NT548_DevOps.git
cd  Labs/Lab1/terraform/workload
```

2. **Modify the variables of nested module**
- Direct to the Terraform code folder (workload folder):
- You can modify values of variables at **terraform.tfvars** file *(read description at variables.tf file for details)* as your demand
- Important, please replace `specific-ip` with your current machine’s IP address (use [WhatIsMyIP](https://www.whatismyip.com/) or run `curl ifconfig.me` to find your public IP).

3. **Apply all nested modules**

- Initialize a new or existing Terraform configuration, setting up the backend and installing provider plugins
```sh
terraform init
```

- [Optional] Format the Terraform configuration files
```sh
terraform fmt
```
- [Optional] Validate the Terraform configuration

```sh
terraform validate
```
- Create an execution plan, showing what actions Terraform will take to reach the desired state defined in the configuration files
```sh
terraform plan
```
- Apply the changes required to reach the desired state of the configuration, as determined by the plan command

```sh
terraform apply
```

## Steps to SSH to Instances
1. **SSH to public instance**
- Locate your private key file (.pem)
- Run this command, if necessary, to ensure your key is not publicly viewable
```sh
chmod 400 <private-key-file>
```
- Connect to your instance using its public IP
```sh
ssh -i <private-key-file> <username>@<public-ip>
```
2. **SSH to private instance**
- You need to SSH to the public instance first, follow the above instruction
- On public instance:
```sh
cd ~/.ssh
```
- SSH to private instance:
```sh
ssh -i <private-key-file> <username>@<private-ip>
```
