


# Define the Model Build pipeline
resource "aws_codepipeline" "ml_pipeline" {
  name     = "ml-pipeline"
  role_arn = aws_iam_role.codepipeline_model_build_role.arn

  artifact_store {
    type     = "S3"
    location = "${var.tag_env}-${var.project_alias}-codedeploy_artifact_storage-${data.aws_caller_identity.current.account_id}"
  }


  stage {
    name = "Source"

    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        Owner  = "Moyinoo"
        Repo   = "MLOPS"
        Branch = "main"
        OAuthToken = "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"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = aws_codebuild_project.ml_build.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "SageMaker"
      version          = "1"
      input_artifacts  = ["build_output"]

      configuration = {
        ModelName          = aws_sagemaker_model.linear_learner_model.name
        EndpointConfigName = aws_sagemaker_endpoint_config.linear_learner_endpoint_config.name
      }
    }
  }
}
