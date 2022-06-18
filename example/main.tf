provider "aws" {
  region = "us-east-1"
}

module "ecr" {
  source            = "../"
  name              = "ecr-repo"
  max_image_count   = 100
  tags = {
    test = "test"
  }
}