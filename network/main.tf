provider "aws"{
    region = var.aws_region

    allowed_account_ids = var.aws_accounts
}

module "aws_network"{
    source = "./modules/aws-network"

    aws_vpc_name = var.aws_vpc_name

    aws_vpc_cidr = var.aws_vpc_cidr

    aws_azs = var.aws_azs

    aws_pub_subnets = var.aws_pub_subnets

    aws_pvt_subnets = var.aws_pvt_subnets
}