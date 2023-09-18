
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = local.name

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups      = [aws_security_group.ecs_sg.id]

  http_tcp_listeners = [
    {
      port               = local.host_port
      protocol           = "HTTP"
      target_group_index = 0
    },
  ]

  target_groups = [
    {
      name_prefix      = "${local.owners}"
      backend_protocol = "HTTP"
      backend_port     = local.container_port
      target_type      = "instance"
    },
  ]

  tags = local.tags
}

