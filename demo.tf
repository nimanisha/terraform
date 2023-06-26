provider "aws"{
region = "us-east-1"
}

resource "aws_instance" "mec2"{
ami = "ami-00183ea8ca7298292"
instance_type = "t2.micro"
key_name="ec2"
vpc_security_group_ids = ["output.sgid"]
    provisioner "remote-exec" {
      inline = [
        "sudo yum install -y ngnix",
        "sudo systemctl start ngnix"
       
      ]
      connection {
        type = "ssh"
        host = self.public_ip
        user="root"
        private_key="${file("./ec2.pem")}"
      }
      
    }
}
resource "aws_security_group" "ec2-sg"{
name = "myec2sg"
ingress {
from_port="22"
to_port="22"
protocol = "tcp"
cidr_blocks=["0.0.0.0/0"]
}
egress {
from_port="22"
to_port="22"
protocol = "tcp"
cidr_blocks=["0.0.0.0/0"]
}
}
output "sgid" {
  value = aws_security_group.ec2-sg.id
}


