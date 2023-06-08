resource "helm_release" "helm_chart" {
  name                = var.name
  repository          = var.repository
  chart               = var.chart
  namespace           = var.namespace
  version             = var.chart_version
  timeout             = var.timeout
  wait                = var.wait
  force_update        = true

  values = var.values

  dynamic "set" {
    for_each = var.set_maps
    content {
      name  = set.key
      value = set.value
    }
  }
}
