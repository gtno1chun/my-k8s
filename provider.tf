# variable "approle_id" { 
#   description = ""
# } 
# variable "approle_secret_id" {
#   description = ""
# }

provider "vault" {
  address = var.vault_endpoint
  # auth_login {
  #   path = "auth/aws/login"
  #   parameters = {
  #     role_id   = var.approle_id
  #     secret_id = var.approle_secret_id
  #   }
  # }

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

data "vault_aws_access_credentials" "vault" {
  backend = "aws-iam-user"
  role    = "vault-iam-user"
  type    = "creds"
  #type    = "sts"
}

provider "aws" {
  region     = "ap-northeast-2"
  access_key = data.vault_aws_access_credentials.vault.access_key
  secret_key = data.vault_aws_access_credentials.vault.secret_key
  token      = data.vault_aws_access_credentials.vault.security_token
}

# output "out_token" {
#   description = "value"
#   value   = data.vault_aws_access_credentials.tfc.security_token
# }
