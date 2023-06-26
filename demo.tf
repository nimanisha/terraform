

resource "aws_instance" "mec2"{
ami = "ami-00183ea8ca7298292"
instance_type = "t2.micro"
key_name="ec2"
vpc_security_group_ids = ["output.sgid"]
}
resource "aws_security_group" "ec2-sg"{
name = "myec2sg"
ingress {
from_port="0"
to_port="65536"
protocol = "tcp"
cidr_blocks=["0.0.0.0/0"]
}
egress {
from_port="0"
to_port="65536"
protocol = "tcp"
cidr_blocks=["0.0.0.0/0"]
}
}
output "sgid" {
  value = aws_security_group.ec2-sg.id
}

