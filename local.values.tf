locals {
  owners      = "endy"
  environment = "test"
  name        = "${local.owners}-${local.environment}"
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
  container_name  = "ecs-project1"
  container_port  = 3000
  host_port = 80
  container_image = "kodekloud/ecs-project1"
  tags = {
    Name        = local.owners
    Environment = local.environment
  }
}