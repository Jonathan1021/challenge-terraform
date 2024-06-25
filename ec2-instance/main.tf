provider "aws" {
  region = var.region
}

resource "aws_instance" "server" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  tags = {
    Name       = "${var.env}-instance"
    Owner      = var.owner
    Enviroment = var.env
    CostCenter = var.cost_center
  }
}
