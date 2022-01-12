variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)

  default = [
    "481230465846",
    # "888888888888",
  ]
}


# variable "map_roles" {
#   description = "Additional IAM roles to add to the aws-auth configmap."
#   type = list(object({
#     rolearn  = string
#     username = string
#     groups   = list(string)
#   }))

#   default = [
#     {
#       rolearn  = "arn:aws:iam::481230465846:role/jackchun"
#       username = "jackchun"
#       groups   = ["system:masters"]
#     },
#   ]
# }

# variable "map_users" {
#   description = "Additional IAM users to add to the aws-auth configmap."
#   type = list(object({
#     userarn  = string
#     username = string
#     groups   = list(string)
#   }))

#   default = [
#     {
#       userarn  = "arn:aws:iam::481230465846:user/jackchun"
#       username = "jackchun"
#       groups   = ["system:masters"]
#     },
#     # {
#     #   userarn  = "arn:aws:iam::66666666666:user/user2"
#     #   username = "user2"
#     #   groups   = ["system:masters"]
#     # },
#   ]
# }

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = "arn:aws:iam::481230465846:role/jackchun"
      username = "jackchun"
      groups   = ["system:masters"]
    },
    # {
    #   rolearn   = "arn:aws:iam::481230465846:role/vault-role"
    #   username  = "vault-role"
    #   groups    = ["system:masters"] 
    # },
    # {
    #   rolearn   = "arn:aws:iam::481230465846:role/TerraformCloud"
    #   username  = "TerraformCloud"
    #   groups    = ["system:masters"] 
    # },
  ]
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::481230465846:user/jackchun"
      username = "jackchun"
      groups   = ["system:masters"]
    },
    # {
    #   userarn  = "arn:aws:iam::481230465846:user/vault-*"  
    #   username = "vault-*"
    #   groups   = ["system:masters"] 
    # }, 
    # {
    #   userarn  = "arn:aws:iam::481230465846:user/terraform-cloud" 
    #   username = "terraform-cloud"
    #   groups   = ["system:masters"] 
    # },
  ]
}

variable "vault_endpoint" {
  default = ""
}

variable "VAULT_TOKEN" {
  description = "vault access Token : https://registry.terraform.io/providers/hashicorp/vault/latest/docs#token"  
}

