data "aws_ssm_parameter" "amzn2" {
vpc_id = aws_vpc.default.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.gw.id
}
}


resource "aws_route_table_association" "rta" {
subnet_id = aws_subnet.default.id
route_table_id = aws_route_table.r.id
}


resource "aws_security_group" "sg" {
name = "jenkins-tf-sg"
description = "Allow SSH and HTTP"
vpc_id = aws_vpc.default.id


ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
description = "ssh"
}


ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
description = "http"
}


egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}


tags = { Name = "jenkins-tf-sg" }
}


resource "aws_key_pair" "kp" {
count = var.public_key_path != "" ? 1 : 0
key_name = var.key_name != "" ? var.key_name : "jenkins-tf-key"
public_key = file(var.public_key_path)
}


resource "aws_instance" "web" {
ami = data.aws_ssm_parameter.amzn2.value
instance_type = var.instance_type
subnet_id = aws_subnet.default.id
vpc_security_group_ids = [aws_security_group.sg.id]


key_name = length(aws_key_pair.kp) > 0 ? aws_key_pair.kp[0].key_name : (var.key_name != "" ? var.key_name : null)


tags = {
Name = "jenkins-tf-ec2"
}
}
