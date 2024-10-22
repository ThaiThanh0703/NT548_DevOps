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
