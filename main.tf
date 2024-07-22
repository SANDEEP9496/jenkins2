provider "azurerm" {
  features {}
}

# Data Source to retrieve subscription details
data "azurerm_subscription" "primary" {}

# Define the Role Definition
resource "azurerm_role_definition" "example" {
  name        = "Cosmos DB Account Reader Role"
  scope       = data.azurerm_subscription.primary.id
  description = "Example role"
  
  permissions {
    actions = ["*"]
    not_actions = []
  }
}


# Define the Policy Definition (if needed)
resource "azurerm_policy_definition" "example" {
  name         = "example_policy"
  policy_type   = "Custom"
  mode          = "All"
  display_name  = "Example Policy"
  description   = "Example policy description"

  policy_rule = <<POLICY
  {
    "if": {
      "field": "location",
      "equals": "eastus"
    },
    "then": {
      "effect": "deny"
    }
  }
  POLICY
}
