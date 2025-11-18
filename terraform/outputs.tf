output "instance_id" {
value = aws_instance.web.id
}


output "instance_public_ip" {
value = aws_instance.web.public_ip
}


output "ami_used" {
value = data.aws_ssm_parameter.amzn2.value
}
