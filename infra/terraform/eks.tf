#  infra/terraform/eks.tf
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  # -----------------------------
  # Cluster (control plane)
  # -----------------------------
  cluster_name    = "${var.project_name}-${var.environment}"
  cluster_version = var.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  enable_irsa = true

  # -----------------------------
  # Managed Node Groups
  # -----------------------------
  eks_managed_node_groups = {
    default = {
      name = "default-ng"

      instance_types = ["t3.medium"]

      desired_size = 2
      min_size     = 1
      max_size     = 3

      disk_size = 30

      labels = {
        role = "general"
      }

      tags = {
        Name = "${var.project_name}-${var.environment}-node"
      }
    }
  }

  # -----------------------------
  # Tags
  # -----------------------------
  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
