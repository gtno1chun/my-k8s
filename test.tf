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

// vault provider는 write-only 값으로 주입된 환경변수 VAULT_TOKEN을 이용한다.
provider "vault" {
  address = var.vault_endpoint
}

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "~"

    workspaces {
      name = "~"
    }
  }
}

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