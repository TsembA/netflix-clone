locals {
  azs = slice(
    data.aws_availability_zones.available.names,
    0,
    var.az_count
  )

  private_subnets = [
    for i in range(var.az_count) :
    cidrsubnet(var.vpc_cidr, 8, i)
  ]

  public_subnets = [
    for i in range(var.az_count) :
    cidrsubnet(var.vpc_cidr, 8, i + 100)
  ]
}
