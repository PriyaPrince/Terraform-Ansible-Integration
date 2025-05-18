provider "aws" {
  region = "ap-south-1"
}

module "sec_group" {
  source              = "./modules/sec_group"
  security_group_name = "my-sg"
  description         = "Allow SSH and HTTP"
}

module "ec2" {
  source            = "./modules/ec2"
  ami               = "ami-062f0cc54dbfd8ef1"
  instance_type     = "t2.micro"
  key_name          = "ALinuxKeyPair"
  security_group_id = module.sec_group.security_group_id
  instance_name     = "web-ec2"
}

resource "null_resource" "generate_inventory" {
  depends_on = [module.ec2]

  provisioner "local-exec" {
    command = <<EOT
      echo "[web]" > inventory
      echo "${module.ec2.instance_public_ip}" >> inventory
      ansible-playbook -i inventory ansible-playbooks/TA_playbook.yml --private-key ~/.ssh/id_rsa
    EOT
  }
}

