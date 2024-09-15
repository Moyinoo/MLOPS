# Create the Model Build repository in AWS CodeCommit
resource "aws_codecommit_repository" "model_build_repo" {
  repository_name = "${var.tag_env}/${var.project_alias}/ModelBuildRepo"
  description     = "Code repository for model build pipeline"
}

# Create the Deployment repository in AWS CodeCommit
resource "aws_codecommit_repository" "deployment_repo" {
  repository_name = "${var.tag_env}/${var.project_alias}/DeploymentRepo"
  description     = "Code repository for deployment pipeline"
}
