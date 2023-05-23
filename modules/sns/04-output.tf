## ---------------------------------------------------------------------------------------------------------------------
## Output - SNS Module
## Modification History:
##   - 1.0.0    May 22,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

######################################## AWS REGION ################################################
output "current_region" {
  value = data.aws_region.current.name
}

output "current_region_description" {
  value = data.aws_region.current.description
}
######################################## SNS TOPIC #################################################
output "sns_topic_arn" {
  value = aws_sns_topic.sns_topic.arn
}

output "sns_topic_display_name" {
  value = aws_sns_topic.sns_topic.display_name
}

output "sns_topic_id" {
  value = aws_sns_topic.sns_topic.id
}

output "sns_topic_tags_all" {
  value = aws_sns_topic.sns_topic.tags_all
}

output "sns_topic_owner" {
  value = aws_sns_topic.sns_topic.owner
}
######################################## SNS SUBSCRIPTION ###########################################
output "sns_topic_subscription_arn" {
  value = aws_sns_topic_subscription.sns_topic_target.arn
}
