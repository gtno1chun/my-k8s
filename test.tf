variable "approle_id" {
  description = "" 
}
variable "approle_secret_id" {
  description = "" 
}

resource "vault_aws_secret_backend" "aws" {
  access_key = var.approle_id
  secret_key = var.approle_secret_id
}
