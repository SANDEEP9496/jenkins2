provider "azurerm" {
    features {}
}

resource "azurerm_role_definition" "example" {
    name        = "example_role"
    scope       = data.azurerm_subscription.primary.id
    description = "Example role"
    
    permissions {
        actions   = ["*"]
        not_actions = []
    }
}

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
