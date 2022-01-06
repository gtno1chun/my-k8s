variable "approle_id" {
  description = "" 
}
variable "approle_secret_id" {
  description = "" 
}
variable "name" { default = "dynamic-aws-creds-vault-admin" }

variable "VAULT_TOKEN" {
  description = ""
  
}

provider "vault" {
  address = var.vault_endpoint

  # auth_login {
  #   path    = "auth/token/login"
  #   token = var.VAULT_TOKEN   
  # } 
  #alias = "approle"
  # alias = "Token"
  # token = "jackchun-token"  #"${vault_approle_auth_backend_login.login.client_token}"
}


resource "vault_aws_secret_backend" "aws" {
  access_key = var.approle_id
  secret_key = var.approle_secret_id
  path       = "${var.name}-path"


}


resource "vault_aws_secret_backend_role" "role" {
  backend = vault_aws_secret_backend.aws.path
  name            = "${var.name}-role"
  credential_type = "iam_user"

  policy_document = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:*",
      "Resource": "*"
    }
  ]
}
EOT
}

# generally, these blocks would be in a different module
data "vault_aws_access_credentials" "tfc" {
  backend = "aws"
  role    = "tfc"
  type    = "sts"
}

provider "aws" {
  region     = "~"
  access_key = data.vault_aws_access_credentials.tfc.access_key
  secret_key = data.vault_aws_access_credentials.tfc.secret_key
  token      = data.vault_aws_access_credentials.tfc.security_token
}

output "backend" {
  value = vault_aws_secret_backend.aws.path
}

output "role" {
  value = vault_aws_secret_backend_role.role.name
}