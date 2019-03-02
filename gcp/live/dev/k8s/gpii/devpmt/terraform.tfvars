# ↓ Module metadata
terragrunt = {
  terraform {
    source = "/project/modules//gpii-devpmt"
  }

  dependencies {
    paths = [
      "../../kube-system/cert-manager",
      "../nginx-ingress",
      "../couchdb",
      "../redis"
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

cert_issuer_name     = "letsencrypt-staging"
disable_ssl_redirect = "true"

replica_count     = 2
requests_cpu      = "250m"
requests_memory   = "256Mi"
limits_cpu        = "500m"
limits_memory     = "256Mi"
