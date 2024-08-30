
required_providers {
  awscc = {
    source = "hashicorp/awscc"
    version ="1.12.0"
  }

}

provider "awscc" "this" {
  config {
    region = var.region

    assume_role_with_web_identity= {
      role_arn           = var.role_arn
      web_identity_token = var.aws_token
    }
  }
}
