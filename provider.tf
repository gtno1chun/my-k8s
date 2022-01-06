# variable login_approle_role_id {}

# variable login_approle_secret_id {}


# provider "vault" {
#   auth_login {
#     path = "auth/approle/login"

#     parameters = {
#       role_id   = var.login_approle_role_id
#       secret_id = var.login_approle_secret_id
#     }
#   }
# }

# provider "aws" {
#   region = local.region
#   access_key  = data.vault_aws_access_credentials.iam.access_key
#   secret_key  = data.vault_aws_access_credentials.iam.secret_key 
# }

provider "vault" {
  address = var.vault_endpoint
  auth_login {
    path = "auth/aws/login"
    method = "aws"
    parameters = {
      role = "jackchun-role"
      # heaer_value = "vault-token-test-role"
    }

  }
}

# variable vault_secrets_engine {}
# variable vault_access_role {}

data "vault_aws_access_credentials" "iam" {
  # region = var.env == "stg-cn" || var.env == "prod-cn" ? "cn-northwest-1" : "us-east-1"  ## china region workspace 는 반드시 cn-northwest-1 로 호출 하도록 해야 함
  backend = "tfc"         #var.vault_secrets_engine
  role    = "test-role"   #var.vault_access_role
}

output test_o {
  description = ""
  value   = data.vault_aws_access_credentials.iam.access_key 
}