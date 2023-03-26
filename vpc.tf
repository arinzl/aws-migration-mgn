
#------------------------------------------------------------------------------
# VPC Module
#------------------------------------------------------------------------------
module "tutorial_source_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"
  #checkov:skip=CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
  #checkov:skip=CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints"
  #checkov:skip=CKV2_AWS_12: "Ensure the default security group of every VPC restricts all traffic"

  name = "source-${var.environment}-vpc"
  cidr = var.vpc_cidr_range_source

  azs             = ["${var.region}a"]
  private_subnets = var.private_subnets_source_list
  public_subnets  = var.public_subnets_source_list

  enable_flow_log                      = false
  create_flow_log_cloudwatch_log_group = false
  create_flow_log_cloudwatch_iam_role  = false
  flow_log_max_aggregation_interval    = 60

  create_igw         = true
  enable_nat_gateway = true
  enable_ipv6        = false

  enable_dns_hostnames = true
  enable_dns_support   = true

}



module "tutorial_target_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"
  #checkov:skip=CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
  #checkov:skip=CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints"
  #checkov:skip=CKV2_AWS_12: "Ensure the default security group of every VPC restricts all traffic"

  name = "target-${var.environment}-vpc"
  cidr = var.vpc_cidr_range_target

  azs             = ["${var.region}a"]
  private_subnets = var.private_subnets_target_list
  public_subnets  = var.public_subnets_target_list

  private_subnet_names = ["target-private-subnet-a"]
  public_subnet_names  = ["target-public-subnet-a"]

  enable_flow_log                      = false
  create_flow_log_cloudwatch_log_group = false
  create_flow_log_cloudwatch_iam_role  = false
  flow_log_max_aggregation_interval    = 60

  create_igw         = true
  enable_nat_gateway = true
  enable_ipv6        = false

  enable_dns_hostnames = true
  enable_dns_support   = true

}






