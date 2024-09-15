
# Create a SageMaker model using a pre-built TensorFlow container
resource "aws_sagemaker_model" "linear_learner_model" {
  name = "linear-learner-model"

  execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/SageMakerExecutionRole"

  primary_container {
    image = "382416733822.dkr.ecr.us-east-1.amazonaws.com/linear-learner:latest"
    model_data_url = "s3://${var.tag_env}-${var.project_alias}-codepipeline-artifact-storage-${data.aws_caller_identity.current.account_id}/output/model.tar.gz"
  }
}
