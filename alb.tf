# Cretes ALB
resource "aws_lb" "alb" {
  name               = var.ALB_NAME
  internal           = var.INTERNAL
  load_balancer_type = "application"
  security_groups    = If var.Internal=true (private-securityGroup) else (public-securityGroup)
  subnets            = var.INTERNAL ? data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS : data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNET_IDS

  enable_deletion_protection = false


  tags = {
    Name = var.ALB_NAME
  }
}
