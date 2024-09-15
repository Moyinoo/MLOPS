
resource "aws_sagemaker_training_job" "linear_learner_training_job" {
  name = "linear-learner-training-job"

  algorithm_specification {
    training_image = "382416733822.dkr.ecr.us-east-1.amazonaws.com/linear-learner:latest"
    training_input_mode = "File"
  }

  role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/SageMakerExecutionRole"

  input_data_config {
    channel_name = "train"
    data_source {
      s3_data_source {
        s3_data_type = "S3Prefix"
        s3_uri = "s3://${var.tag_env}-${var.project_alias}-raw-zone-${data.aws_caller_identity.current.account_id}/customer_data.csv"
        s3_data_distribution_type = "FullyReplicated"
      }
    }
    content_type = "text/csv"
  }

  output_data_config {
    s3_output_path = "s3://${var.tag_env}-${var.project_alias}-codepipeline-artifact-storage-${data.aws_caller_identity.current.account_id}/output/"
  }

  resource_config {
    instance_type  = "ml.m5.large"
    instance_count = 1
    volume_size_in_gb = 10
  }

  stopping_condition {
    max_runtime_in_seconds = 3600
  }

  hyperparameters = {
    "predictor_type" = "binary_classifier"
    "mini_batch_size" = "100"
  }
}
