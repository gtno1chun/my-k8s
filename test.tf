variable "approle_id" {
  description = "" 
}
variable "approle_secret_id" {
  description = "" 
}
variable "name" { default = "dynamic-aws-creds-vault-admin" }

provider "vault" {

}


resource "vault_aws_secret_backend" "aws" {
  access_key = var.approle_id
  secret_key = var.approle_secret_id
  path       = "${var.name}-path"


}


resource "vault_aws_secret_backend_role" "role" {
  backend = vault_aws_secret_backend.aws.path
  name    = "test"

  policy = <<EOT
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
data "vault_aws_access_credentials" "creds" {
  backend = vault_aws_secret_backend.aws.path
  role    = vault_aws_secret_backend_role.role.name
}

provider "aws" {
  access_key = data.vault_aws_access_credentials.creds.access_key
  secret_key = data.vault_aws_access_credentials.creds.secret_key
}

output "backend" {
  value = vault_aws_secret_backend.aws.path
}

output "role" {
  value = vault_aws_secret_backend_role.admin.name
}