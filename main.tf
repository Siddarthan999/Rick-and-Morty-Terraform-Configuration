provider "null" {}

# Resource to check Terraform installation
resource "null_resource" "check_terraform" {
  provisioner "local-exec" {
    command = <<EOT
    terraform --version
    EOT
  }
}

# Resource to check IIS installation
resource "null_resource" "check_iis" {
  provisioner "local-exec" {
    command = <<EOT
    powershell -Command "if (Get-WindowsFeature -Name Web-Server) { Write-Output 'IIS is installed' } else { Write-Output 'IIS is not installed' }"
    EOT
  }
}
