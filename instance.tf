resource "aws_instance" "instance_1" {
  ami                    = local.env.instance_ami
  instance_type          = local.env.instance_type
  vpc_security_group_ids = [aws_security_group.instance.id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "${local.env.environment}-i"
    Name        = "${local.env.environment}-instance"
  }

}