

component "s3" {
    source = "./s3"
    inputs={
        bucket_name = var.bucket_name

    }
    providers={
        aws= provider.aws.this
    }
}

#component "events" {
#    source = "./events"
#    inputs={
#        rule_name = var.rule_name   
#        topic_name = var.topic_name
#
#    }
#    providers={
#        aws= provider.aws.this
#    }
#}