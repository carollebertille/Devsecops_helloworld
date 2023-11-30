#!/bin/bash
cd servers 
pwd
terraform init
sleep 1
terraform plan
sleep 1
terraform apply --auto-approve
sleep 1

echo "Creation of servers was successfull"
