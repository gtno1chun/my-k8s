# // aws/config/root에 입력될 user
# resource "aws_iam_user" "tfc" {
#   name     = "terraform-cloud"
# }

# resource "aws_iam_user_policy" "tfc" {
#   name     = "terraform-cloud-policy"
#   user     = aws_iam_user.tfc.name
#   policy   = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#         "sts:AssumeRole"
#       ],
#       "Resource": [
#         "arn:aws:iam::481230465846:role/TerraformCloud"
#       ]
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_access_key" "tfc" {
#   user     = aws_iam_user.tfc.name
# }

# // 실제로 TFC가 발급 받아서 사용하는 role
# resource "aws_iam_role" "tfc" {
#   name     = "TerraformCloud"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::481230465846:user/terraform-cloud"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
# }

# // TFC가 사용하게될 policy, 꼭 AdministratorAccess일 필요는 없다.
# resource "aws_iam_role_policy_attachment" "tfc" {
#   role       = aws_iam_role.tfc.name
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# }

variable "name" { default = "dynamic-aws-creds-operator" }
variable "region" { default = "ap-northeast-2" }
#variable "path" { default = "../vault-admin-workspace/terraform.tfstate" }
variable "ttl" { default = "1" }

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["481230465846"] # Canonical
}

# Create AWS EC2 Instance
resource "aws_instance" "main" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.nano"

  tags = {
    Name  = var.name
    TTL   = var.ttl
    owner = "${var.name}-guide"
  }
}