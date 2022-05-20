output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "kubectl_config" {
  description = "kubectl config as generated by the module."
  value       = module.eks.kubeconfig
}

output "config_map_aws_auth" {
  description = "A kubernetes configuration to authenticate to this EKS cluster."
  value       = module.eks.config_map_aws_auth
}

output "node_groups" {
  description = "Outputs from node groups"
  value       = module.eks.node_groups
}

# ## Kubernetes provider : use app workspace
# output "kubernetes_host" {
#   description  = "k8s eks host" 
#   value        = data.aws_eks_cluster.cluster.endpoint
# }
# output "kubernetes_cluster_ca_certificate" {
#   description = "k8s eks certificate"
#   value       = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)

# }
# output "kubernetes_token" {
#   description = "k8s eks token"  
#   value       = data.aws_eks_cluster_auth.cluster.token
#   sensitive   = true
# }

output "eks_cluster_id" {
  description = "EKS cluster name"
  value       = module.eks.cluster_id 
}

output "vault_username" {
  description = "vault user name"
  value       = var.username_vault
}