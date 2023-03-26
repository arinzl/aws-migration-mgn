#------------------------------------------------------------------------------
# VPC - SSM Endpoints
#------------------------------------------------------------------------------
module "vpc_ssm_endpoint_source" {

  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.13.0"

  vpc_id             = module.tutorial_source_vpc.vpc_id
  security_group_ids = [module.source_https_443_security_group.security_group_id]

  endpoints = {
    ssm = {
      service             = "ssm"
      private_dns_enabled = true
      subnet_ids          = module.tutorial_source_vpc.private_subnets
      tags                = merge(local.tags_generic, local.tags_ssm_ssm)
    },
    ssmmessages = {
      service             = "ssmmessages"
      private_dns_enabled = true,
      subnet_ids          = module.tutorial_source_vpc.private_subnets
      tags                = merge(local.tags_generic, local.tags_ssm_ssmmessages)
    },
    ec2messages = {
      service             = "ec2messages",
      private_dns_enabled = true,
      subnet_ids          = module.tutorial_source_vpc.private_subnets
      tags                = merge(local.tags_generic, local.tags_ssm_ec2messages)
    }
  }
}

module "vpc_ssm_endpoint_target" {

  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.13.0"

  vpc_id             = module.tutorial_target_vpc.vpc_id
  security_group_ids = [module.target_https_443_target_security_group.security_group_id]

  endpoints = {
    ssm = {
      service             = "ssm"
      private_dns_enabled = true
      subnet_ids          = module.tutorial_target_vpc.private_subnets
      tags                = merge(local.tags_generic, local.tags_ssm_ssm)
    },
    ssmmessages = {
      service             = "ssmmessages"
      private_dns_enabled = true,
      subnet_ids          = module.tutorial_target_vpc.private_subnets
      tags                = merge(local.tags_generic, local.tags_ssm_ssmmessages)
    },
    ec2messages = {
      service             = "ec2messages",
      private_dns_enabled = true,
      subnet_ids          = module.tutorial_target_vpc.private_subnets
      tags                = merge(local.tags_generic, local.tags_ssm_ec2messages)
    }
  }
}
