provider "null" {}

# Resource to check Terraform installation
resource "null_resource" "check_terraform" {
  provisioner "local-exec" {
    command = <<EOT
    terraform --version
    EOT
  }
}

# Resource to check and install IIS if not installed
resource "null_resource" "check_iis" {
  provisioner "local-exec" {
    command = <<EOT
    powershell -Command "if (Get-WindowsFeature -Name Web-Server) { Install-WindowsFeature -Name Web-Server -IncludeManagementTools; } else { Write-Output 'IIS is already installed'; }"
    EOT
  }
}