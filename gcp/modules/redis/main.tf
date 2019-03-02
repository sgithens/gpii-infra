terraform {
    backend "gcs" {}
}

variable "secrets_dir" {}
variable "charts_dir" {}

module "redis" {
  source           = "/exekube-modules/helm-release"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name            = "redis"
  release_namespace       = "gpii"
  release_values          = ""
  release_values_rendered = ""

  chart_name = "${var.charts_dir}/redis"
}
