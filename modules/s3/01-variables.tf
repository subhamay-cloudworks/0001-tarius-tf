## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - S3 Module
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

######################################## Lambda Function ###########################################
variable "lambda_function_arn"{
  description = "The arn of the lambda function used for bucket notification"
  type = string
  default = "arn:aws:lambda:us-east-1:111111111111:function:lambda-function-name"
}

######################################## Local Variables ###########################################
locals {
  tags = tomap({
    Environment = var.environment_name
    ProjectName = var.project_name
  })
}

locals {
  bucket_name = "${var.s3_bucket_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}