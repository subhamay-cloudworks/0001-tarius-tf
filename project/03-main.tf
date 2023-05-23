## ---------------------------------------------------------------------------------------------------------------------
## Project Tarius - Main 
## Modification History:
##   - 1.0.0    May 22,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

module "tarius_sns" {
  source                 = "../modules/sns"
  sns_topic_base_name    = var.sns_topic_base_name
  sns_topic_display_name = var.sns_topic_display_name
  kms_key_alias          = var.kms_key_alias
  sns_subscription_email = var.sns_subscription_email
}

module "tarius_sqs" {
  source                    = "../modules/sqs"
  sqs_queue_base_name       = var.sqs_queue_base_name
  delay_seconds             = var.delay_seconds
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds
  kms_key_alias             = var.kms_key_alias
}

module "tarius_dynamodb" {
  source                   = "../modules/dynamodb"
  dynamodb_table_base_name = var.dynamodb_table_base_name
  partition_key            = var.partition_key
  partition_key_data_type  = var.partition_key_data_type
  kms_key_alias            = var.kms_key_alias
}

module "tarius_lambda_execution_role" {
  source                    = "../modules/iam-role"
  iam_role_name             = var.iam_role_name
  iam_policy_name           = var.iam_policy_name
  lambda_function_base_name = var.lambda_function_base_name
  dynamodb_table_base_name  = var.dynamodb_table_base_name
  sns_topic_base_name       = var.sns_topic_base_name
  sqs_queue_base_name       = var.sqs_queue_base_name
  s3_bucket_base_name       = var.s3_bucket_base_name
  s3_default_folder         = var.s3_default_folder
}

module "tarius_lambda_function" {
  source                         = "../modules/lambda"
  lambda_function_base_name      = var.lambda_function_base_name
  lambda_function_description    = var.lambda_function_description
  iam_role_name                  = var.iam_role_name
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  runtime                        = var.runtime
  sns_topic_arn                  = module.tarius_sns.sns_topic_arn
  dynamodb_table_base_name       = var.dynamodb_table_base_name
  dead_letter_queue_arn          = module.tarius_sqs.sqs_queue_arn
  reserved_concurrent_executions = var.reserved_concurrent_executions
}

module "tarius_s3_bucket" {
  source              = "../modules/s3"
  s3_bucket_base_name = var.s3_bucket_base_name
  kms_key_alias       = var.kms_key_alias
  s3_default_folder   = var.s3_default_folder
  lambda_function_arn = module.tarius_lambda_function.lambda_function_arn
}

# Lambda duration alarm
module "tarius_lambda_duration_alarm" {
  source                    = "../modules/cloudwatch-alarm"
  lambda_function_base_name = var.lambda_function_base_name
  # cloudwatch_alarm_type                = "duration"
  cloudwatch_alarm_namespace           = "AWS/Lambda"
  cloudwatch_alarm_statistics          = "Average"
  cloudwatch_metric_name               = "Duration"
  cloudwatch_alarm_period              = 900
  datapoints_to_alarm                  = 1
  cloudwatch_alarm_evaluation_period   = 1
  cloudwatch_alarm_comparison_operator = "GreaterThanOrEqualToThreshold"
  cloudwatch_alarm_threshold           = 500
  cloudwatch_alarm_description         = "Tarius - Alarm for Lambda function duration"
  sns_topic_arn                        = module.tarius_sns.sns_topic_arn
}

# Lambda errors alarm
module "tarius_lambda_errors_alarm" {
  source                    = "../modules/cloudwatch-alarm"
  lambda_function_base_name = var.lambda_function_base_name
  # cloudwatch_alarm_type                = "errors"
  cloudwatch_alarm_namespace           = "AWS/Lambda"
  cloudwatch_alarm_statistics          = "Sum"
  cloudwatch_metric_name               = "Errors"
  cloudwatch_alarm_period              = 900
  datapoints_to_alarm                  = 1
  cloudwatch_alarm_evaluation_period   = 1
  cloudwatch_alarm_comparison_operator = "GreaterThanOrEqualToThreshold"
  cloudwatch_alarm_threshold           = 2
  cloudwatch_alarm_description         = "Tarius - Alarm for number Lambda function errors"
  sns_topic_arn                        = module.tarius_sns.sns_topic_arn
}

# Lambda invocations alarm
module "tarius_lambda_invocations_alarm" {
  source                    = "../modules/cloudwatch-alarm"
  lambda_function_base_name = var.lambda_function_base_name
  # cloudwatch_alarm_type                = "throttles"
  cloudwatch_alarm_namespace           = "AWS/Lambda"
  cloudwatch_alarm_statistics          = "Sum"
  cloudwatch_metric_name               = "Invocations"
  cloudwatch_alarm_period              = 900
  datapoints_to_alarm                  = 1
  cloudwatch_alarm_evaluation_period   = 1
  cloudwatch_alarm_comparison_operator = "GreaterThanOrEqualToThreshold"
  cloudwatch_alarm_threshold           = 5
  cloudwatch_alarm_description         = "Tarius - Alarm for number Lambda function invocations"
  sns_topic_arn                        = module.tarius_sns.sns_topic_arn
}

# Lambda throttles alarm
module "tarius_lambda_throttles_alarm" {
  source                    = "../modules/cloudwatch-alarm"
  lambda_function_base_name = var.lambda_function_base_name
  # cloudwatch_alarm_type                = "throttles"
  cloudwatch_alarm_namespace           = "AWS/Lambda"
  cloudwatch_alarm_statistics          = "Sum"
  cloudwatch_metric_name               = "Throttles"
  cloudwatch_alarm_period              = 600
  datapoints_to_alarm                  = 1
  cloudwatch_alarm_evaluation_period   = 1
  cloudwatch_alarm_comparison_operator = "GreaterThanOrEqualToThreshold"
  cloudwatch_alarm_threshold           = 3
  cloudwatch_alarm_description         = "Tarius - Alarm for Lambda function throttles"
  sns_topic_arn                        = module.tarius_sns.sns_topic_arn
}

# Lambda concurrent execution alarm
module "tarius_lambda_executions_alarm" {
  source                    = "../modules/cloudwatch-alarm"
  lambda_function_base_name = var.lambda_function_base_name
  # cloudwatch_alarm_type                = "conc-exec"
  cloudwatch_alarm_namespace           = "AWS/Lambda"
  cloudwatch_alarm_statistics          = "Sum"
  cloudwatch_metric_name               = "ConcurrentExecutions"
  cloudwatch_alarm_period              = 60
  datapoints_to_alarm                  = 1
  cloudwatch_alarm_evaluation_period   = 1
  cloudwatch_alarm_comparison_operator = "GreaterThanOrEqualToThreshold"
  cloudwatch_alarm_threshold           = 3
  cloudwatch_alarm_description         = "Tarius - Alarm for Lambda concurrent executions"
  sns_topic_arn                        = module.tarius_sns.sns_topic_arn
}