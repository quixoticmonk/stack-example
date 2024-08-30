component "s3" {
  source = "./s3"
  inputs = {
    name = var.name
    tags = var.tags
  }
  providers = {
    awscc = provider.awscc.this
  }
}
