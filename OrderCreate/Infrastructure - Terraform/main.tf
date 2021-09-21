terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
    
  }
}


provider "azurerm" {
    features {}
}

data "azurerm_key_vault" "terrakv" {
  name                = "Dev-Ecomm-KV" // KeyVault name
  resource_group_name = "mykv" // resourceGroup
}

data "azurerm_key_vault_secret" "kvsecret" {
    name = "Dev-Ecomm-KV" // Name of secret
    key_vault_id = data.azurerm_key_vault.terrakv.id
}

resource "azurerm_static_site" "website" {
  name                = "website"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  kind                  = "functionApp"
  identity              =  {
        "type": "SystemAssigned"
  },
  properties            =  {
        "httpsOnly": "true",
        "clientAffinityEnabled": false
  }
 
  tags                  = {

        "Application Owner": "App Dev",
        "Business Unit": "Ecommerce",
        "Deployed By": var.deployedBy,
        "Environment": var.environment,
        "Infrastructure": "Function App",
        "Project": "Ecommerce",
        "Resource Owner": "App Dev",
        "SLA Tier": "3.14"
  }
}