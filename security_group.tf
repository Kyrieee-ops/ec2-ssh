#------------------------------------
# Security Group
#------------------------------------
resource "aws_security_group" "cloudtech_stepserver_sg" {
  name        = "${var.project}-stepserver-sg"
  description = "SSH from VPC and HTTP from VPC"
  vpc_id      = aws_vpc.cloudtech_vpc.id

  tags = {
    Name    = "${var.project}-stepserver-sg"
    Project = var.project
  }
}

resource "aws_security_group_rule" "ingress_ssh" {
  security_group_id = aws_security_group.cloudtech_stepserver_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "22"
  to_port           = "22"
  cidr_blocks       = ["${var.myip}"]
}

resource "aws_security_group_rule" "ingress_http" {
  security_group_id = aws_security_group.cloudtech_stepserver_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "80"
  to_port           = "80"
  cidr_blocks       = ["${var.myip}"]
}

resource "aws_security_group_rule" "egress_all" {
  security_group_id = aws_security_group.cloudtech_stepserver_sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = "0"
  to_port           = "0"
  cidr_blocks       = ["0.0.0.0/0"]
}
