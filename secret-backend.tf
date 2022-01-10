resource "vault_aws_secret_backend" "tfc" {
  path                      = "aws"
  access_key                = aws_iam_access_key.tfc.id
  secret_key                = aws_iam_access_key.tfc.secret
  default_lease_ttl_seconds = 1800
  max_lease_ttl_seconds     = 3600
}

resource "vault_aws_secret_backend_role" "tfc" {
  backend         = vault_aws_secret_backend.tfc.path
  name            = "tfc"
  credential_type = "assumed_role"
  role_arns       = [aws_iam_role.tfc.arn]
}