variable "name" {
  description="This is the name of the repository server"
  default = "webhost"
}

variable "type" {
  description="This is the type of compute instance to create"
  default = "f1-micro"
}

variable database_name {
  description = "The name of the database. For example, `app1`."
}

variable database_service_name {
  description = "The name of the database service to which our user and database schema will be added"
}

variable database_user_name {
  description = "The name of the default database user"
}

variable database_user_host {
  description = "The host for the default database user"
  default     = "%"
}

variable database_user_password {
  description = "The password for the default database user. If not set, a random one will be generated and available in the generated_user_password output variable."
  default     = ""
}

variable "region" {
  description = "The GCP region in which to place the compute instance. Examples are us-central1 "
  default = "us-central1"
}

variable "zone" {
  default = "a"
  description = "The zone within the region in which the compute instances are created"
}

variable "source_image" {
  description="The name of the operating system image to use"
  default = "ubuntu-1604-xenial-v20181030"
}

variable "ssh_user"{
  description = "This is the username performing the provisioning"
}

variable "ssh_pub_key_file"{
  description = "This is the path to the SSH public key file for the ssh_user"
}

variable "ssh_pri_key_file"{
  description = "This is the path to the SSH private key file for the ssh_user"
}

variable "admin_email"{
  description = ""
  default = "sysop@localhost"
}
variable "document_root"{
  description = ""
  default = "/var/www/default"
}

variable "domain_name"{
  description = ""
  default = "localhost"
}

