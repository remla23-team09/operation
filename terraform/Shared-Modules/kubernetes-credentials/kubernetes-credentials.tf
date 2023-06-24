resource "random_password" "random_password" {
  length  = 18
  special = true
}

resource "kubernetes_secret" "k8s_credentials" {
  metadata {
    name = var.name
    namespace = var.namespace
  }

  data = {
    username = var.username
    password = random_password.random_password.result
  }
}