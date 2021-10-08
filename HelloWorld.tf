// this section declares that we need an aws instance along with its configuration
resource "aws_instance" "webapp" {
  ami           = data.aws_ami.amazon_linux2_ami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_webapp_traffic.id]
  key_name = aws_key_pair.webserver_key.key_name

  user_data = <<-EOF
            #!/bin/bash
            sudo yum update -y
            sudo yum install httpd -y
            sudo service httpd start
            sudo chkconfig httpd on
            echo "<html><h1>Hello Adam S & World!</h1></html>" | sudo tee /var/www/html/index.html
            EOF

  tags = {
    Name = "terraform-project"
  }
}

output "instance_ip" {
    value = aws_instance.webapp.public_ip
}