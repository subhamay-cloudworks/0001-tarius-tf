## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - Lambda Module
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
######################################## DynamoDB Table ############################################
variable "dynamodb_table_base_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "dynamodb-table-name"
}
######################################## SNS Topic #################################################
variable "sns_topic_arn" {
  description = "The arn of the SNS Topic"
  type        = string
  default     = "arn:aws:sns:us-east-1:111111111111:sns-topic-name"
}
######################################## Dead Letter Queue Arn #####################################
variable "dead_letter_queue_arn" {
  description = "The arn of the Dead Letter Queue"
  type        = string
  default     = "arn:aws:sqs:us-east-1:111111111111:sqs-queue-name"
}
######################################## Lambda Function  ##########################################
variable "lambda_function_base_name" {
  description = "The base name of the lambda function"
  type        = string
  default     = "lambda-function-name"
}

variable "lambda_function_description" {
  description = "The description of the lambda function"
  type        = string
  default     = "Lambda function description"
}

variable "iam_role_name" {
  description = "The Arn of the lambda function execution role"
  type        = string
  default     = "lambda-execution-role"
}

variable "memory_size" {
  description = "The allocated memory size of the lambda function in MB"
  type        = number
  default     = 128
}

variable "runtime" {
  description = "The runtime the lambda function"
  type        = string
  default     = "python3.9"
}

variable "timeout" {
  description = "The timeout period of the lambda function in seconds"
  type        = number
  default     = 3
}

variable "reserved_concurrent_executions" {
  description = "The reserved concurrency for the lambda function."
  type        = number
  default     = 1
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
  lambda_execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.iam_role_name}"
}

locals {
  dynamodb_table_name = "${var.dynamodb_table_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}