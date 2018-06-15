resource "aws_ecr_repository" "repo" {
  name = "${var.project_name}/${var.repo_name}"

  provisioner "local-exec" "image-preparation" {
    command = <<EOF
    eval $(aws ecr get-login --region ${var.aws_region})
    cd ../../../${var.repo_name} &&
    docker build --tag ${aws_ecr_repository.repo.repository_url}:latest .
    docker push ${aws_ecr_repository.repo.repository_url}:latest
  EOF
  }
}
