variable "approle_id" {
  desdescription = "" 
}
variable "approle_secret_id" {
  desdescription = "" 
}

resource "vault_aws_secret_backend" "aws" {
  access_key = var.approle_id
  secret_key = var.approle_secret_id
}
