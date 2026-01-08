# infra/terraform/vpc.tf
data "aws_availability_zones" "available" {
  state = "available"
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.1"

  name = "${var.project_name}-${var.environment}-vpc"
  cidr = var.vpc_cidr

  azs = slice(
    data.aws_availability_zones.available.names,
    0,
    var.az_count
  )

  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  # EKS subnet tagging
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"            = "1"
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
