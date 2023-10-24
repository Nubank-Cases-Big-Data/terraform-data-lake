# RAW Bucket
resource "aws_s3_bucket" "dlake_nubankcases_raw" {
  bucket = "dlake-nubankcases-raw"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dlake_nubankcases_raw_encryption" {
  bucket = aws_s3_bucket.dlake_nubankcases_raw.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "dlake_nubankcases_raw_lifecycle" {
  bucket = aws_s3_bucket.dlake_nubankcases_raw.bucket

  rule {
    id     = "transition_to_ia"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "dlake_nubankcases_raw_ownership" {
  bucket = aws_s3_bucket.dlake_nubankcases_raw.bucket

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "dlake_nubankcases_raw_acl" {
  bucket = aws_s3_bucket.dlake_nubankcases_raw.bucket
  acl    = "private"
}

# STAGED Bucket
resource "aws_s3_bucket" "dlake_nubankcases_staged" {
  bucket = "dlake-nubankcases-staged"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dlake_nubankcases_staged_encryption" {
  bucket = aws_s3_bucket.dlake_nubankcases_staged.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "dlake_nubankcases_staged_lifecycle" {
  bucket = aws_s3_bucket.dlake_nubankcases_staged.bucket

  rule {
    id     = "transition_to_ia"
    status = "Enabled"

    transition {
      days          = 60
      storage_class = "STANDARD_IA"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "dlake_nubankcases_staged_ownership" {
  bucket = aws_s3_bucket.dlake_nubankcases_staged.bucket

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "dlake_nubankcases_staged_acl" {
  bucket = aws_s3_bucket.dlake_nubankcases_staged.bucket
  acl    = "private"
}

# ANALYTICS Bucket
resource "aws_s3_bucket" "dlake_nubankcases_analytics" {
  bucket = "dlake-nubankcases-analytics"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dlake_nubankcases_analytics_encryption" {
  bucket = aws_s3_bucket.dlake_nubankcases_analytics.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "dlake_nubankcases_analytics_lifecycle" {
  bucket = aws_s3_bucket.dlake_nubankcases_analytics.bucket

  rule {
    id     = "transition_to_glacier"
    status = "Enabled"

    transition {
      days          = 365
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "dlake_nubankcases_analytics_ownership" {
  bucket = aws_s3_bucket.dlake_nubankcases_analytics.bucket

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "dlake_nubankcases_analytics_acl" {
  bucket = aws_s3_bucket.dlake_nubankcases_analytics.bucket
  acl    = "private"
}

# --

resource "aws_s3_bucket" "athena_results" {
  bucket = "dlake-nubankcases-athena-results"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dlake_nubankcases_athena_results_encryption" {
  bucket = aws_s3_bucket.athena_results.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "dlake_nubankcases_athena_results_ownership" {
  bucket = aws_s3_bucket.athena_results.bucket

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "dlake_nubankcases_athena_results_acl" {
  bucket = aws_s3_bucket.athena_results.bucket
  acl    = "private"
}
