resource "kubernetes_namespace" "test-create" {
  metadata {
    name    = "my-namespace"
  }
}
