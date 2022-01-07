resource "aws_instance" "ec2_example_with_data_source" {

    ami           = "ami-0767046d1677be5a0"
    instance_type =  "t2.micro"

    tags = {
      Name = "Terraform EC2"
    }
}

data "aws_instance" "myawsinstance" {
    filter {
        name = "tag:Name"
        values = ["Terraform EC2"]
    }

    depends_on = [
      "aws_instance.ec2_example_with_data_source"
    ]
}