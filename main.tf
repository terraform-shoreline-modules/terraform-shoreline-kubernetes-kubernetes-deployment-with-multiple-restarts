terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "kubernetes_deployment_with_multiple_restarts" {
  source    = "./modules/kubernetes_deployment_with_multiple_restarts"

  providers = {
    shoreline = shoreline
  }
}