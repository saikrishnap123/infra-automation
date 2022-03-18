terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.97.0"
    }
  }
}
provider "azurerm" {
    features {
      
    }
    subscription_id = var.subscription_id
    client_id = var.client_id
    tenant_id = var.tenant_id
    client_secret = var.client_secret
}
variable "subscription_id" {
    type = string
    default = "d35b21a8-cccf-417f-b01a-d7e715291a8b"
    description = "dev subscription"
  
}
variable "client_id" {
    type = string
    default = "21efe399-28c4-4ea4-8a26-15deaec4eaae"
    description = "dev client id"
  
}
variable "tenant_id" {
    type = string
    default = "07c0dda3-392d-49da-b3fc-0146a5484659"
    description = "dev tenant"
  
}
variable "client_secret" {
    type = string
    default = "_LR7Q~fkttRCk_gP_pIoIaVTtDvoIdVvGwELi"
    description = "dev slient secret"
  
}

locals {
  setup_name = "prractice-dev"
}
resource "azurerm_resource_group" "resourcegrouplabel" {
    name = "resourcegroup"
    location = "East Us"
}
resource "azurerm_app_service_plan" "appplan" {
    name = "appplandev"
    location = azurerm_resource_group.resourcegrouplabel.location
    resource_group_name = azurerm_resource_group.resourcegrouplabel.name
    sku {
      tier = "Standard"
      size = "S1"
    }
    depends_on = [
      azurerm_resource_group.resourcegrouplabel
    ]
    tags = {
      name = "${local.setup_name}-appplan"
    }
}
resource "azurerm_app_service" "webapp1" {
    name = "webapp"
    location = azurerm_resource_group.resourcegrouplabel.location
    resource_group_name = azurerm_resource_group.resourcegrouplabel.name
    app_service_plan_id = azurerm_app_service_plan.appplan.id
    depends_on = [
      azurerm_app_service_plan.appplan
    ]

    tags = {
      name = "${local.setup_name}-webapp."
    }
  
}
