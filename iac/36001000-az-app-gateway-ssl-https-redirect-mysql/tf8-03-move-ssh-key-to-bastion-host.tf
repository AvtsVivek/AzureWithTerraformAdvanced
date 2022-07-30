
# Create a Null Resource and Provisioners
resource "null_resource" "null_copy_ssh_key_to_bastion" {
  # Bastion host linux VM should be created before this resource
  depends_on = [azurerm_linux_virtual_machine.bastion_host_linuxvm]

  # Connection Block for Provisioners to connect to Azure VM Instance
  connection {
    type        = "ssh"
    host        = azurerm_linux_virtual_machine.bastion_host_linuxvm.public_ip_address
    user        = azurerm_linux_virtual_machine.bastion_host_linuxvm.admin_username
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")
  }

  ## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source      = "ssh-keys/terraform-azure.pem"
    destination = "/tmp/terraform-azure.pem"
    on_failure  = continue # coninue is defualt, so we don't need to set this
    when        = create   # create is defualt, so we don't need to set this
  }

  ## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/terraform-azure.pem"
    ]
  }
}

# Creation Time Provisioners - By default they are created during resource creations (terraform apply)
# Destory Time Provisioners - Will be executed during "terraform destroy" command (when = destroy)