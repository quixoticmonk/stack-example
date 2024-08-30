deployment "dev"{
    inputs ={
        topic_name="topic1"
        rule_name="rule1"
        bucket_name="manu-s3-bucket-2024"
        region              = "us-east-1"
        role_arn            = "arn:aws:iam::697621333100:role/stacks-ne-devops-prj-r2DPuyvZf1Fx6nzZ-stack-example"
        identity_token_file = identity_token.aws.jwt_filename
}

}


orchestrate "auto_approve" "no_changes"{
    check{
        condition = context.plan.component_changes["component.events"].total == 0
        reason = "Changes present in the plan"
    }
}


identity_token "aws" {

    audience =["aws.workload.identity"]
}

