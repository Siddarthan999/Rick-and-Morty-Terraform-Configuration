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
resource "null_resource" "check_and_install_iis" {
  provisioner "local-exec" {
    command = <<EOT
    powershell -Command "
    if (-not (Get-WindowsFeature -Name Web-Server).Installed) {
        Install-WindowsFeature -Name Web-Server -IncludeManagementTools;
        Write-Output 'IIS was not installed and has now been installed';
    } else {
        Write-Output 'IIS is already installed';
    }
    "
    EOT
  }
}

