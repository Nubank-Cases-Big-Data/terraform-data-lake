resource "aws_lakeformation_data_lake_settings" "lake_settings" {
  admins = [data.aws_iam_session_context.current.issuer_arn]
}

resource "aws_lakeformation_resource" "dlake_nubankcases_raw_resource" {
  arn      = aws_s3_bucket.dlake_nubankcases_raw.arn
  role_arn = aws_iam_role.dlake_nubankcases_raw_role.arn
}

resource "aws_lakeformation_resource" "dlake_nubankcases_staged_resource" {
  arn      = aws_s3_bucket.dlake_nubankcases_staged.arn
  role_arn = aws_iam_role.dlake_nubankcases_staged_role.arn
}

resource "aws_lakeformation_resource" "dlake_nubankcases_analytics_resource" {
  arn      = aws_s3_bucket.dlake_nubankcases_analytics.arn
  role_arn = aws_iam_role.dlake_nubankcases_analytics_role.arn
}

resource "aws_lakeformation_permissions" "dlake_raw_glue_lake_perm" {
  principal = aws_iam_role.dlake_nubankcases_raw_crawler_role.arn

  permissions = ["DATA_LOCATION_ACCESS"]

  data_location {
    arn = aws_s3_bucket.dlake_nubankcases_raw.arn
  }
}

resource "aws_lakeformation_permissions" "dlake_raw_glue_crawler_database_permissions" {
  principal = aws_iam_role.dlake_nubankcases_raw_crawler_role.arn

  permissions = ["ALTER", "DROP", "CREATE_TABLE", "DESCRIBE"]

  database {
    name = aws_glue_catalog_database.dlake_nubankcases_raw.name
  }
}

resource "aws_lakeformation_permissions" "dlake_staged_glue_lake_perm" {
  principal = aws_iam_role.dlake_nubankcases_staged_crawler_role.arn

  permissions = ["DATA_LOCATION_ACCESS"]

  data_location {
    arn = aws_s3_bucket.dlake_nubankcases_staged.arn
  }
}

resource "aws_lakeformation_permissions" "dlake_analytics_glue_lake_perm" {
  principal = aws_iam_role.dlake_nubankcases_analytics_crawler_role.arn

  permissions = ["DATA_LOCATION_ACCESS"]

  data_location {
    arn = aws_s3_bucket.dlake_nubankcases_analytics.arn
  }
}

# resource "aws_lakeformation_permissions" "dalake_raw_core_banking_lake_perm" {
#   depends_on = [aws_lakeformation_resource.dlake_nubankcases_raw_resource]

#   principal = aws_iam_role.cross_account_role.arn

#   permissions = ["DATA_LOCATION_ACCESS"]

#   data_location {
#     arn = aws_s3_bucket.dlake_nubankcases_raw.arn
#   }
# }

# resource "aws_lakeformation_permissions" "dalake_staged_core_banking_lake_perm" {
#   depends_on = [aws_lakeformation_resource.dlake_nubankcases_staged_resource]

#   principal = aws_iam_role.cross_account_role.arn

#   permissions = ["DATA_LOCATION_ACCESS"]

#   data_location {
#     arn = aws_s3_bucket.dlake_nubankcases_staged.arn
#   }
# }

# resource "aws_lakeformation_permissions" "dalake_analytics_core_banking_lake_perm" {
#   depends_on = [aws_lakeformation_resource.dlake_nubankcases_analytics_resource]

#   principal = aws_iam_role.cross_account_role.arn

#   permissions = ["DATA_LOCATION_ACCESS"]

#   data_location {
#     arn = aws_s3_bucket.dlake_nubankcases_analytics.arn
#   }
# }

# resource "aws_lakeformation_permissions" "dlake_raw_glue_crawler_database_permissions" {
#   principal = aws_iam_role.glue_crawler_role.arn

#   permissions = ["ALTER", "DROP", "CREATE_TABLE", "DESCRIBE"]

#   database {
#     name = aws_glue_catalog_database.dlake_nubankcases_raw.name
#   }
# }
# resource "aws_lakeformation_permissions" "dlake_raw_glue_crawler_table_permissions" {
#   principal = aws_iam_role.glue_crawler_role.arn

#   permissions = ["ALL"]

#   table {
#     database_name = aws_glue_catalog_database.dlake_nubankcases_raw.name
#     wildcard = true
#   }
# }


resource "aws_lakeformation_permissions" "x" {
  principal = "arn:aws:iam::566351880823:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_AdministratorAccess_87aa0e8c0da1ece9"

  permissions = ["ALL"]

  table {
    database_name = aws_glue_catalog_database.dlake_nubankcases_raw.name
    wildcard      = true
  }
}
