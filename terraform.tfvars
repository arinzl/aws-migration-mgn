region            = "ap-southeast-2"
environment       = "prod"
ManagedByLocation = "https://github.com/arinzl"

vpc_cidr_range_source       = "172.16.0.0/20"
private_subnets_source_list = ["172.16.0.0/24"]
public_subnets_source_list  = ["172.16.3.0/24"]

ec2_app_name = "tutorial-Web-MGN"

vpc_cidr_range_target       = "172.17.0.0/20"
private_subnets_target_list = ["172.17.0.0/24"]
public_subnets_target_list  = ["172.17.3.0/24"]
