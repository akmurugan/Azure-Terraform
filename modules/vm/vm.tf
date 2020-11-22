resource "azurerm_windows_virtual_machine" "vm" {
  admin_password        = var.admin_password
  admin_username        = var.admin_username
  location              = var.location
  count                 = "2"
  name                  = "${var.name}-${count.index+1}"
  network_interface_ids = [element(azurerm_network_interface.ni.*.id, count.index)]
  resource_group_name   = var.resource_group_name
  size                  = var.size

  source_image_reference {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2016-Datacenter"
      version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }
}

resource "azurerm_network_interface" "ni" {
  count               = "2"  
  location            = var.location
  name                = "${var.name}-${count.index+1}" 
  resource_group_name = var.resource_group_name

  ip_configuration {
    
    name                          = var.name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}


