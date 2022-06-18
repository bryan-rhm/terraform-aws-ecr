resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability

  encryption_configuration {
    encryption_type = var.kms_key_arn == null ? "AES256" : "KMS"
    kms_key         = var.kms_key_arn
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = var.tags
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name
  policy     = var.lifecycle_policy != null ? var.lifecycle_policy : <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Managed by Terraform - Untagged",
            "selection": {
                "tagStatus": "untagged",
                "countType": "imageCountMoreThan",
                "countNumber": 1
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 2,
            "description": "Managed by Terraform - Historical Images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": ${var.max_image_count}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

resource "aws_ecr_repository_policy" "policy" {
  count      = length(var.allowed_account_ids) > 0 ? 1 : 0
  repository = aws_ecr_repository.this.name

  policy = jsonencode({
    Version = "2008-10-17"
    Statement = [{
      Sid = "AllowECR"
      Effect = "Allow"
      Principal = {
        AWS = var.allowed_account_ids
      }
      Action = [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:DescribeRepositories",
        "ecr:GetRepositoryPolicy",
        "ecr:ListImages",
        "ecr:DeleteRepository",
        "ecr:BatchDeleteImage",
        "ecr:SetRepositoryPolicy",
        "ecr:DeleteRepositoryPolicy"
      ]
    }]
  })
}