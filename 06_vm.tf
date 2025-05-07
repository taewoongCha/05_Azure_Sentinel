resource "azurerm_linux_virtual_machine" "team4_bat" {
  name                            = "team4-bat"
  resource_group_name             = azurerm_resource_group.team4_rg.name
  location                        = azurerm_resource_group.team4_rg.location
  size                            = "Standard_F1s"
  admin_username                  = "team4"
  disable_password_authentication = true
  admin_ssh_key {
    username   = "team4"
    public_key = file("./files/id_rsa.pub")
  }
  network_interface_ids = [
    azurerm_network_interface.team4_bat_nic.id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  identity {
    type = "SystemAssigned"
  }
  source_image_reference {
    publisher = "resf"
    offer     = "rockylinux-x86_64"
    sku       = "9-base"
    version   = "9.3.20231113"
  }
  plan {
    name      = "9-base"
    product   = "rockylinux-x86_64"
    publisher = "resf"
  }
  provisioner "file" {
    source      = "./files/init.yml"
    destination = "/home/team4/init.yml"

    connection {
      type        = "ssh"
      user        = "team4"
      private_key = file("./files/id_rsa")
      host        = azurerm_public_ip.team4_pubip_bat.ip_address
    }
  }
  
    provisioner "file" {
    source      = "./files/ftp_serv.yml"
    destination = "/home/team4/ftp.yml"

    connection {
      type        = "ssh"
      user        = "team4"
      private_key = file("./files/id_rsa")
      host        = azurerm_public_ip.team4_pubip_bat.ip_address
    }
  }
  
  provisioner "file" {
    source      = "./files/httpd.yml"
    destination = "/home/team4/httpd.yml"

    connection {
      type        = "ssh"
      user        = "team4"
      private_key = file("./files/id_rsa")
      host        = azurerm_public_ip.team4_pubip_bat.ip_address
    }
  }

  provisioner "file" {
    source      = "./files/nginx.yml"
    destination = "/home/team4/nginx.yml"

    connection {
      type        = "ssh"
      user        = "team4"
      private_key = file("./files/id_rsa")
      host        = azurerm_public_ip.team4_pubip_bat.ip_address
    }
  }

  provisioner "file" {
    source      = "./files/id_rsa"
    destination = "/home/team4/.ssh/id_rsa"

    connection {
      type        = "ssh"
      user        = "team4"
      private_key = file("./files/id_rsa")
      host        = azurerm_public_ip.team4_pubip_bat.ip_address
    }
  }

  provisioner "file" {
    source      = "./files/init.yml"
    destination = "/home/team4/init.yml"

    connection {
      type        = "ssh"
      user        = "team4"
      private_key = file("./files/id_rsa")
      host        = azurerm_public_ip.team4_pubip_bat.ip_address
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 600 /home/team4/.ssh/id_rsa",
      "sudo yum install -y epel-release",
      "sudo yum install -y ansible",
      "sudo chown team4:team4 /home/team4/.ssh/id_rsa",
      "sudo ansible-playbook /home/team4/init.yml",
      "sudo ansible-playbook /home/team4/nginx.yml",
      "sudo ansible-playbook /home/team4/httpd.yml",
      "sudo ansible-playbook /home/team4/ftp.yml"
    ]
    connection {
      type        = "ssh"
      user        = "team4"
      private_key = file("~/.ssh/id_rsa")
      host        = azurerm_public_ip.team4_pubip_bat.ip_address
    }
  }
  //  depends_on = [azurerm_linux_virtual_machine.team4_web1, azurerm_linux_virtual_machine.team4_web2, azurerm_virtual_network_gateway_connection.team4_onpremise]
  depends_on = [azurerm_linux_virtual_machine.team4_web1, azurerm_linux_virtual_machine.team4_web2]
}
resource "azurerm_linux_virtual_machine" "team4_web1" {
  name                            = "team4-web1"
  resource_group_name             = azurerm_resource_group.team4_rg.name
  location                        = azurerm_resource_group.team4_rg.location
  size                            = "Standard_F1s"
  admin_username                  = "team4"
  disable_password_authentication = true
  admin_ssh_key {
    username   = "team4"
    public_key = file("./files/id_rsa.pub")
  }
  network_interface_ids = [
    azurerm_network_interface.team4_web1_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  identity {
    type = "SystemAssigned"
  }
  source_image_reference {
    publisher = "resf"
    offer     = "rockylinux-x86_64"
    sku       = "9-base"
    version   = "9.3.20231113"
  }
  plan {
    name      = "9-base"
    product   = "rockylinux-x86_64"
    publisher = "resf"
  }
  //  user_data  = base64encode(file("999_web1script.sh"))
  depends_on = [azurerm_subnet_nat_gateway_association.team4_natgwasso_1]
}
resource "azurerm_linux_virtual_machine" "team4_web2" {
  name                            = "team4-web2"
  resource_group_name             = azurerm_resource_group.team4_rg.name
  location                        = azurerm_resource_group.team4_rg.location
  size                            = "Standard_F1s"
  admin_username                  = "team4"
  disable_password_authentication = true
  admin_ssh_key {
    username   = "team4"
    public_key = file("./files/id_rsa.pub")
  }
  network_interface_ids = [
    azurerm_network_interface.team4_web2_nic.id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  identity {
    type = "SystemAssigned"
  }
  source_image_reference {
    publisher = "resf"
    offer     = "rockylinux-x86_64"
    sku       = "9-base"
    version   = "9.3.20231113"
  }
  plan {
    name      = "9-base"
    product   = "rockylinux-x86_64"
    publisher = "resf"
  }
  //  user_data = base64encode(file("./999_web2script.sh"))
}
resource "azurerm_linux_virtual_machine" "team4_ftp" {
  name                            = "team4-ftp"
  resource_group_name             = azurerm_resource_group.team4_rg.name
  location                        = azurerm_resource_group.team4_rg.location
  size                            = "Standard_F1s"
  admin_username                  = "team4"
  disable_password_authentication = true
  admin_ssh_key {
    username   = "team4"
    public_key = file("./files/id_rsa.pub")
  }
  network_interface_ids = [
    azurerm_network_interface.team4_ftp_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  identity {
    type = "SystemAssigned"
  }
  source_image_reference {
    publisher = "resf"
    offer     = "rockylinux-x86_64"
    sku       = "9-base"
    version   = "9.3.20231113"
  }
  plan {
    name      = "9-base"
    product   = "rockylinux-x86_64"
    publisher = "resf"
  }
  //  user_data  = base64encode(file("999_web1script.sh"))
}
