component "guard" {
  source = "./guard"
  inputs = {
    name = var.name
    tags = var.tags
  }
  providers = {
    awscc = provider.awscc.this
  }
}
