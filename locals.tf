locals {

  tags_generic = {
    environment = var.environment
    costcentre  = "TBC"
    ManagedBy   = var.ManagedByLocation
  }

  tag_backup = {
    Application = "Tutorial MGN Souce"
  }


  tags_ssm_ssm = {
    Name = "myvpc-vpce-interface-ssm-ssm"
  }

  tags_ssm_ssmmessages = {
    Name = "myvpc-vpce-interface-ssm-ssmmessages"
  }

  tags_ssm_ec2messages = {
    Name = "myvpc-vpce-interface-ssm-ec2messages"
  }

  user_data_prod = <<-EOT

  #!/bin/bash
  yum update -y

  yum install -y httpd.x86_64
  systemctl start httpd.service
  systemctl enable httpd.service
  echo “Hello World from $(hostname -f)” > /var/www/html/index.html

  sudo mkdir -p /data 
  sudo mkfs.xfs /dev/xvdb
  sudo echo "$(blkid -o export /dev/xvdb | grep ^UUID=) /data xfs defaults,noatime" | tee -a /etc/fstab
  sudo mount -a
  echo "data file - build stage" > /data/newfile1.txt

  cd ~
  wget -O ./aws-replication-installer-init.py https://aws-application-migration-service-ap-southeast-2.s3.ap-southeast-2.amazonaws.com/latest/linux/aws-replication-installer-init.py
  #sudo python3 aws-replication-installer-init.py --region ap-southeast-2 --aws-access-key-id ${aws_iam_access_key.AccK.id}  --aws-secret-access-key ${aws_iam_access_key.AccK.secret} --no-prompt

  EOT
}
