# Installation  

Please see #TODO for detailed explaination.

## Requirements:
- Terraform CLI installed with access to your target AWS account
- MGN service has been enabled on target account


## Deployment
- Clone repo into folder
- Run command 'Terraform init'
- Optional Checkov check via  "checkov -d . --download-external-modules True"
- Run command 'Terraform plan' 
- Run command 'Terraform apply' and type 'yes' to confirm deployment


## Tidy up
- Manual delete resources created manually or through MGN process
- Run command 'Terraform destroy'
 
