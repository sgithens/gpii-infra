data "kubernetes_service" "istio-ingressgateway" {
  metadata {
    name      = "istio-ingressgateway"
    namespace = "istio-system"
  }

  # This dependency is to defer data source refresh until the apply phase and
  # avoid an error when running destroy on non-existing cluster
  depends_on = ["data.template_file.devpmt_values"]
}

resource "google_dns_record_set" "devpmt-dns" {
  name         = "devpmt.${var.domain_name}."
  project      = "${var.project_id}"
  managed_zone = "${replace(var.domain_name, ".", "-")}"

  type    = "A"
  ttl     = 300
  rrdatas = ["${data.kubernetes_service.istio-ingressgateway.load_balancer_ingress.0.ip}"]
}
