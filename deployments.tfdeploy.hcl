deployment "dev" {
  inputs = {
    name = "manu-guard"
    tags = [{
      key   = "Modified By"
      value = "AWSCC"
    }]
    region    = "us-east-1"
    role_arn  = "arn:aws:iam::697621333100:role/stacks-ne-devops-prj-r2DPuyvZf1Fx6nzZ-stack-example"
    aws_token = identity_token.aws.jwt
  }
}


identity_token "aws" {
  audience = ["aws.workload.identity"]
}


orchestrate "auto_approve" "no_changes"{
    check{
        condition = context.plan.component_changes["component.s3"].total == 0
        reason = "Changes present in the plan"
    }
}