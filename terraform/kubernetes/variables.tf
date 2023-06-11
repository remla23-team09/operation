variable "project" {
  type    = string
  default = "remla23"
}

variable "team" {
  type    = string
  default = "team09"
}

variable "kubeconfig" {
  type    = string
  default = "./config"
}


variable "namespaces" {
  description = "A map of namespaces to create"
  default = {
    "monitoring" = {
      annotations = {}
      labels      = { "istio-injection" : "enabled" }
    }
    "istio-system" = {
      annotations = {}
      labels      = { "istio-injection" : "enabled" }
    }
  }
}

variable "chart_config_istio_base" {
  description = "A configmap for istio base"
  default = {
    version   = "1.18.0"
    namespace = "istio-system"
    set_maps = {
      "prometheus.enabled"             = "true"
      "kiali.enabled"                  = "true"
      "grafana.enabled"                = "true"
      "app.kubernetes.io/managed-by"   = "Helm"
      "meta.helm.sh/release-name"      = "istio-base"
      "meta.helm.sh/release-namespace" = "istio-system"
    }
  }
}

variable "chart_config_istiod" {
  description = "A configmap for istiod"
  default = {
    version   = "1.18.0"
    namespace = "istio-system"
    set_maps = {
      "prometheus.enabled"             = "true"
      "kiali.enabled"                  = "true"
      "grafana.enabled"                = "true"
      "app.kubernetes.io/managed-by"   = "Helm"
      "meta.helm.sh/release-name"      = "istiod"
      "meta.helm.sh/release-namespace" = "istio-system"
    }
  }
}

variable "chart_config_istio_ingressgateway" {
  description = "A configmap for istio ingressgateway"
  default = {
    version   = "1.18.0"
    namespace = "istio-system"
    set_maps  = {}
  }
}

variable "chart_config_kube_prometheus_stack" {
  description = "A configmap for kube prometheus stack"
  default = {
    version   = "8.13.0"
    namespace = "monitoring"
    timeout   = 1200
    set_maps  = {}
  }
}

variable "chart_config_grafana_operator" {
  description = "A configmap for kube prometheus stack"
  default = {
    version   = "2.9.3"
    namespace = "monitoring"

    values = [
      "sidecar.dashboards.enabled: true",
      "sidecar.dashboards.searchNamespace: ALL",
      "service.loadBalancerIP: 34.141.178.188"
    ]

    set_maps = {
      "grafana.ini.paths.provisioning"            = "/etc/grafana/provisioning"
      "grafana.ini.dashboard.labels.provider"     = "enabled"
      "grafana.ini.dashboard.labels.sc_dashboard" = "1"
    }
  }
}

variable "grafana_dashboards" {
  description = "A configmap for grafaba dashboards"
  default = {
    "remla23-team09" = {
      namespace = "monitoring"
      file_path = "../../grafana/remla23-team09.json"
      labels = {
        grafana_dashboard = "1"
      }
    }
  }
}

variable "chart_config_kiali_server" {
  description = "A configmap for grafaba dashboards"
  default = {
    version   = "1.69.0"
    namespace = "istio-system"

    values = []

    set_maps = {}
  }
}
