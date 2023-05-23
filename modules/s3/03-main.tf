## ---------------------------------------------------------------------------------------------------------------------
## S3 - Main 
## Modification History:
##   - 1.0.0    May 22,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

########################################  S3 Bucket ################################################
resource "aws_s3_bucket" "s3_bucket" {
  bucket        = local.bucket_name
  force_destroy = true

  tags = local.tags
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_owner_control" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_owner_control]

  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
}
######################################## SSE Encryption ############################################
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_sse" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_alias
      sse_algorithm     = "aws:kms"
    }
  }
}
######################################## SSE Encryption ############################################
resource "aws_s3_object" "s3_bucket_folder" {
    bucket = "${aws_s3_bucket.s3_bucket.id}"
    acl    = "private"
    key    = "${var.s3_default_folder}/"
    source = "/dev/null"
    kms_key_id = var.kms_key_arn
}
######################################## S3 Event Notification #####################################
resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.s3_bucket.arn
}

resource "aws_s3_bucket_notification" "s3_bucket_notification" {
  bucket = aws_s3_bucket.s3_bucket.id

  lambda_function {
    lambda_function_arn = var.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = var.s3_default_folder
    filter_suffix       = ".csv"
  }

  depends_on = [aws_lambda_permission.lambda_permission]
}