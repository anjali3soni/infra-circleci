resource "aws_security_group" "instance" {
  vpc_id = module.vpc.vpc_id
  name   = "${terraform.workspace}-server-SG"
  tags = {
    Name      = "${terraform.workspace}-server-SG"
    Terraform = "true"
  }
  ingress {
    description = "Allow all Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  } #This is required to allow the Jenkins server to access the Bastion server. 
}