#-------------------------------------------------------------------
# Tutorial MGN Server Configuration
#-------------------------------------------------------------------
module "tutorial_mgn_source" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.5.0"
  depends_on = [module.demo_mgn_ec2_assumable_role,
    aws_iam_access_key.AccK
  ]
  #demo on-prem server only
  #checkov:skip=CKV_AWS_79: "Ensure Instance Metadata Service Version 1 is not enabled"
  #checkov:skip=CKV_AWS_126: "Ensure that detailed monitoring is enabled for EC2 instances"
  #checkov:skip=CKV_AWS_8: "Ensure all data stored in the Launch configuration or instance Elastic Blocks Store is securely encrypted"


  name = "on-prem-source-svr-${var.environment}-01"


  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = "t2.micro"
  subnet_id                   = module.tutorial_source_vpc.private_subnets[0]
  availability_zone           = module.tutorial_source_vpc.azs[0]
  associate_public_ip_address = false
  vpc_security_group_ids      = [module.source_ec2_server_sg.security_group_id]
  iam_instance_profile        = module.demo_mgn_ec2_assumable_role.iam_instance_profile_id
  user_data_base64            = base64encode(local.user_data_prod)

  disable_api_termination = false

  enable_volume_tags = false
  root_block_device = [
    {
      volume_type = "gp3"
      volume_size = 10

    },
  ]

}

resource "aws_ebs_volume" "tutorial_mgn_data_drive" {
  #checkov:skip=CKV2_AWS_2: "Ensure that only encrypted EBS volumes are attached to EC2 instances"
  #checkov:skip=CKV_AWS_189: "Ensure EBS Volume is encrypted by KMS using a customer managed Key (CMK)"
  #checkov:skip=CKV_AWS_3: "Ensure all data stored in the EBS is securely encrypted"
  size              = 4
  type              = "gp3"
  availability_zone = module.tutorial_source_vpc.azs[0]

}

resource "aws_volume_attachment" "tutorial_mgn_data_drive_attachment" {

  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.tutorial_mgn_data_drive.id
  instance_id = module.tutorial_mgn_source.id

}
