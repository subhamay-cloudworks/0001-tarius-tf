## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - Project Tarius
## Modification History:
##   - 1.0.0    May 22,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------


######################################## Project Name ##############################################
variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "tarius"
}
######################################## Environment Name ##########################################
variable "environment_name" {
  description = "The name of the environment"
  type        = string
  default     = "devl"
}
######################################## KMS Key ###################################################
variable "kms_key_alias" {
  description = "KMS Key Id"
  type        = string
  default     = "SB-KMS"
}

variable "kms_key_arn" {
  description = "KMS Key Arn"
  type        = string
  default     = "SB-KMS"
}
######################################## SNS Topic #################################################
variable "sns_topic_base_name" {
  description = "The base name of the SNS Topic"
  type        = string
  default     = "tarius-sns-topic"
}

variable "sns_topic_display_name" {
  description = "The display name of the SNS Topic"
  type        = string
  default     = "SNS Topic to send a notification once the data load is complete."
}
######################################## SNS Topic Subscription ####################################
variable "sns_subscription_email" {
  description = "The SNS subscription email"
  type        = string
  default     = "subhamay.aws@gmail.com"
}

######################################## SQS Queue #################################################
variable "sqs_queue_base_name" {
  description = "The base name of the SQS Queue"
  type        = string
  default     = "tarius-sqs-queue"
}

variable "delay_seconds" {
  description = "SQS queue delay seconds"
  type        = number
  default     = 0
}

variable "max_message_size" {
  description = "SQS queue maximum message size"
  type        = number
  default     = 0
}

variable "message_retention_seconds" {
  description = "SQS queue message retention period in seconds"
  type        = number
  default     = 0
}
variable "receive_wait_time_seconds" {
  description = "SQS queue receive wait time in seconds"
  type        = number
  default     = 0
}
######################################## DynamoDB Table ############################################
variable "dynamodb_table_base_name" {
  description = "The base name of the DynamoDB table"
  type        = string
  default     = "tarius-product-table"
}

variable "partition_key" {
  description = "The partition key or hash key of the dynamodb table."
  type        = string
  default     = "ID"
}

variable "partition_key_data_type" {
  description = "The partition key or hash key datat type of the dynamodb table."
  type        = string
  default     = "S"
}
######################################## S3 Bucket #################################################
variable "s3_bucket_base_name" {
  description = "The base name of the S3 bucket"
  type        = string
  default     = "tarius-landing-zone"
}

variable "s3_default_folder" {
  description = "The default folder to be created"
  type        = string
  default     = "raw-zone"
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

variable "lambda_function_description" {
  description = "The description of the lambda function"
  type        = string
  default     = "Lambda function description"
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
######################################## CloudWatch Alarm ##########################################
# variable "cloudwatch_alarm_type" {
#   description = "The CloudWatch Alarm metric type"
#   type        = string
#   default     = "duration"
# }

# variable "cloudwatch_alarm_statistics" {
#   description = "The CloudWatch Alarm statistics"
#   type        = string
#   default     = "Average"
# }

# variable "cloudwatch_metric_name" {
#   description = "The CloudWatch Alarm metric name"
#   type        = string
#   default     = "Duration"
# }

# variable "cloudwatch_alarm_period" {
#   description = "The CloudWatch Alarm period in seconds"
#   type        = number
#   default     = 900
# }

# variable "cloudwatch_alarm_evaluation_period" {
#   description = "The CloudWatch Alarm evaluation period"
#   type        = number
#   default     = 2
# }

# variable "cloudwatch_alarm_comparison_operator" {
#   description = "The CloudWatch Alarm comparison operator"
#   type        = string
#   default     = "GreaterThanOrEqualToThreshold"
# }

# variable "cloudwatch_alarm_threshold" {
#   description = "The CloudWatch Alarm threshold"
#   type        = number
#   default     = 10
# }

# variable "cloudwatch_alarm_description" {
#   description = "The CloudWatch Alarm description"
#   type        = string
#   default     = ""
# }

# variable "datapoints_to_alarm" {
#   description = "The CloudWatch Alarm datapoints to alarm"
#   type        = number
#   default     = 1
# }