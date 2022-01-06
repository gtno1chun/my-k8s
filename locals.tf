resource "random_string" "suffix" {
  length  = 4
  special = false
}

locals {
  name            = "jackchun-eks-${random_string.suffix.result}"
  cluster_version = "1.20"
  region          = "ap-northeast-2"
}