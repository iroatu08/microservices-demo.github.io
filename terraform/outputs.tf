output "cluster_endpoint" {
  value = aws_eks_cluster.sock_shop_cluster.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.sock_shop_cluster.name
}

output "vpc_id" {
  value = var.vpc_id
}

output "subnet_ids" {
  value = var.subnet_ids
}
