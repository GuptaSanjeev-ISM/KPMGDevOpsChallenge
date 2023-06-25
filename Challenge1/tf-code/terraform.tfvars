location    = "West Europe"
region_code = "weeu"
app_name    = "test"
app_env     = "soln"
environment = "test"

# KV Details
kv_config = {
  "client" = {
    soft_delete_days        = "90"
    purge_protection        = "false"
    sku                     = "standard"
    key_permissions         = ["Get", "List", "UnwrapKey", "WrapKey", "Delete"]
    secret_permissions      = ["Get", "List", "Set", "Delete", "Backup", "Recover", "Purge"]
    certificate_permissions = ["Get", "List", "Backup", "Delete", "Backup", "Create", "Import"]

  },
  "backend" = {
    soft_delete_days        = "90"
    purge_protection        = "false"
    sku                     = "standard"
    key_permissions         = ["Get", "List", "UnwrapKey", "WrapKey", "Delete"]
    secret_permissions      = ["Get", "List", "Set", "Delete", "Backup", "Recover", "Purge"]
    certificate_permissions = ["Get", "List", "Backup", "Delete", "Backup", "Create", "Import"]
  }
}

vm = {
    "client" = {
        size = "Standard_DS2_V2"
        image_os = "linux"
        os_simple = "Debian"
        disable_password_authentication = "false"
        os_disk = {
            name = "client-osdisk"
            caching = "ReadWrite"
            storage_account_type = "Standard_LRS"
        }
    },

    "backend" = {
        size = "Standard_DS2_V2"
        image_os = "linux"
        os_simple = "Debian"
        disable_password_authentication = "false"
        os_disk = {
            name = "backend-osdisk"
            caching = "ReadWrite"
            storage_account_type = "Standard_LRS"
        }
    }    
}

# vnet subnet cidr range
cidr_space = ["10.26.0.0/16"]
# Log WorkSpace for aks cluster

### SQL 
sql_server_config = {
  administrator_login = "dbadmin"
  version             = "12.0"
}

dbs = {
  test = "S1"
}

