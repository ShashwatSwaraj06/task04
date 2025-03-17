terraform {
  required_version = ">= 1.5.7" # Updated based on requirements
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.110.0, < 4.0.0" # Latest compatible version range
    }
  }
}

provider "azurerm" {
  features {}
}