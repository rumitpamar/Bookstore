resource "aws_ecr_repository" "ecr_repo" {

  name = var.repository_names

  image_scanning_configuration {
    scan_on_push = true
  }
}