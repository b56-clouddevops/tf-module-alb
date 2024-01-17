# Creates Security Group For Public ALN
resource "aws_security_group" "alb_public" {
  name                  = "roboshop-${var.ENV}-public-alb-sg"
  description           = "roboshop-${var.ENV}-public-alb-sg"
  vpc_id                = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
       description      = "roboshop-${var.ENV}-public-alb-sg"
       from_port        = 80
       to_port          = 80
       protocol         = "tcp"
       cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
       from_port        = 0
       to_port          = 0
       protocol         = "-1"
       cidr_blocks      = ["0.0.0.0/0"]
  }

    tags = {
      Name = "roboshop-${var.ENV}-public-alb-sg"
    }
}
 

# Creates Security Group For Private ALB
resource "aws_security_group" "alb_private" {
  name                  = "roboshop-${var.ENV}-private-alb-sg"
  description           = "roboshop-${var.ENV}-private-alb-sg"
  vpc_id                = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
       description      = "roboshop-${var.ENV}-public-alb-sg"
       from_port        = 80
       to_port          = 80
       protocol         = "tcp"
       cidr_blocks      = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR, data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }

  egress {
       from_port        = 0
       to_port          = 0
       protocol         = "-1"
       cidr_blocks      = ["0.0.0.0/0"]
  }

    tags = {
      Name = "roboshop-${var.ENV}-private-alb-sg"
    }
}
 