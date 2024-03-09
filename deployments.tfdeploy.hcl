deployment "dev"{
    variables ={
        topic_name="topic1"
        rule_name="rule1"
        bucket_name="manu-s3-bucket-2024"
        region              = "us-east-1"
        role_arn            = "arn:aws:iam::697621333100:role/stack_role"
        identity_token_file = identity_token.aws.jwt_filename
}


}

deployment "prod"{
    variables ={
        topic_name="topic1"
        rule_name="rule1"
        bucket_name="manu-s3-bucket-2024"
        region              = "us-east-1"
        role_arn            = "arn:aws:iam::697621333100:role/stack_role"
        identity_token_file = identity_token.aws.jwt_filename
}


}



identity_token "aws" {

    audience =["aws.workload.identity"]
}

