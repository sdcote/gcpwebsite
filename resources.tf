// Static IP Address
resource "google_compute_address" "build-static-ip-address" {
  name = "${var.name}-static-ip"
  region = "${var.region}"
}


// Firewall rules
resource "google_compute_firewall" "host" {
  name = "${var.name}-firewall"
  network = "default"
  allow {
    protocol = "tcp"
    ports = ["80", "443"]
  }
  source_ranges = ["0.0.0.0/0"]
}


// Random password for the database user if one is not found
resource "random_id" "user-password" {
  byte_length = 8
}


// database schema
resource "google_sql_database" "database" {
  instance = "${var.database_service_name}"
  name = "${var.database_name == "" ? var.database_user_name : var.database_name}"
}


// database user
resource "google_sql_user" "users" {
  name = "${var.database_user_name}"
  instance = "${var.database_service_name}"
  host = "${var.database_user_host}"
  password = "${var.database_user_password == "" ? random_id.user-password.hex : var.database_user_password}"
}


// Compute Instance
resource "google_compute_instance" "host" {
  name = "${var.name}"
  machine_type = "${var.type}"
  zone = "${var.region}-${var.zone}"
  tags = ["web","cms"]

  boot_disk {
    initialize_params {
      image = "${var.source_image}"
    }
  }

  // associate SSH public key for the given user to this compute instance
  metadata {
    sshKeys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }

 // connect this compute instance to the default network using the static IP created above
  network_interface {
    network = "default"
    access_config {
      nat_ip = "${google_compute_address.build-static-ip-address.address}"
    }
  }

  // Install Python so Ansible can provision this compute instance
  // Also as the universe repository since it is not enabled by default
  // Needed for 16.04 to retrieve 7.2 - sudo add-apt-repository ppa:ondrej/php
  provisioner "remote-exec" {
    inline = [
      "sudo add-apt-repository universe",
      "sudo apt-get update",
      "sudo apt-get install -y python2.7 python-pip",
      "sudo apt-get install -y python3-pip",
    ]
    connection {
      type        = "ssh"
      user        = "${var.ssh_user}"
      private_key = "${file(var.ssh_pri_key_file)}"
    }
  }

  // Call ansible locally to log into the host and provision it using our playbook.
  // Note the inventory (-i) uses the IPv4 address appended with a comma and the playbook must contain 'hosts: all' to work properly.
  provisioner "local-exec" {
    command = "ansible-playbook -u ${var.ssh_user} -i '${google_compute_instance.host.network_interface.0.access_config.0.assigned_nat_ip},' --private-key ${var.ssh_pri_key_file} -T 300 playbook.yml --extra-vars \"admin_email=${var.admin_email} document_root=${var.document_root} domain_name=${var.domain_name}\"" 
  }

}

