# Terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0" 
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = " >= 3.1.1"
    }  
  }
# Terraform State Storage to Azure Storage Container
    backend "azurerm" {
    resource_group_name  = "storage-rg"
    storage_account_name = "tfstatetrial"
    container_name       = "tfstatefiles"
    # key                  = "terraform.tfstate"
    key                  = "project-3-traffic-manager-terraform.tfstate"
  }
}

# Provider Block
provider "azurerm" {
 features {}          
}


