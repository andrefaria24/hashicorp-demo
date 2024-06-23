terraform {
    cloud {
        organization = "ACME_andre_faria"

        workspaces {
            name = "ws-compute"
        }
    }

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.55.0"
        }
    }
}

data "terraform_remote_state" "network"{
    backend = "remote"

    config = {
        organization = "ACME_andre_faria"
        workspaces = {
            name = "ws-networking"
        }
  }
}

provider "aws" {
    region = var.aws_region
    allowed_account_ids = var.aws_accounts
}

resource "aws_instance" "web_server" {
    ami           = var.webserver_ami
    instance_type = "t2.micro"
    key_name      = var.key_name
    subnet_id = data.terraform_remote_state.network.outputs.aws_pub_sn_id
    vpc_security_group_ids = [data.terraform_remote_state.network.outputs.aws_sg_http_id]
}

resource "aws_eip" "web_server_eip" {
    depends_on = [aws_instance.web_server]
}

resource "aws_eip_association" "web_server_eip_assoc" {
    allocation_id = aws_eip.web_server_eip.allocation_id
    instance_id = aws_instance.web_server.id
}