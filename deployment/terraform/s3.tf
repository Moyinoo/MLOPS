#####################################
### S3 MODULE
#####################################

module "raw-zone" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version       = "4.1.0"
  create_bucket = true
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  bucket        = "${var.tag_env}-${var.project_alias}-raw-zone-${data.aws_caller_identity.current.account_id}"
  acl           = "private"
  force_destroy = true
   # Enable versioning
  versioning = {
    status = "Enabled"  # Correct format for a map of strings
  }
}

module "procced-zone" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version       = "4.1.0"
  create_bucket = true
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  bucket        = "${var.tag_env}-${var.project_alias}-processed-zone-${data.aws_caller_identity.current.account_id}"
  acl           = "private"
  force_destroy = true
   # Enable versioning
 versioning = {
    status = "Enabled"  
  }
}

module "codepipeline_artifact_storage" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version       = "4.1.0"
  create_bucket = true
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  bucket        = "${var.tag_env}-${var.project_alias}-codepipeline-artifact-storage-${data.aws_caller_identity.current.account_id}"
  acl           = "private"
  force_destroy = true
   # Enable versioning
 versioning = {
    status = "Enabled"  
  }
}

module "codedeploy_artifact_storage" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version       = "4.1.0"
  create_bucket = true
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  bucket        = "${var.tag_env}-${var.project_alias}-codedeploy_artifact_storage-${data.aws_caller_identity.current.account_id}"
  acl           = "private"
  force_destroy = true
   # Enable versioning
 versioning = {
    status = "Enabled"  
  }
}

# saving s3 bucket output files into ssm
resource "aws_ssm_parameter" "save_name_of_s3_for_output_files_to_ssm" {
  name        = "/${var.tag_env}/${var.project_alias}/s3_bucket/for_output_files/name"
  description = "The URL for the created Amazon SQS queue"
  type        = "SecureString"
  value       = "${var.tag_env}-output-files-${data.aws_caller_identity.current.account_id}"
}

