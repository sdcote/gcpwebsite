# Overview
This is a combination Terraform and Ansible project which places a database and user in an existing CloudSQL database, creates a static IP address, Creates firewall rules for 80 and 443,  creates a compute instance bound to the static IP, and finally uses Ansible to provision Apache2, the latest PHP-FPM and installs Joomla! CMS on the new compute instance.

The Joomal! instance is installed as the default site in the web server. Other virtual hosts can be added to this website instance later with the `gcpvhost` project.

# Terrafor Variables
Create you own .tfvars to configure how you want the script to run:


# To Do
Add Cloudflare configuration for the site.
