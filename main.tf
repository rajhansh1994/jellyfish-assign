resource "aws_vpc" "jellyfish" {
  cidr_block = "10.0.0.0/16"

    tags = {
    Name = "jellyfish"
  }
}

resource "aws_launch_configuration" "jellyfish" {
  name                        = "jellyfish_config"
  image_id                    = "ami-00e24e2d9b2d70f5c"
  instance_type               = "t2.micro"
  key_name                    = "jellyfish.pem"
  enable_monitoring           = "true"
  associate_public_ip_address = "true"

  user_data = "${file("web_server.sh")}"

}