provider "vault" {
  address = var.vault_endpoint
  auth_login {
    path = "auth/aws/login"
    method = "aws"
    parameters = {
      role = "test-role"
      heaer_value = "vault-token-test-role"
    }

  }
}