resource "aws_security_group" "efs_sg" {
    count       = var.create_efs ? 1 : 0
    name        = "${var.app_name}-${var.stage_name}-efs-sg"
    description = "controls access to efs"
    
    vpc_id      = var.vpcid
    
    ingress {
        protocol = "tcp"
        from_port = 2049
        to_port = 2049
        cidr_blocks = var.private_subnets
    }
}

resource "aws_efs_file_system" "main" {
  count = var.create_efs ? 1 : 0
  lifecycle_policy {
    transition_to_ia = "AFTER_7_DAYS"
  }
  tags = {
    Name = "${var.app_name}-${var.stage_name}-efs"
  }
}

resource "aws_efs_mount_target" "private" {
  count             = var.create_efs ? length(var.private_subnet_ids) : 0
  file_system_id    = element(aws_efs_file_system.main.*.id, count.index)
  subnet_id         = element(var.private_subnet_ids, count.index)
  security_groups   = [element(aws_security_group.efs_sg.*.id, count.index)]
}

