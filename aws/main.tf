provider "aws" {
  region                  = var.region
  shared_credentials_files = ["$HOME/.aws/credentials"]
  profile                 = "default"
}

terraform {
    backend "local" {
    }
}

# These variables aren't meant to be changed by the end user.
locals {
  ami_id                         = "ami-070650c005cce4203" # Ubuntu 22.04 LTS arm
  opencti_dir                    = "/opt/opencti"
  opencti_install_script_name    = "opencti-installer.sh"
  opencti_connectors_script_name = "opencti-connectors.sh"
}
