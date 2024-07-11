region               = "us-west-2"
vpc_id               = "vpc-0c2b8f643721db25b"  # Replace with your VPC ID
subnet_ids           = ["subnet-088b8c6e9809c807b", "subnet-0b83d2b0e52036120","subnet-08233bf7da933ad0d"]  # Replace with your Subnet IDs
eks_role_arn         = "arn:aws:iam::891377368636:role/myEKSClusterRole"  # Replace with your IAM Role ARN
managed_policy_arns  = [
  "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
  "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
]