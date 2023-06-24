module "namespaces" {
  source = "../Shared-Modules/kubernetes-namespace"

  for_each = var.namespaces

  namespace_name = each.key
  annotations    = each.value.annotations
  labels         = each.value.labels
}

module "istio_base" {
  depends_on = [module.namespaces]

  source     = "../Shared-Modules/helm-chart"
  name       = "istio-base"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "base"

  chart_version = var.chart_config_istio_base.version
  namespace     = var.chart_config_istio_base.namespace

  set_maps = var.chart_config_istio_base.set_maps
}

module "istiod" {
  depends_on = [module.istio_base]

  source     = "../Shared-Modules/helm-chart"
  name       = "istiod"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istiod"

  chart_version = var.chart_config_istiod.version
  namespace     = var.chart_config_istiod.namespace

  set_maps = var.chart_config_istiod.set_maps
}

module "istio_ingressgateway" {
  depends_on = [module.istiod]

  source     = "../Shared-Modules/helm-chart"
  name       = "istio-ingressgateway"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "gateway"

  chart_version = var.chart_config_istio_ingressgateway.version
  namespace     = var.chart_config_istio_ingressgateway.namespace

  set_maps = var.chart_config_istio_ingressgateway.set_maps
}

module "kube_prometheus_stack" {
  depends_on = [module.istio_ingressgateway]

  source        = "../Shared-Modules/helm-chart"
  name          = "kube-prometheus"
  repository    = "https://charts.bitnami.com/bitnami"
  chart         = "kube-prometheus"
  chart_version = var.chart_config_kube_prometheus_stack.version

  namespace = var.chart_config_kube_prometheus_stack.namespace

  timeout = var.chart_config_kube_prometheus_stack.timeout

  set_maps = var.chart_config_kube_prometheus_stack.set_maps
}

module "grafana_public_ip" {
  depends_on = [module.kube_prometheus_stack]

  source = "../Shared-Modules/ip-address"
  name = "${var.project}-${var.team}-grafana-public-ip"
}

module "grafana_admin_credentials" {
  depends_on = [module.grafana_public_ip]

  source = "../Shared-Modules/kubernetes-credentials"
  name = "grafana-admin-credentials"
  namespace = var.chart_config_grafana.namespace
  username = "team09-admin"
}

module "grafana_dashboards" {
  depends_on = [module.grafana_admin_credentials]

  source = "../Shared-Modules/grafana-dashboard"

  for_each = var.grafana_dashboards

  name      = each.key
  file_path = each.value.file_path
  namespace = each.value.namespace

  labels    = each.value.labels
}

module "grafana_persistent_volume" {
  depends_on = [module.grafana_dashboards]

  source = "../Shared-Modules/kubernetes-persistent-volume"

  metadata = {
    name = "grafana-persistent-volume"
  }

  spec = {
    storage = "10Gi"
    access_modes = ["ReadWriteMany"]
    vsphere_volume_path = "/data/grafana"
  }
}

module "grafana_persistent_volume_claim" {
  depends_on = [module.grafana_persistent_volume]

  source = "../Shared-Modules/kubernetes-persistent-volume-claim"

  metadata = {
    name = "grafana-persistent-volume-claim"
  }

  spec = {
    storage = "10Gi"
    access_modes = ["ReadWriteMany"]
    volume_name = module.grafana_persistent_volume.pv_name
  }
}

module "grafana" {
  depends_on = [module.grafana_dashboards]

  source        = "../Shared-Modules/helm-chart"
  name          = "grafana"
  repository    = "https://charts.bitnami.com/bitnami"
  chart         = "grafana"
  chart_version = var.chart_config_grafana.version

  namespace = var.chart_config_grafana.namespace

  values = ["${file("./values/grafana.yaml")}",
            "persistance.existingClaim=${module.grafana_persistent_volume_claim.pvc_name}"
          ]

  set_maps = var.chart_config_grafana.set_maps
}

module "kiali_server" {
  depends_on = [module.grafana]

  source        = "../Shared-Modules/helm-chart"
  name          = "kiali-server"
  repository    = "https://kiali.org/helm-charts"
  chart         = "kiali-server"
  chart_version = var.chart_config_kiali_server.version

  namespace = var.chart_config_kiali_server.namespace

  values = concat(var.chart_config_kiali_server.values)

  set_maps = var.chart_config_kiali_server.set_maps
}

