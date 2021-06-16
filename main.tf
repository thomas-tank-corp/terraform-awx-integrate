terraform {
  required_providers {
    awx = {
      source  = "nolte/awx"
      version = "0.2.2"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 3.0"
    }
    vault = {
      source = "hashicorp/vault"
      version = "2.20.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
  required_version = ">= 0.13"
}

provider "awx" {
  hostname = var.awx_hostname
  username = var.awx_username
  password = var.awx_password
}
