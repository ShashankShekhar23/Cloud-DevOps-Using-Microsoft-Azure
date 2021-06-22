# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Getting Started
1. Clone this repository

2. Create your infrastructure as code

3. Update this README to reflect how someone would use your code.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions

**STEPS TO GATHER CREDENTIALS TO BE USED IN PACKER FILE
1. Once Azure CLI installed in your local system, run the command prompt.
2. Type "az login" so that Azure CLI can be authenticated.
3. Once authenticated, type "az group create -n <resource_group_name> -l <location_for_your_resource_group" to create resource group that will be used in Packer file. For example, "az group create -n packer-rg -l eastus"
4. After creating resource group, type "az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"" to create service principal so that Packer authenticates with Azure
5. Now, you will get the required information that will be needed in your Packer file.

**STEPS TO BUILD PACKER FILE IN AZURE CLI
1. Make sure that the Packer file is created in .json format
2. Please include the correct credentials in the Packer file
3. Also place the Packer file(.json file) in the path where your Packer application(.exe file) has been installed.
4. Now run command prompt in your local system
5. Type "az login" so that Azure CLI can be authenticated.
6. Once authentiicated, go the directory where you have your Packer file(.json) have been placed.
7. Type "packer build <filename>.json" to build the image of your resources. For example, "packer build server.json".
8. Type "az image list" to view the images that were created using Packer.
9. To delete the images using Packer, type "az image delete -g <resource_group_name> -n <image_name>". For example, "az image delete -g packer-rg -n myPackerImage".

**STEPS TO DEPLOY RESOURCES USING TERRAFORM 
1. Make sure that the Terraform file is created in .tf format
2. Create "main.tf" file to include the resources that will be created using Terraform
3. Create "vars.tf" file to include the variables that are defined in the "main.tf" file
4. Also place the Terraform files(.tf files) in the path where your Terraform application(.exe file) has been installed.
5. Now run command prompt in your local system
6. Type "az login" so that Azure CLI can be authenticated.
7. Once authentiicated, go the directory where you have your Terraform file(.json) have been placed.
8. Type "terraform init" to initiate the Terraform using Azure CLI.
9. Type "terraform plan -out main.tf" to view the resources that will be created using Terraform.
10. Provide the values to the variables that have been declared in the "vars.tf" file. Using these values, your resources will be created.
11. Type "terraform apply main.tf" to create the resources using Terraform.
12. Once the resources have been crated, you can verify them in the Azure Portal or in Azure CLI by typing "terraform show".
13. To destroy the resources that were created by Terraform, you can use" terraform destroy".
14. After getting the list of resources that will be deleted using Terraform, you will get prompt messgae to type "yes" to ensure the deletion of resources.

 **STEPS TO CHANGE VARS.TF FILE
 1. You may need to define variables in the main.tf file in order to keep your code DRY(Don't Repeat Yourself)
 2. You need to specify the keyword "variable" in order to declare in the vars.tf file
 3. You can declare a variable in vars.tf file using below example,
  variable "location" {
  description = "The Azure Region in which all resource should be created."
  default     = "East US"
}
  Note: Default values can also be passed to the variables in case you do not want to provide during the planning stage
 4. You can declare the variables as per your convenience in the vars.tf file

### Output
You can verify the images and resources created via Packer and Terraform respectively using the Azure CLI or Azure Portalby.
To verify iamges created using Packer, type "az image list" in Azure CLI.
To verify resources created using Terraform, type "terraform show" in Azure CLI.
