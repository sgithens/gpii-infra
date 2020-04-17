terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}
variable "charts_dir" {}

variable "productiontests_repository" {}
variable "productiontests_checksum" {}

variable "secret_couchdb_admin_username" {}
variable "secret_couchdb_admin_password" {}

data "template_file" "productiontests_values" {
  template = "${file("values.yaml")}"

  vars {
    productiontests_repository = "${var.productiontests_repository}"
    productiontests_checksum   = "${var.productiontests_checksum}"

    couchdb_admin_username = "${var.secret_couchdb_admin_username}"
    couchdb_admin_password = "${var.secret_couchdb_admin_password}"
  }
}

module "gpii-productiontests" {
  source           = "/exekube-modules/helm-release"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name            = "productiontests"
  release_namespace       = "gpii"
  release_values          = ""
  release_values_rendered = "${data.template_file.productiontests_values.rendered}"

  chart_name   = "${var.charts_dir}/gpii-productiontests"
  force_update = true
}
