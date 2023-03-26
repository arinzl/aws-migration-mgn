#------------------------------------------------------------------------------
# Source VPC security groups
#------------------------------------------------------------------------------

resource "aws_default_security_group" "default_source" {
  depends_on = [module.tutorial_source_vpc]

  vpc_id = module.tutorial_source_vpc.vpc_id

  ingress = []
  egress  = []

}


module "source_https_443_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/https-443"
  version = "4.16.2"
  #checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"

  name        = "vpce-source-https-443-sg"
  description = "Allow https 443"
  vpc_id      = module.tutorial_source_vpc.vpc_id

  ingress_cidr_blocks = [module.tutorial_source_vpc.vpc_cidr_block]

  egress_rules = ["https-443-tcp"]

  tags = local.tags_generic
}


module "source_ec2_server_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"
  #checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"

  name        = "mgn-source-server-${var.environment}-sg"
  description = "Security group for MGN Source - ${var.environment}"
  vpc_id      = module.tutorial_source_vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["https-443-tcp", "http-80-tcp"]

  egress_with_cidr_blocks = [
    {
      from_port   = 1500
      to_port     = 1500
      protocol    = "tcp"
      description = "RI server"
      cidr_blocks = "0.0.0.0/0"
    },
  ]


}


#------------------------------------------------------------------------------
# Target VPC security groups
#------------------------------------------------------------------------------

resource "aws_default_security_group" "default_target" {
  depends_on = [module.tutorial_target_vpc]

  vpc_id = module.tutorial_target_vpc.vpc_id

  ingress = []
  egress  = []

}

module "target_https_443_target_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/https-443"
  version = "4.16.2"
  #checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"

  name        = "vpce-target-https-443-sg"
  description = "Allow https 443"
  vpc_id      = module.tutorial_target_vpc.vpc_id

  ingress_cidr_blocks = [module.tutorial_target_vpc.vpc_cidr_block]


  egress_rules = ["https-443-tcp"]

  tags = local.tags_generic
}


module "target_ec2_server_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"
  #checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"


  name        = "mgn-target-server-${var.environment}-sg"
  description = "Security group for MGN target - ${var.environment}"
  vpc_id      = module.tutorial_target_vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

}
