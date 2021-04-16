resource "aws_key_pair" "mw_key_pair" {
  key_name   = "Mediawiki-Key-Pair"
  public_key = file(var.pub_key_file)
}

resource "aws_instance" "mediawiki" {
  count         = var.instance_count
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.mediawiki-sg.id ]
  key_name = aws_key_pair.mw_key_pair.key_name

  tags = {
    Name = "MediaWiki"
    Env = "test"
    Terraform = "Yes"
  }

  provisioner "remote-exec" {
      # inline = ["sudo dnf -y update", "sudo dnf install python3 -y", "echo Done!"]
      inline = ["echo Done!"]

      connection {
        host        = self.public_ip
        type        = "ssh"
        user        = "ec2-user"
        private_key = file(var.prv_key_file)
      }
    }

    provisioner "local-exec" {
      command = "ansible-playbook -u ec2-user -i '${self.public_ip},' --private-key ${var.prv_key_file} mediawiki.yml"
    }

}

resource "aws_security_group" "mediawiki-sg" {
  name        = "Mediawiki Security Group"
  description = "Security group for mediawiki server which accepts internet connection"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "all"    
  }

  tags = {
    Name = "MediaWiki-SG"
    Env = "test"
    Terraform = "Yes"
  }
}
