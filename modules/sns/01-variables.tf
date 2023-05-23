## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - SNS Module
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
  description = "KMS Key Id"
  type        = string
  default     = "SB-KMS"
}


######################################## SNS Topic #################################################
variable "sns_topic_base_name" {
  description = "The base name of the SNS Topic"
  type        = string
  default     = "sns-topic"
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


######################################## Local Variables ###########################################
locals {
  tags = tomap({
    Environment = var.environment_name
    ProjectName = var.project_name
  })
}

locals {
  topic_name = "${var.sns_topic_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}