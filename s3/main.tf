resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket"
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}