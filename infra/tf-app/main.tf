resource "azurerm_resource_group" "app" {
  name     = "${var.college_id}-${var.assignment_number}-rg"
  location = var.location
}
