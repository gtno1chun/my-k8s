provider "vault" {
  address = var.vault_endpoint
}

# terraform {
#   backend "remote" {
#     hostname     = "app.terraform.io"
#     organization = "jackchun"

#     workspaces {
#       name = "my-k8s"
#     }
#   }
# }

data "vault_aws_access_credentials" "tfc" {
  backend = "aws"
  role    = "tfc"
  #type    = "creds"
  #type    = "sts"
}

# provider "aws" {
#   region     = "ap-northeast-2"
#   access_key = data.vault_aws_access_credentials.tfc.access_key
#   secret_key = data.vault_aws_access_credentials.tfc.secret_key
#   #token      = data.vault_aws_access_credentials.tfc.security_token
# }