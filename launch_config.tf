######  template, which contains all instance settings to apply to each new launched by Auto Scaling Group instance.

resource "aws_launch_configuration" "jellyfish" {
  name                        = "jellyfish_config"
  image_id                    = "ami-00e24e2d9b2d70f5c"
  instance_type               = "t2.micro"
  key_name                    = "jellyfish"
  security_groups             = [aws_security_group.allow_http.id]
  associate_public_ip_address = true
  enable_monitoring           = true
  user_data                   = "${file("web_server.sh")}"

  lifecycle {
    create_before_destroy = true
  }

}