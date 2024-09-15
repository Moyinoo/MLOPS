

# Endpoint Configuration 1
resource "aws_sagemaker_endpoint_config" "linear_learner_endpoint_config" {
  name = "linear-learner-endpoint-config"

  production_variants {
    variant_name = "AllTraffic"
    model_name = aws_sagemaker_model.linear_learner_model.name
    instance_type = "ml.m5.large"
    initial_instance_count = 1
  }
}

# Endpoint Configuration 2
resource "aws_sagemaker_endpoint_config" "linear_learner_endpoint_config2" {
  name = "linear-learner-endpoint-config"

  production_variants {
    variant_name = "AllTraffic"
    model_name = aws_sagemaker_model.linear_learner_model.name
    instance_type = "ml.m5.large"
    initial_instance_count = 1
  }
}

# SageMaker Endpoint 1
resource "aws_sagemaker_endpoint" "linear_learner_endpoint" {
  name = "linear-learner-endpoint"
  endpoint_config_name = aws_sagemaker_endpoint_config.linear_learner_endpoint_config.name
}

# SageMaker Endpoint 2
resource "aws_sagemaker_endpoint" "linear_learner_endpoint2" {
  name = "linear-learner-endpoint"
  endpoint_config_name = aws_sagemaker_endpoint_config.linear_learner_endpoint_config.name
}
