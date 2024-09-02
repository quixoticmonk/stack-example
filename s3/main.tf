#############################
## Source bucket
#############################

resource "aws_s3_bucket" "source" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "source" {

  bucket = aws_s3_bucket.source.id
  versioning_configuration {
    status = "Enabled"
  }
}

variable "bucket_name" {
  type = string
}

variable "source_bucket" {
  type    = string
  default = ""
}

variable "create_replication" {
  type    = bool
  default = false
}

output "source_bucket" {
  value = aws_s3_bucket.source.arn
}

resource "aws_s3_bucket_acl" "source_bucket_acl" {

  bucket = aws_s3_bucket.source.id
  acl    = "private"
}


resource "aws_s3_bucket_replication_configuration" "replication" {
  count = var.create_replication ? 1 : 0
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.source]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.source.id

  rule {
    id = "foobar"

    filter {
      prefix = "foo"
    }

    status = "Enabled"

    destination {
      bucket        = "${var.bucket_name}-repl"
      storage_class = "STANDARD"
    }
  }
}

#############################
## Replication bucket
#############################

data "aws_s3_bucket" "source" {
  bucket = "source_bucket"
}

resource "aws_s3_bucket" "destination" {
  count  = var.create_replication ? 1 : 0
  bucket = "${var.bucket_name}-repl"
}

data "aws_iam_policy_document" "assume_role" {
  count = var.create_replication ? 1 : 0
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "replication" {
  count              = var.create_replication ? 1 : 0
  name               = "${var.bucket_name}-repl"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "replication" {
  count = var.create_replication ? 1 : 0
  statement {
    effect = "Allow"

    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
    ]

    resources = [data.aws_s3_bucket.source.arn]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
    ]

    resources = ["${data.aws_s3_bucket.source.arn}/*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
    ]

    resources = ["${aws_s3_bucket.destination.arn}/*"]
  }
}

resource "aws_iam_policy" "replication" {
  count  = var.create_replication ? 1 : 0
  name   = "${var.bucket_name}-repl"
  policy = data.aws_iam_policy_document.replication.json
}

resource "aws_iam_role_policy_attachment" "replication" {
  count      = var.create_replication ? 1 : 0
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}



resource "aws_s3_bucket_versioning" "destination" {
  count  = var.create_replication ? 1 : 0
  bucket = aws_s3_bucket.destination.id
  versioning_configuration {
    status = "Enabled"
  }
}



