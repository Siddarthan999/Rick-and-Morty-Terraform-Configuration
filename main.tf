provider "null" {}

# Resource for installing IIS
resource "null_resource" "install_iis" {
  provisioner "local-exec" {
    command = <<EOT
    powershell -Command "Install-WindowsFeature -Name Web-Server -IncludeManagementTools"
    EOT
  }
}

# Resource for deploying build output
resource "null_resource" "deploy_build" {
  depends_on = [null_resource.install_iis]

  provisioner "local-exec" {
    command = <<EOT
    $buildOutputPath = "${env.WORKSPACE}\\dist"
    $iisPath = "C:\\inetpub\\wwwroot\\Rick-and-Morty-POC-Project-3"

    # Ensure build output exists
    if (-Not (Test-Path $buildOutputPath)) { exit 1 }

    # Clean IIS directory
    if (Test-Path $iisPath) { Remove-Item -Recurse -Force $iisPath }

    # Create IIS directory
    New-Item -Path $iisPath -ItemType Directory -Force

    # Copy build output to IIS directory
    Copy-Item -Path "$buildOutputPath\\*" -Destination $iisPath -Recurse -Force
    EOT
  }
}
