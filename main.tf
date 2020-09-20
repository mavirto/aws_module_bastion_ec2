
# Security groups del Bastion Host

resource  "aws_security_group" "bastion_sg" {
  name = var.sg_name
  description = "SG para Bastion EC2 instance"
  vpc_id = var.bastion_vpc

  # SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.localip}"]
  }

  # TRAFICO DE SALIDA
  egress {
    from_port = 0
    to_port = 0
    protocol =  "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# SSH-KEY

resource "aws_key_pair" "bastion_key" {
  key_name = var.sshkey_name
  public_key = var.sshpublic_key
}



# BASTION SERVER

resource "aws_instance" "bastion_host" {
  instance_type = var.bastion_instance_type
  ami = var.bastion_ami
  
  tags = {
    Name = var.bastion_name
  }

  key_name = aws_key_pair.bastion_key.id
  vpc_security_group_ids = ["${aws_security_group.bastion_sg.id}"]
  subnet_id = var.subnet_id
}

