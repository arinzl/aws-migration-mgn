resource "aws_iam_user" "mgn_user" {
  #checkov:skip=CKV_AWS_273: "Ensure access is controlled through SSO and not AWS IAM defined users"
  name = "MGNMigrationUser"
}

resource "aws_iam_access_key" "AccK" {
  user = aws_iam_user.mgn_user.name
}

resource "aws_iam_user_policy_attachment" "test-attach" {
  #checkov:skip=CKV_AWS_40: "Ensure IAM policies are attached only to groups or roles (Reducing access management complexity may in-turn reduce opportunity for a principal to inadvertently receive or retain excessive privileges.)"
  user       = aws_iam_user.mgn_user.name
  policy_arn = "arn:aws:iam::aws:policy/AWSApplicationMigrationAgentPolicy"
}



#--------------------------------------------------------------------------
# SSM EC2 assumable role 
#--------------------------------------------------------------------------

resource "random_id" "random_id" {
  byte_length = 5

}

module "demo_mgn_ec2_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "4.17.1"

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  role_requires_mfa       = false
  create_role             = true
  create_instance_profile = true

  role_name = "demo-mgn-ec2-assumable-role-${random_id.random_id.hex}"

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  ]

  tags = local.tags_generic
}

