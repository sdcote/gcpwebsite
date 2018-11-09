#####################################################################
# Google Cloud Platform
#####################################################################
provider "google" {
  credentials = "${file("../coyote-systems-service-account.json")}"
  project     = "coyote-systems"
  region      =  "${var.region}"
}
