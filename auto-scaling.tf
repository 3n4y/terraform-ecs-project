data "aws_ssm_parameter" "ecs_optimized_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended"
}

resource "aws_launch_configuration" "ecs_launch_config" {
  image_id             = jsondecode(data.aws_ssm_parameter.ecs_optimized_ami.value)["image_id"]
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
  security_groups      = [aws_security_group.ecs_sg.id, module.alb_sg.security_group_id]
  instance_type        = "t2.micro"
  name_prefix          = local.name
  user_data            = <<-EOT
        #!/bin/bash
        cat <<'EOF' >> /etc/ecs/ecs.config
        ECS_CLUSTER=${aws_ecs_cluster.ecs_cluster.name}
        ECS_LOGLEVEL=debug
        ECS_CONTAINER_INSTANCE_TAGS=${jsonencode(local.tags)}
        ECS_ENABLE_TASK_IAM_ROLE=true
        EOF
      EOT
}

resource "aws_autoscaling_group" "ecs_asg" {
  name                      = "asg"
  vpc_zone_identifier       = [for zone in module.vpc.public_subnets: zone]
  launch_configuration      = aws_launch_configuration.ecs_launch_config.name
  desired_capacity          = 2
  min_size                  = 1
  max_size                  = 10
  health_check_grace_period = 300
  health_check_type         = "EC2"
}