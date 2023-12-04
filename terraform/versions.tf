terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.78.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "RG1"
  #   storage_account_name = "tfstatevskcz"
  #   container_name       = "tfstate"
  #   key                  = "terraform.tfstate"

  # }
}