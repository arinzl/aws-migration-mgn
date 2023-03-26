
#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
variable "region" {
  description = "Primary region for deployment"
  type        = string
}

variable "environment" {
  description = "Organisation environment"
  type        = string
}

variable "ManagedByLocation" {
  description = "Location of Infrastructure of Code"
  type        = string
}



#------------------------------------------------------------------------------
# VPCs (Source and Target)
#------------------------------------------------------------------------------

variable "vpc_cidr_range_source" {
  type = string

}

variable "private_subnets_source_list" {
  description = "Private subnet list for infrastructure"
  type        = list(string)

}

variable "public_subnets_source_list" {
  description = "Public subnet list for infrastructure"
  type        = list(string)

}

variable "vpc_cidr_range_target" {
  type = string

}

variable "private_subnets_target_list" {
  description = "Private subnet list for target infrastructure"
  type        = list(string)

}

variable "public_subnets_target_list" {
  description = "Private subnet list for target infrastructure"
  type        = list(string)

}


#------------------------------------------------------------------------------
# EC2
#------------------------------------------------------------------------------

variable "ec2_app_name" {
  description = "Application running on EC2 instance"
  type        = string

}
