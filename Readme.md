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


# To Do
* Add Cloudflare configuration for the site.
* Add Public IP of webserver to Authorized networks for CloudSQL database.
    
