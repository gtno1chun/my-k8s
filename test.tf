# variable "name" { default = "dynamic-aws-creds-operator" }
# variable "region" { default = "ap-northeast-2" }
# # variable "path" { default = "../vault-admin-workspace/terraform.tfstate" }
# variable "ttl" { default = "1" }

# # terraform {
# #   backend "local" {
# #     path = "terraform.tfstate"
# #   }
# # }

# data "terraform_remote_state" "my-k8s" {
#   backend = "local"

#   config = {
#     path = var.path
#   }
# }

# # provider "vault" {
# #   address = var.vault_endpoint
# #   auth_login {
# #     path = "auth/aws/login"
# #     method = "aws"
# #     parameters = {
# #       role = "jackchun-role"
# #       # heaer_value = "vault-token-test-role"
# #     }

# #   }
# # }

# variable "approle_id" {
#   description = ""

# }
# variable "approle_secret_id" {
#   description = ""

# }


# provider "vault" {
#   address = var.vault_endpoint
#   auth_login {
#     path = "auth/tfc/login"
#     parameters = {
#       role_id   = var.approle_id
#       secret_id = var.approle_secret_id
#     }
#   }
# }


# data "vault_aws_access_credentials" "iam" {
#   # backend = data.terraform_remote_state.my-k8s.outputs.backend
#   # role    = data.terraform_remote_state.my-k8s.outputs.role
#   backend = "aws-tfc" 
#   role    = "data.terraform_remote_state.my-k8s.outputs.role
# }

# provider "aws" {
#   region     = var.region
#   access_key = data.vault_aws_access_credentials.iam.access_key
#   secret_key = data.vault_aws_access_credentials.iam.secret_key
# }

# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["481230465846"] # Canonical
# }

# # Create AWS EC2 Instance
# resource "aws_instance" "main" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t2.nano"

#   tags = {
#     Name  = var.name
#     TTL   = var.ttl
#     owner = "${var.name}-guide"
#   }
# }



variable "approle_id" {
  description = ""

}
variable "approle_secret_id" {
  description = ""

}

provider "vault" {
  address = var.vault_endpoint 
  auth_login {
    path = "auth/tfc/login"
    parameters = {
      role_id   = "Token" #var.approle_id
      secret_id = "jackchun-token" #var.approle_secret_id
    }
  }
}

data "vault_aws_access_credentials" "creds" {
  backend = "tfc" #var.approle_id  #"tfc" vault_aws_secret_backend.tfc.path
  role    = "jackchun-role" #var.approle_secret_id #vault_aws_secret_backend_role.role.name
}

# provider "aws" {
#   access_key = data.vault_aws_access_credentials.creds.access_key
#   secret_key = data.vault_aws_access_credentials.creds.secret_key
# }