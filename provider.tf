# variable "approle_id" { 
#   description = ""
# } 
# variable "approle_secret_id" {
#   description = ""
# }

# provider "vault" {
#   address = var.vault_endpoint
# }

provider "vault" {
  address = var.vault_endpoint
  auth_login {
    path = format("auth/userpass/login%s", var.username_vault)
    parameters = {
      username = var.username_vault
      password = var.password_vault 
    }
  }
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


# data "vault_aws_access_credentials" "vault-assume" {
#   backend = "aws-eks"
#   role    = "tfc"
#   #role_arn = "arn:aws:iam::481230465846:role/TerraformCloud"
#   #type    = "creds"
#   type    = "sts"
# }
data "vault_aws_access_credentials" "vault-assume" {
  backend   = "aws"
  role      = "eks-tfc-role"
  # role_arn  = "arn:aws:iam::481230465846:role/VaultCloud-Role"
  type      = "sts"
}

provider "aws" {
  #alias      = "assume"
  region     = "ap-northeast-2"
  access_key = data.vault_aws_access_credentials.vault-assume.access_key
  secret_key = data.vault_aws_access_credentials.vault-assume.secret_key
  token      = data.vault_aws_access_credentials.vault-assume.security_token
}
# output "out_token" {
#   description = "value"
#   value   = data.vault_aws_access_credentials.tfc.security_token
# } 
