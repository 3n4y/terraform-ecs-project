resource "aws_ecs_service" "aws_ecs_service" {
  name            = local.name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.run-nginx.arn
  desired_count   = 2
  load_balancer {
    target_group_arn = element(module.alb.target_group_arns, 0)
    container_name   = local.container_name
    container_port   = local.container_port
  }
}