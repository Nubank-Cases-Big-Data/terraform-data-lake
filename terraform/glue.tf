resource "aws_glue_catalog_database" "dlake_nubankcases_raw" {
  name        = "dlake_nubankcases_raw"
  description = "Database for dlake nubank cases raw data"
}

resource "aws_glue_catalog_database" "dlake_nubankcases_staged" {
  name        = "dlake_nubankcases_staged"
  description = "Database for dlake nubank cases staged data"
}

resource "aws_glue_catalog_database" "dlake_nubankcases_analytics" {
  name        = "dlake_nubankcases_analytics"
  description = "Database for dlake nubank cases analytics data"
}

resource "aws_glue_crawler" "dlake_nubankcases_raw_seed_core_banking_v1_crawler" {
  name          = "dlake-nubankcases-raw-seed-core-banking-v1-crawler"
  database_name = "dlake_nubankcases_raw"

  role = aws_iam_role.dlake_nubankcases_raw_crawler_role.arn

  s3_target {
    path = "s3://dlake-nubankcases-raw/seed/core_banking_v1/"
  }
}
