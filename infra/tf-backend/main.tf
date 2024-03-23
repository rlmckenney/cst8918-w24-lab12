terraform {
  required_version = "~> 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.96.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "college_id" {
  description = "A prefix to add to all resources"
  type        = string
  default     = "mckennr"
}

resource "azurerm_resource_group" "backend-rg" {
  name     = "${var.college_id}-githubactions-rg"
  location = "westus3"
}

resource "azurerm_storage_account" "backend-storage" {
  name                     = "${var.college_id}githubactions"
  resource_group_name      = azurerm_resource_group.backend-rg.name
  location                 = azurerm_resource_group.backend-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "backend-container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.backend-storage.name
  container_access_type = "private"
}

output "resource_group_name" {
  value       = azurerm_resource_group.backend-rg.name
  description = "The name of the resource group"
}

output "storage_account_name" {
  value       = azurerm_storage_account.backend-storage.name
  description = "The name of the storage account"
}

output "container_name" {
  value       = azurerm_storage_container.backend-container.name
  description = "The name of the container"
}

output "arm_access_key" {
  value       = azurerm_storage_account.backend-storage.primary_access_key
  sensitive   = true
  description = "The ARM access key for the storage account. Put this in GitHub Secrets"
}
