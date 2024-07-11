provider "aws" {
  region = var.region
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "aws_eks_cluster" "sock_shop_cluster" {
  name     = var.cluster_name
  role_arn = var.eks_role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

resource "aws_eks_node_group" "sock_shop_node_group" {
  cluster_name    = aws_eks_cluster.sock_shop_cluster.name
  node_group_name = "sock-shop-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_size
    min_size     = var.min_size
  }
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Action"    : "sts:AssumeRole",
      "Effect"    : "Allow",
      "Principal" : {
        "Service" : "ec2.amazonaws.com"
      }
    }]
  })

  managed_policy_arns = var.managed_policy_arns
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "kubernetes_namespace" "sock-shop" {
  metadata {
    name = "sock-shop"
  }
}

module "prometheus" {
  source = "../modules/prometheus"
}

module "grafana" {
  source = "../modules/grafana"
}

module "alertmanager" {
  source = "../modules/alertmanager"
}

resource "kubernetes_deployment" "sock_shop" {
  metadata {
    name      = "sock-shop"
    namespace = kubernetes_namespace.sock-shop.metadata[0].name
  }

  spec {
    selector {
      match_labels = {
        app = "sock-shop"
      }
    }

    template {
      metadata {
        labels = {
          app = "sock-shop"
        }
      }

      spec {
        container {
          name  = "sock-shop"
          image = "weaveworksdemos/sock-shop"
          ports {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "sock_shop" {
  metadata {
    name      = "sock-shop"
    namespace = kubernetes_namespace.sock-shop.metadata[0].name
  }

  spec {
    selector = {
      app = "sock-shop"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
