module "aws_vpc"{
    source = "terraform-aws-modules/vpc/aws" # https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/
    
    version = "5.8.1" # https://developer.hashicorp.com/terraform/language/modules/syntax#version

    name = var.aws_vpc_name

    cidr = var.aws_vpc_cidr

    azs = var.aws_azs

    public_subnets = var.aws_pub_subnets

    private_subnets = var.aws_pvt_subnets

    enable_nat_gateway = true

    enable_vpn_gateway = false
}