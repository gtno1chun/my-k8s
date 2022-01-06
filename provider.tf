variable login_approle_role_id {}

variable login_approle_secret_id {}


provider "vault" {
  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = var.login_approle_role_id
      secret_id = var.login_approle_secret_id
    }
  }
}

# output {
  
#   description = ""
#   value       = role_id
# }
# output "node_groups" {
#   description = ""
#   value       = module.eks.node_groups
# }


# provider "vault" {
#   address = var.vault_endpoint
#   auth_login {
#     path = "auth/aws/login"
#     method = "aws"
#     parameters = {
#       role = "test-role"
#       # heaer_value = "vault-token-test-role"
#     }

#   }
# }