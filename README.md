# Solution For KPMG DevOps Challenge
This repo contains solution for KPMG Technical Challenge on Azure Cloud

## Prerequisite:
1. You should have an Azure Account
2. You should have pwsh installed. Tested with v7.2.11.
3. You should have terraform installed. Tested with v1.3.0
4. You should have module az installed. Tested with v2.45.0

## Challenge #1:
1. Customize Terraform Configuration under folder `Challenge1/tf-code` as per your requirement.

2. Run `terraform init` to initialize the Azure provider and download the necessary dependencies.

3. Run `terraform plan` to preview the changes that Terraform will apply to your Azure resources.

4. Run `terraform apply` to apply the changes. Review and validate by entering "yes" when prompted to confirm the deployment.

5. Once it is done, verify that all resources are created.

6. Use `terraform destroy` to destroy all resources when no longer needed.

This script does following things by default as specified in terraform.tfvars. It can be custmozed by modifying configuration: 
1. Creates a resource group.
2. Creates a VNET with 3 Subnets and 3 NSGs for Client, Server and Database respectively under the resource group.
3. Creates 2 key vaults for client and backend respecitively under the resource group.
4. Creates a Azure SQL Server. Under this sql server, it creates a database named kpmgtest.


## Challenge #2:

Execute the script `Challenge2.ps1`
By default, this scripts retrieves complete metadata of the instance by using endpoint as `/metadata/instance`. You can also pass it a particular datakey as endpoint. Example: `Challenge2.ps1 -endpoint /metadata/instance/compute`

## Challenge #3:

Execute the script `Challenge3.ps1`
I have added various tests. You can add your own.

### References:

1. Azure Official VM Module : 
   -  https://registry.terraform.io/modules/Azure/virtual-machine/azurerm/latest 
   -  https://github.com/Azure/terraform-azurerm-virtual-machine
2. Azure Official VNet Module: 
   - https://registry.terraform.io/modules/Azure/vnet/azurerm/latest
   - https://github.com/Azure/terraform-azurerm-vnet
3. Azure Instance Metadata Service: https://learn.microsoft.com/en-us/azure/virtual-machines/instance-metadata-service?tabs=windows
4. Azure Official Instance Metadata samples: https://github.com/microsoft/azureimds/blob/master/IMDSSample.ps1