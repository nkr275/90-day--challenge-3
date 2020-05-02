terraform {
  required_providers {
    aws = "~> 2.59"
  }
}
provider "aws" {
   region       = var.region
   access_key   = var.access
   secret_key   = var.secret
}
