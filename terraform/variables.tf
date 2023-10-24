variable "environment" {
  description = "Specify the deployment environment. This variable allows you to choose the environment where you want to deploy the infrastructure, which can be useful for managing multiple environments such as development, testing, and production"
  type        = string
  default     = "dta"
}

variable "core_banking_aws_account" {
  description = "Specify the AWS account ID where the core banking infrastructure is deployed"
}

variable "core_banking_csv_to_postgres_lambda_execution_role" {
  description = "Specify the name of the IAM role that will be used by the lambda function"
}
