terraform {
    cloud {
        organization = "ACME_andre_faria"

        workspaces {
            name = "ws-database"
        }
    }

    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.109.0"
        }
    }
}

provider "azurerm"{
    features {}
}

resource "azurerm_resource_group" "az_rg" {
  name = var.sql_rg_name
  location = var.az_region
}

resource "azurerm_mssql_server" "az_sqlserver" {
  name = var.sql_server_name
  resource_group_name = azurerm_resource_group.az_rg.name
  location = var.az_region
  version = "12.0"
  administrator_login        = var.sql_admin_login
  administrator_login_password = var.sql_admin_pw
}

resource "azurerm_mssql_database" "inventory" {
  name           = var.sql_db_name
  server_id      = azurerm_mssql_server.az_sqlserver.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "BasePrice"
  read_scale     = false
  sku_name       = "Basic"
  zone_redundant = false

  # Prevent accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}

output "name" {
  value = azurerm_mssql_server.az_sqlserver.fully_qualified_domain_name
}