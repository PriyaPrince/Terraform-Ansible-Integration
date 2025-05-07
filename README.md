<h3>Automating EC2 Setup with Terraform and Ansible: Integration Project</h3>
In this project, I’ll walk you through my simple yet effective DevOps project where I integrated Terraform and Ansible to automate the provisioning and configuration of an EC2 instance on AWS. This hands-on project helped me solidify the basics of infrastructure as code (IaC) and configuration management.

<h4>🛠️ Project Overview</h4>
Infrastructure Provisioning: Done using Terraform with reusable modules.
Configuration Management: Performed using Ansible.
Tools Used: Terraform, Ansible, AWS EC2, SSH.

🧱 Terraform Setup
🔹 Structure
I created separate Terraform modules for:
EC2 Instance
Security Group
These were used inside a root main.tf file to ensure clean and reusable code.

🔹 Local Exec for Inventory
In main.tf, I used a local-exec provisioner only to generate the Ansible inventory file dynamically:
provisioner "local-exec" {
  command = "echo '[web]' > inventory && echo '${aws_instance.web_instance.public_ip}' >> inventory"
}

🔐 SSH Setup for Ansible
Generated an SSH key pair (id_rsa and id_rsa.pub) on the Terraform server.
Added the public key (id_rsa.pub) to the ~/.ssh/authorized_keys file on the remote EC2 instance.
Used the private key with Ansible to connect to the instance.

🤖 Ansible Configuration
I created a folder named ansible-playbooks and inside it, a playbook called TA_playbook.yml. 

🔹 Ansible Command
ansible-playbook -i /home/ec2-user/Terraform-Asnsible_Intgratn_Prjct/inventory \
/home/ec2-user/ansible-playbooks/TA_playbook.yml \
--private-key ~/.ssh/id_rsa

✅ Key Accomplishments
Infrastructure as Code with modular Terraform

Dynamic inventory creation with local-exec

Secure, key-based Ansible communication




