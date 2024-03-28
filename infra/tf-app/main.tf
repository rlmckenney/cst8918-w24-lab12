variable "resource_prefix" {
  type = string
  default = "${var.college_id}-${var.assignment_number}"
  description = "unique prefix for all resources"
}

resource "azurerm_resource_group" "app" {
  name     = "${var.resource_prefix}-rg"
  location = var.location
}
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_prefix}-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.resource_prefix}-test-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
