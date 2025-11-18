variable "aws_region" {
type = string
default = "us-west-1"
}


variable "instance_type" {
type = string
default = "t3.micro"
}


variable "key_name" {
description = "Nome della key pair già presente in AWS (se vuoi SSH). Se vuoto, non verrà impostata key_pair."
type = string
default = ""
}


variable "public_key_path" {
description = "Percorso al file .pub (solo se desideri creare la key pair via Terraform)."
type = string
default = ""
}
