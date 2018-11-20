# Overview
This is a combination Terraform and Ansible project which places a database and user in an existing CloudSQL database, creates a static IP address, Creates firewall rules for 80 and 443,  creates a compute instance bound to the static IP, and finally uses Ansible to provision Apache2, the latest PHP-FPM and installs Joomla! CMS on the new compute instance.

The Joomal! instance is installed as the default site in the web server. Other virtual hosts can be added to this website instance later with the `gcpvhost` project.

# Terraform Variables
Create you own *.tfvars to configure how you want the script to run:

    database_service_name = "webdb"
    database_name = "default"
    database_user_name = "default"
    name = "webhost"
    type = "f1-micro"
    region = "us-central1"
    zone = "a"
    source_image = "ubuntu-1804-bionic-v20181029"
    ssh_user = "ansible"
    ssh_pub_key_file = "../ansible-public-key.txt"
    ssh_pri_key_file = "../ansible-private-key.txt"

The `ssh_user` is the user name configuring the system. In the above the `ssh_user` of "ansible" will be used. The `ssh_pub_key_file` and the `ssh_pri_key_file` are the RSA public and private keys provisioned in the compute instance and used by Ansible to connect and provision the web host.

# Running Ansible Separately
There are times when you may want to run playbooks separately. This is easily done. All that is needed is the IP address of the host and the credentials used to configure the host. The following command is what is run by the Terraform script to provision the compute instance resource:

    ansible-playbook -u ansible -i '35.139.207.56,' --private-key '../ansible-private-key.txt' -T 300 playbook.yml --extra-vars @ansible-vars.json

Calling `terraform show` should give you the IP address of the compute instance. The user added to the compute instance is whatever you specified in the `*.tfvars` file along with the public-private SSH keypair files.

# To Do
* Add Cloudflare configuration for the site.
* Add Public IP of webserver to Authorized networks for CloudSQL database.
    
