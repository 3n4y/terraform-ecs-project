resource "aws_ecs_task_definition" "run-nginx" {
  family = "run-container"
  container_definitions = jsonencode(
    [
      {
        name : local.container_name,
        image : local.container_image,
        portMappings : [
          {
            containerPort : local.container_port
            hostPort : local.host_port
          }
        ],
        memory : 512
        cpu : 256
      }
    ]
  )
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  memory                   = 512
  cpu                      = 256
}