# infra/terraform/outputs.tf
output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_oidc_issuer_url" {
  value = module.eks.cluster_oidc_issuer_url
}
output "alb_controller_role_arn" {
  description = "IAM role ARN for AWS Load Balancer Controller"
  value       = module.alb_controller_irsa.iam_role_arn
}
output "vpc_id" {
  description = "VPC ID used by EKS"
  value       = module.vpc.vpc_id
}