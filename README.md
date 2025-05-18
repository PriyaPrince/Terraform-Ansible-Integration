<h3>Automating EC2 Setup with Terraform and Ansible: Integration Project</h3>
In this project, I’ll walk you through my simple yet effective DevOps project where I integrated Terraform and Ansible to automate the provisioning and configuration of an EC2 instance on AWS. This hands-on project helped me solidify the basics of infrastructure as code (IaC) and configuration management.

<h4>🛠️ Project Overview</h4>
* Infrastructure Provisioning: Done using Terraform with reusable modules.</br>
- Configuration Management: Performed using Ansible.</br>
- Tools Used: Terraform, Ansible, AWS EC2, SSH.</br>


🧱 Terraform Setup </br>
🔹 Structure</br>
I created separate Terraform modules for:
EC2 Instance,
Security Group.
These were used inside a root main.tf file to ensure clean and reusable code.

🔹 🔹 Dynamic Inventory & Ansible Execution via Terraform
The entire process of inventory creation and playbook execution is automated using a null_resource and local-exec provisioner in Terraform.
As soon as the EC2 instance is provisioned, Terraform dynamically creates the Ansible inventory file and triggers the Ansible playbook.

resource "null_resource" "ansible_workflow" {
  depends_on = [module.ec2]

  provisioner "local-exec" {
    command = <<EOT
      echo "[web]" > inventory
      echo "${module.ec2.instance_public_ip}" >> inventory
      ansible-playbook -i inventory ansible-playbooks/TA_playbook.yml --private-key ~/.ssh/id_rsa
    EOT
  }
}

🔐 SSH Setup for Ansible</br>
Generated an SSH key pair (id_rsa and id_rsa.pub) on the Terraform server.
Added the public key (id_rsa.pub) to the ~/.ssh/authorized_keys file on the remote EC2 instance.
Used the private key with Ansible to connect to the instance.

🤖 Ansible Configuration
Created a folder named ansible-playbooks.
Inside it, I wrote the configuration logic in TA_playbook.yml.
Ansible installs and configures service Nginx , automatically right after instance creation.

✅ Key Accomplishments</br>

* Infrastructure as Code using modular Terraform
- Dynamic inventory generation using Terraform local-exec
- Automated Ansible execution immediately after provisioning
- Secure, key-based SSH communication with the EC2 instance
- Hands-free provisioning and configuration with a single terraform apply
**************************************************************************************************************




