provider "azurerm" {
   features {} 
}
## Create a Key-vault resources & set access policy
module "keyvalut" {
 source              = "../modules/key-vault"
 location            = "centralindia"
 name                = "prod-kv-exc"
 resource_group_name = "Tableau-rg"
 sku_name            = "standard"
 tenant_id           = "24917450-fe15-4414-92ed-94fa8ec1b938"
 object_id           = "c1e6a48a-3ca5-4ed4-9bf9-e0e9f93adf38" 
}

## Create a windows vms using Modules
module "windowsvms" {
  source                = "../modules/vm"
  resource_group_name   = "Tableau-rg"
  location              = "centralindia"
  admin_password        = "P@ssw0rd@123456"
  admin_username        = "testuser"
  name                  = "Prod-vm"
  size                  = "Standard_D2_v4"   
  caching               = "ReadWrite"
  storage_account_type  = "StandardSSD_LRS"
  subnet_id             = "/subscriptions/82131fe1-3837-4fef-a41f-89a636063034/resourceGroups/Tableau-rg/providers/Microsoft.Network/virtualNetworks/tfvnet/subnets/default"
}

## Key-vault Output
output "id" {
  value = module.keyvalut.id
}
## VM's Ouput
output "vm-id" {
   value = module.windowsvms.vm-id
  }
 
output "vm-identity-id" {
  value = module.windowsvms.vm-identity-id
}
 output  "vm-admin_username" {
  value =  module.windowsvms.vm-admin_username
}
output "vm-admin_password" {
  value = module.windowsvms.vm-admin_password
}