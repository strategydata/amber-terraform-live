variable "amberdata_bucket" {
  description = "The name of the S3 bucket. Must be globally unique."
  type        = string
  default = "amberdata-bucket"
}

variable "amberdata_table" {
  description = "The name of the DynamoDB table. Must be unique in this AWS account."
  type        = string
  default = "amberdata-terraform-table"
}