resource "aws_iam_role" "dlake_nubankcases_raw_role" {
  name = "DlakeNubankcasesRawRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lakeformation.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "dlake_nubankcases_raw_policy" {
  name = "DlakeNubankcasesRawPolicy"
  role = aws_iam_role.dlake_nubankcases_raw_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "lakeformation:GetDataAccess"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = "s3:GetObject",
        Resource = "${aws_s3_bucket.dlake_nubankcases_raw.arn}/*"
      },
      {
        Sid    = "LakeFormationDataAccessPermissionsForS3",
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        Resource = [
          "${aws_s3_bucket.dlake_nubankcases_raw.arn}/*"
        ]
      },
      {
        Sid    = "LakeFormationDataAccessPermissionsForS3ListBucket",
        Effect = "Allow",
        Action = [
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.dlake_nubankcases_raw.arn
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "s3:ListAllMyBuckets"
        ],
        Resource = [
          "arn:aws:s3:::*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "dlake_nubankcases_staged_role" {
  name = "DlakeNubankcasesStagedRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lakeformation.amazonaws.com"
        }
      },
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${var.core_banking_aws_account}:role/${var.core_banking_csv_to_postgres_lambda_execution_role}"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "dlake_nubankcases_staged_policy" {
  name = "DlakeNubankcasesStagedPolicy"
  role = aws_iam_role.dlake_nubankcases_staged_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "lakeformation:GetDataAccess"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = "s3:GetObject",
        Resource = "${aws_s3_bucket.dlake_nubankcases_staged.arn}/*"
      },
      {
        Sid    = "LakeFormationDataAccessPermissionsForS3",
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        Resource = [
          "${aws_s3_bucket.dlake_nubankcases_staged.arn}/*"
        ]
      },
      {
        Sid    = "LakeFormationDataAccessPermissionsForS3ListBucket",
        Effect = "Allow",
        Action = [
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.dlake_nubankcases_staged.arn
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "s3:ListAllMyBuckets"
        ],
        Resource = [
          "arn:aws:s3:::*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "dlake_nubankcases_analytics_role" {
  name = "DlakeNubankcasesAnalyticsRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lakeformation.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "dlake_nubankcases_analytics_policy" {
  name = "DlakeNubankcasesAnalyticsPolicy"
  role = aws_iam_role.dlake_nubankcases_analytics_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "lakeformation:GetDataAccess"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = "s3:GetObject",
        Resource = "${aws_s3_bucket.dlake_nubankcases_analytics.arn}/*"
      },
      {
        Sid    = "LakeFormationDataAccessPermissionsForS3",
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        Resource = [
          "${aws_s3_bucket.dlake_nubankcases_analytics.arn}/*"
        ]
      },
      {
        Sid    = "LakeFormationDataAccessPermissionsForS3ListBucket",
        Effect = "Allow",
        Action = [
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.dlake_nubankcases_analytics.arn
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "s3:ListAllMyBuckets"
        ],
        Resource = [
          "arn:aws:s3:::*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "dlake_nubankcases_raw_crawler_role" {
  name = "DlakeNubankcasesRawCrawlerRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "dlake_nubankcases_raw_crawler_policy" {
  name        = "DlakeNubankcasesRawCrawlerPolicy"
  description = "Policies for Dlake Nubankcases Raw Crawler"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "lakeformation:GetDataAccess"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.dlake_nubankcases_raw.arn,
          "${aws_s3_bucket.dlake_nubankcases_raw.arn}/*"
        ]
      },
      {
        Action = [
          "glue:CreateTable",
          "glue:UpdateTable",
          "glue:DeleteTable",
          "glue:GetTable",
          "glue:GetTables",
          "glue:GetDatabase",
          "glue:GetDatabases"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws-glue/crawlers:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dlake_nubankcases_raw_crawler_policy_attachment" {
  policy_arn = aws_iam_policy.dlake_nubankcases_raw_crawler_policy.arn
  role       = aws_iam_role.dlake_nubankcases_raw_crawler_role.name
}

resource "aws_iam_role" "dlake_nubankcases_staged_crawler_role" {
  name = "DlakeNubankcasesStagedCrawlerRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "dlake_nubankcases_staged_crawler_policy" {
  name        = "DlakeNubankcasesStagedCrawlerPolicy"
  description = "Policies for Dlake Nubankcases Staged Crawler"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "lakeformation:GetDataAccess"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.dlake_nubankcases_staged.arn,
          "${aws_s3_bucket.dlake_nubankcases_staged.arn}/*"
        ]
      },
      {
        Action = [
          "glue:CreateTable",
          "glue:UpdateTable",
          "glue:DeleteTable",
          "glue:GetTable",
          "glue:GetTables",
          "glue:GetDatabase",
          "glue:GetDatabases"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws-glue/crawlers:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dlake_nubankcases_staged_crawler_policy_attachment" {
  policy_arn = aws_iam_policy.dlake_nubankcases_staged_crawler_policy.arn
  role       = aws_iam_role.dlake_nubankcases_staged_crawler_role.name
}


resource "aws_iam_role" "dlake_nubankcases_analytics_crawler_role" {
  name = "DlakeNubankcasesAnalyticsCrawlerRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "dlake_nubankcases_analytics_crawler_policy" {
  name        = "DlakeNubankcasesAnalyticsCrawlerPolicy"
  description = "Policies for Dlake Nubankcases Analytics Crawler"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "lakeformation:GetDataAccess"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.dlake_nubankcases_analytics.arn,
          "${aws_s3_bucket.dlake_nubankcases_analytics.arn}/*"
        ]
      },
      {
        Action = [
          "glue:CreateTable",
          "glue:UpdateTable",
          "glue:DeleteTable",
          "glue:GetTable",
          "glue:GetTables",
          "glue:GetDatabase",
          "glue:GetDatabases"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws-glue/crawlers:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dlake_nubankcases_analytics_crawler_policy_attachment" {
  policy_arn = aws_iam_policy.dlake_nubankcases_analytics_crawler_policy.arn
  role       = aws_iam_role.dlake_nubankcases_analytics_crawler_role.name
}
