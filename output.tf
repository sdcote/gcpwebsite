output instance_address {
  description = "The IPv4 address of the CMS host"
  value = "${google_compute_instance.host.network_interface.0.access_config.0.assigned_nat_ip}"
}

output database_user_name {
  description = "The name of the root user for the database"
  value       = "${google_sql_user.users.name}"
}

output database_user_passwd {
  description = "The password of the root user for the database"
  value       = "${google_sql_user.users.password}"
}

output generated_user_password {
  description = "The auto generated database user password if no input password was provided"
  value       = "${random_id.user-password.hex}"
  sensitive   = false
}