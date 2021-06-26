provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  count    = var.number
  name     = "${var.prefix}-${count.index}-resources"
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "main" {
  count               = var.number
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/22"]
  location            = azurerm_resource_group.main[count.index].location
  resource_group_name = azurerm_resource_group.main[count.index].name
}

resource "azurerm_subnet" "internal" {
  count                = var.number
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main[count.index].name
  virtual_network_name = azurerm_virtual_network.main[count.index].name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "main" {
  count               = var.number
  name                = "${var.prefix}-security-group"
  location            = azurerm_resource_group.main[count.index].location
  resource_group_name = azurerm_resource_group.main[count.index].name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "main" {
  count               = var.number
  name                = "${var.prefix}-nic"
  resource_group_name = azurerm_resource_group.main[count.index].name
  location            = azurerm_resource_group.main[count.index].location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal[count.index].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "main" {
  count               = var.number
  name                = "${var.prefix}-public-ip"
  resource_group_name = azurerm_resource_group.main[count.index].name
  location            = azurerm_resource_group.main[count.index].location
  allocation_method   = "Static"
}

resource "azurerm_lb" "main" {
  count               = var.number
  name                = "${var.prefix}-lb"
  location            = "West US"
  resource_group_name = azurerm_resource_group.main[count.index].name
}

resource "azurerm_availability_set" "main" {
  count               = var.number
  name                = "${var.prefix}-avset"
  location            = azurerm_resource_group.main[count.index].location
  resource_group_name = azurerm_resource_group.main[count.index].name
}

data "azurerm_resource_group" "image" {
  name = "packer-rg"
}

data "azurerm_image" "image" {
  name                = "myPackerImage"
  resource_group_name = data.azurerm_resource_group.image.name
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = "${var.prefix}-${count.index}-vm"
  resource_group_name             = azurerm_resource_group.main[count.index].name
  location                        = azurerm_resource_group.main[count.index].location
  count                           = "${var.number}"
  size                            = "Standard_F2"
  tags                            = "${var.tags}"
  admin_username                  = "${var.usr}"
  admin_password                  = "${var.pwd}"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.main[count.index].id,
  ]

 storage_profile_image_reference {
    id=data.azurerm_image.image.id
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}

resource "azurerm_managed_disk" "main" {
  count                = var.number
  name                 = "${var.prefix}-disk"
  location             = azurerm_resource_group.main[count.index].location
  resource_group_name  = azurerm_resource_group.main[count.index].name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}
