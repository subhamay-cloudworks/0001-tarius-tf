# Project Tarius: AWS Serverlsss Real Time Data Load to DynamoDB

The user / producer uploads a csv source file to the landing zone S3 bucket. A Lambda function is triggered using S3 event notification and loads it to a DynamoDB table. The entire stack is created using HashiCorp Terraform. The SNS, S3 Bucket and DynamoDB tables are encrypted using Customer Managed KMS Key. The Lambda function is monitored using CloudWatch Alarms.

## Description

This sample project demonstrate the capability of loading a .csv file into a DynamoDB table using a Lambda function. The Lambda function is triggered using an Event Source Notification created on the S3 bucket. Once the data loads successfully into the DynamoDB table, a SNS notification is published and end users are notified via email subscriibed to the SNS Topic. CloudWatch Alarms are created to demonstrate the different metrics on the Lambda function. The S3 Bucket, SNS Topic and the DynamoDB tables are encrypted using Customer Managed KMS Key. The entire stack (excluding the KMS Key) is created using HashiCorp Terraform.

![Project Tauris - Design Diagram](https://subhamay-projects-repository-us-east-1.s3.amazonaws.com/0001-tarius/tarius-architecture-diagram.png)

![Project Tauris - Services Used](https://subhamay-projects-repository-us-east-1.s3.amazonaws.com/0001-tarius/tarius-services-used-tf.png)

## Getting Started

### Dependencies

* Create a Customer Managed KMS Key in the region where you want to create the stack.
* Modify the KMS Key Policy to let the IAM user encrypt / decrypt using any resource using the created KMS Key.
* Setup AWS CLI with an user having appropriate access to create the required resources.

### Installing

* Clone the repository https://github.com/subhamay-cloudworks/0001-tarius-tf
### Executing program

* From the main project diretory submit the following commands:
```
terraform init

terraform validate 

terraform plan

terraform apply -auto-approve

# To tear down the stack 
terraform destroy -auto-approve
```

## Help

Post message in my blog (https://blog.subhamay.com)


## Authors

Contributors names and contact info

Subhamay Bhattacharyya  - [subhamay.aws@gmail.com](https://blog.subhamay.com)

## Version History

* 0.1
    * Initial Release

## License

This project is licensed under Subhamay Bhattacharyya. All Rights Reserved.

## Acknowledgments

Inspiration, code snippets, etc.
* [Denis Astahov ] (https://www.astahov.net/)
* [Derek Morgan ] (https://www.linkedin.com/in/derekm1215/)
* [Kalyan Reddy Daida ] (https://www.linkedin.com/in/kalyan-reddy-daida/)

