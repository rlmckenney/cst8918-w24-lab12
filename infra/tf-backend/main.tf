terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.96.0"
    }
  }

  required_version = "~> 1.5"
}

provider "azurerm" {
  features {}
  subscription_id = "7fe3d54b-9073-439d-b4e2-db9518e357aa"
}

# Create a Resource Group
resource "azurerm_resource_group" "githubactions_rg" {
  name     = "barb0238-githubactions-rg"
  location = "westus3" # Change to your preferred location
}

resource "azurerm_virtual_network" "githubactions_vnet" {
  name = "barb0238-githubactions-vnet"
  resource_group_name = azurerm_resource_group.githubactions_rg.name
  location = "westus3"
  address_space = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "githubactions_subnet" {
  name = "barb0238-githubactions-subnet"
  resource_group_name = azurerm_resource_group.githubactions_rg.name
  virtual_network_name = azurerm_virtual_network.githubactions_vnet.name
  address_prefixes = ["10.0.1.0/24"]
}



# Create a Storage Account
resource "azurerm_storage_account" "githubactions" {
  name                     = "barb0238githubactions"
  resource_group_name      = azurerm_resource_group.githubactions_rg.name
  location                 = azurerm_resource_group.githubactions_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = {
    environment = "Terraform Demo"
  }
}

# Create a Storage Container
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.githubactions.name
  container_access_type = "private"
}

# Output the Resource Group Name
output "resource_group_name" {
  value = azurerm_resource_group.githubactions_rg.name
}

# Output the Storage Account Name
output "storage_account_name" {
  value = azurerm_storage_account.githubactions.name
}

# Output the Storage Container Name
output "container_name" {
  value = azurerm_storage_container.tfstate.name
}

# Output the Primary Access Key of the Storage Account
output "storage_account_primary_access_key" {
  value     = azurerm_storage_account.githubactions.primary_access_key
  sensitive = true
}