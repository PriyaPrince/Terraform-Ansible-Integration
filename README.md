<h2>Automating EC2 Setup with Terraform and Ansible: Integration Project</h2>
In this project, I’ll walk you through my simple yet effective DevOps project where I integrated Terraform and Ansible to automate the provisioning and configuration of an EC2 instance on AWS. This hands-on project helped me solidify the basics of infrastructure as code (IaC) and configuration management.

<h3>🛠️ Project Overview</h3>

* Infrastructure Provisioning: Done using Terraform with reusable modules.
- Configuration Management: Performed using Ansible.
- Tools Used: Terraform, Ansible, AWS EC2, SSH.


<h3>🧱 Terraform Setup </h3>
🔹 Structure</br>
I created separate Terraform modules for:
EC2 Instance,
Security Group.
These were used inside a root main.tf file to ensure clean and reusable code.

<h3>🔹 Dynamic Inventory & Ansible Execution via Terraform </h3>
The entire process of inventory creation and playbook execution is automated using a null_resource and local-exec provisioner in Terraform.
As soon as the EC2 instance is provisioned, Terraform dynamically creates the Ansible inventory file and triggers the Ansible playbook.

```
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
```

<h3>🔐 SSH Setup for Ansible</h3>
Generated an SSH key pair (id_rsa and id_rsa.pub) on the Terraform server.</br>
Added the public key (id_rsa.pub) to the ~/.ssh/authorized_keys file on the remote EC2 instance.</br>
Used the private key with Ansible to connect to the instance.

<h3>🤖 Ansible Configuration</h3>
Created a folder named ansible-playbooks. </br>
Inside it, I wrote the configuration logic in TA_playbook.yml.</br>
Ansible installs and configures service Nginx , automatically right after instance creation.

<h3>✅ Key Accomplishments</h3>

* Infrastructure as Code using modular Terraform
- Dynamic inventory generation using Terraform local-exec
- Automated Ansible execution immediately after provisioning
- Secure, key-based SSH communication with the EC2 instance
- Hands-free provisioning and configuration with a single terraform apply
**************************************************************************************************************




