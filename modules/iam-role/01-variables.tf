## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - IAM Execution Role Module
## Modification History:
##   - 1.0.0    May 22,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

######################################## Project Name ##############################################
variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "project"
}

######################################## Environment Name ##########################################
variable "environment_name" {
  description = "The name of the environment"
  type        = string
  default     = "devl"
}

######################################## KMS Key ###################################################
variable "kms_key_alias" {
  description = "KMS Key Alias"
  type        = string
  default     = "SB-KMS"
}

variable "kms_key_arn" {
  description = "KMS Key Arn"
  type        = string
  default     = "arn:aws:kms:us-east-1:807724355529:key/e4c733c5-9fbe-4a90-bda1-6f0362bc9b89"
}
######################################## IAM Role / Policy #########################################
variable "iam_role_name" {
  description = "The name of the IAM Role"
  type        = string
  default     = "iam-role"
}

variable "iam_policy_name" {
  description = "The name of the IAM Policy"
  type        = string
  default     = "iam-policy"
}
######################################## Lambda Function  ##########################################
variable "lambda_function_base_name" {
  description = "The base name of the lambda function"
  type        = string
  default     = "lambda-function-name"
}
######################################## DynamoDB Table ############################################
variable "dynamodb_table_base_name" {
  description = "The base name of the DynamoDB table"
  type        = string
  default     = "tarius-product-table"
}
######################################## SNS Topic #################################################
variable "sns_topic_base_name" {
  description = "The base name of the SNS Topic"
  type        = string
  default     = "tarius-sns-topic"
}
######################################## SQS Queue #################################################
variable "sqs_queue_base_name" {
  description = "The base name of the SQS Queue"
  type        = string
  default     = "sqs-queue"
}
######################################## S3 Bucket #################################################
variable "s3_bucket_base_name" {
  description = "The base name of the S3 Bucket"
  type        = string
  default     = "tarius-landing-zone"
}
variable "s3_default_folder"{
  description = "The default folder to be created"
  type = string
  default = "raw-zone"
}
######################################## Local Variables ###########################################
locals {
  tags = tomap({
    Environment = var.environment_name
    ProjectName = var.project_name
  })
}

locals {
  lambda_function_name = "${var.lambda_function_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}

locals {
  dynamodb_table_name = "${var.dynamodb_table_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}

locals {
  queue_name = "${var.sqs_queue_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}

locals {
  sns_topic_name = "${var.sns_topic_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}

locals {
  bucket_name = "${var.s3_bucket_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}