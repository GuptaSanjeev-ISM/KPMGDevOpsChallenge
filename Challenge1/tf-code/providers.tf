terraform {
  # Set the terraform required version
  required_version = ">= 1.0.0"

  # Register common providers
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.7.0"
    }
  }
}

# Configure the Azure Provider
provider "azurerm" {
  features {}
}
