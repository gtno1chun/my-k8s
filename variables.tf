variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)

  default = [
    "481230465846",
    # "888888888888",
  ]
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = "arn:aws:iam::481230465846:role/VaultCloud-Role"
      username = "vaultcloud-user"
      groups   = ["system:masters"]
    },
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
      userarn  = "arn:aws:iam::481230465846:user/vaultcloud-user"
      username = "vaultcloud-user"
      groups   = ["system:masters"]
    },
  ]
}

variable "vault_endpoint" {
  default = ""
}

variable "VAULT_TOKEN" {
  description = "vault access Token : https://registry.terraform.io/providers/hashicorp/vault/latest/docs#token"  
}

