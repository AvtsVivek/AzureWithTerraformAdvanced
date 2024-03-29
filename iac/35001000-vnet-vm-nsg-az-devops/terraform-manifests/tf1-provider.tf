# Terraform Block
terraform {
  # required_version = ">= 1.0.0"
  # The right most version upgrade is allowed by the following.
  # So for production, the following should be used with ~> 1.0.0
  # https://stackoverflow.com/q/72975317/1977871
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0"
    }
  }
  # Terraform State Storage to Azure Storage Container (Values will be taken from Azure DevOps)
  backend "azurerm" {

  }
}

# Provider Block
provider "azurerm" {
  features {}
}


