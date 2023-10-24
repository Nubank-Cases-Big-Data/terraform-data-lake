resource "aws_athena_workgroup" "core_banking_v1" {
  name = "core_banking_v1"

  configuration {
    enforce_workgroup_configuration = false

    result_configuration {
      output_location = "s3://${aws_s3_bucket.athena_results.bucket}/core_banking_v1/"
    }
  }
}

# OLTP simulation transformations

resource "aws_athena_named_query" "create_country" {
  name      = "core_banking_v1_country"
  database  = "dlake_nubankcases_staged"
  workgroup = aws_athena_workgroup.core_banking_v1.id
  query     = <<-EOT
    CREATE TABLE dlake_nubankcases_staged.core_banking_v1_country
    WITH (
      format = 'TEXTFILE',
      field_delimiter = ',',
      external_location = 's3://${aws_s3_bucket.dlake_nubankcases_staged.bucket}/seed-normalized/core_banking_v1_country'
    ) AS
    SELECT DISTINCT country_id, country as name
    FROM dlake_nubankcases_raw.country;
  EOT
}

resource "aws_athena_named_query" "create_state" {
  name      = "core_banking_v1_state"
  database  = "dlake_nubankcases_staged"
  workgroup = aws_athena_workgroup.core_banking_v1.id
  query     = <<-EOT
    CREATE TABLE dlake_nubankcases_staged.core_banking_v1_state
    WITH (
      format = 'TEXTFILE',
      field_delimiter = ',',
      external_location = 's3://${aws_s3_bucket.dlake_nubankcases_staged.bucket}/seed-normalized/core_banking_v1_state'
    ) AS
    SELECT DISTINCT state_id, state as name, country_id
    FROM dlake_nubankcases_raw.state;
  EOT
}

resource "aws_athena_named_query" "create_city" {
  name      = "core_banking_v1_city"
  database  = "dlake_nubankcases_staged"
  workgroup = aws_athena_workgroup.core_banking_v1.id
  query     = <<-EOT
    CREATE TABLE dlake_nubankcases_staged.core_banking_v1_city
    WITH (
      format = 'TEXTFILE',
      field_delimiter = ',',
      external_location = 's3://${aws_s3_bucket.dlake_nubankcases_staged.bucket}/seed-normalized/core_banking_v1_city'
    ) AS
    SELECT DISTINCT city_id, city as name, state_id
    FROM dlake_nubankcases_raw.city;
  EOT
}

resource "aws_athena_named_query" "create_people" {
  name      = "core_banking_v1_people"
  database  = "dlake_nubankcases_staged"
  workgroup = aws_athena_workgroup.core_banking_v1.id
  query     = <<-EOT
    CREATE TABLE dlake_nubankcases_staged.core_banking_v1_people
    WITH (
      format = 'TEXTFILE',
      field_delimiter = ',',
      external_location = 's3://${aws_s3_bucket.dlake_nubankcases_staged.bucket}/seed-normalized/core_banking_v1_people'
    ) AS
    SELECT customer_id as id, first_name, last_name, customer_city as city_id, cpf
    FROM dlake_nubankcases_raw.customers;
  EOT
}

resource "aws_athena_named_query" "create_accounts" {
  name      = "core_banking_v1_accounts"
  database  = "dlake_nubankcases_staged"
  workgroup = aws_athena_workgroup.core_banking_v1.id
  query     = <<-EOT
    CREATE TABLE dlake_nubankcases_staged.core_banking_v1_accounts
    WITH (
      format = 'TEXTFILE',
      field_delimiter = ',',
      external_location = 's3://${aws_s3_bucket.dlake_nubankcases_staged.bucket}/seed-normalized/core_banking_v1_accounts'
    ) AS
    SELECT
        account_id,
        customer_id as people_id,
        created_at,
        status,
        account_branch,
        account_check_digit,
        account_number
    FROM dlake_nubankcases_raw.accounts;
  EOT
}

resource "aws_athena_named_query" "create_transactions" {
  name      = "core_banking_v1_transactions"
  database  = "dlake_nubankcases_staged"
  workgroup = aws_athena_workgroup.core_banking_v1.id
  query     = <<-EOT
    CREATE TABLE dlake_nubankcases_staged.core_banking_v1_transactions
    WITH (
      format = 'TEXTFILE',
      field_delimiter = ',',
      external_location = 's3://${aws_s3_bucket.dlake_nubankcases_staged.bucket}/seed-normalized/core_banking_v1_transactions'
    ) AS
    SELECT
        id as transaction_id,
        account_id,
        'TRANSFER_IN' AS transaction_type,
        amount,
        transaction_requested_at,
        transaction_completed_at,
        status,
        'IN' AS in_or_out,
        ' ' AS additional_info
    FROM dlake_nubankcases_raw.transfer_ins

    UNION ALL

    SELECT
        id as transaction_id,
        account_id,
        'TRANSFER_OUT' AS transaction_type,
        amount,
        transaction_requested_at,
        transaction_completed_at,
        status,
        'OUT' AS in_or_out,
        ' ' AS additional_info
    FROM dlake_nubankcases_raw.transfer_outs

    UNION ALL

    SELECT
        id as transaction_id,
        account_id,
        'PIX_MOVEMENT' AS transaction_type,
        pix_amount as amount,
        pix_requested_at as transaction_requested_at,
        pix_completed_at as transaction_completed_at,
        status,
        CASE
            WHEN in_or_out = 'pix_in' THEN 'IN'
            WHEN in_or_out = 'pix_out' THEN 'OUT'
        END AS in_or_out,
        ' ' AS additional_info
    FROM dlake_nubankcases_raw.pix_movements;
  EOT
}
