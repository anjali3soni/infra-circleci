locals {


  dev = {
    profile     = "default"
    region      = "us-east-1"
    environment = "${terraform.workspace}-prod"

    #vpc
    cidr            = "10.10.0.0/16"
    azs             = ["us-east-1a", "us-east-1b"]
    public_subnets  = ["10.10.1.0/24", "10.10.2.0/24"]
    private_subnets = ["10.10.5.0/24", "10.10.6.0/24"]
    instance_ami    = "ami-0866a3c8686eaeeba"
    instance_type   = "t2.micro"
    instance_volume = 8
  }

  stage = {
    profile     = "default"
    region      = "us-east-1"
    environment = "${terraform.workspace}-prod"

    #vpc
    cidr            = "10.20.0.0/16"
    azs             = ["us-east-1a", "us-east-1b"]
    public_subnets  = ["10.20.1.0/24", "10.20.2.0/24"]
    private_subnets = ["10.20.5.0/24", "10.20.6.0/24"]
    instance_ami    = "ami-0866a3c8686eaeeba"
    instance_type   = "t2.micro"
    instance_volume = 8
  }

  pre-prod = {
    profile     = "default"
    region      = "us-east-1"
    environment = "${terraform.workspace}-prod"

    #vpc
    cidr            = "10.30.0.0/16"
    azs             = ["us-east-1a", "us-east-1b"]
    public_subnets  = ["10.30.1.0/24", "10.30.2.0/24"]
    private_subnets = ["10.30.5.0/24", "10.30.6.0/24"]
    instance_ami    = "ami-0866a3c8686eaeeba"
    instance_type   = "t2.micro"
    instance_volume = 8
  }

  prod = {
    profile     = "default"
    region      = "us-east-1"
    environment = "${terraform.workspace}-prod"

    #vpc
    cidr            = "10.30.0.0/16"
    azs             = ["us-east-1a", "us-east-1b"]
    public_subnets  = ["10.30.1.0/24", "10.30.2.0/24"]
    private_subnets = ["10.30.5.0/24", "10.30.6.0/24"]
    instance_ami    = "ami-0866a3c8686eaeeba"
    instance_type   = "t2.micro"
    instance_volume = 8
  }

  env = terraform.workspace == "dev" ? local.dev : terraform.workspace == "stage" ? local.stage : terraform.workspace == "pre-prod" ? local.pre-prod : terraform.workspace == "prod" ? local.prod : null
}