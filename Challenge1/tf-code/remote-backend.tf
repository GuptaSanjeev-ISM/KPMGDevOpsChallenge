terraform {
  backend "azurerm" {
    resource_group_name  = "rg-sanjeev-test"
    storage_account_name = "hkdtestsanjeev"
    container_name       = "hkd-tf-state-container"
    key                  = "st-tf-test-solution-weeu.tfstate"
  }
}
