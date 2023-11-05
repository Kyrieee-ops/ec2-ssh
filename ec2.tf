#------------------------------------
# EC2
#------------------------------------
#最新のAMI IDを取得
data "aws_ssm_parameter" "amzn2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "cloudtech_testserver_ec2" {
  ami                         = data.aws_ssm_parameter.amzn2_ami.value
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.cloudtech_subnet_public1.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.cloudtech_stepserver_sg.id
  ]

  key_name = "cloudtech-keypair"

  tags = {
    Name    = "${var.project}-testserver"
    Project = var.project
  }
}

# Instance Profile 
resource "aws_iam_instance_profile" "s3_instance_profile" {
  name = aws_iam_role.s3_bucket_policy.name
  role = aws_iam_role.s3_bucket_policy.name
}

# Instance