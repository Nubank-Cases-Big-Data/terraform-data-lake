# Terraform Data Lake Setup for Nubank Cases

This repository focuses on orchestrating the setup of a Data Lake for Nubank Cases using Terraform. It allows for smooth management, maintenance, and scalability of your data storage on AWS S3.

## Primary Objectives

1. **S3 Buckets Creation**: Define and create distinct buckets for raw, staged, and analytics data with necessary configurations.
2. **Data Lifecycle Management**: Apply lifecycle rules to the data stored in the buckets, transitioning them to different storage classes based on defined criteria.
3. **Encryption & Access Control**: Ensure data at rest is encrypted and that buckets have the correct access control policies.

## Setting Up Data Lake

Ensure a seamless setup of your Data Lake on AWS S3 with the following steps:

### Prerequisites

#### Installing AWS Vault (if using AWS resources)

Follow the instructions on the [AWS Vault GitHub page](https://github.com/99designs/aws-vault).

#### Installing TFEnv

To manage multiple Terraform versions, you can use TFEnv. Installation instructions are available on the [TFEnv GitHub page](https://github.com/tfutils/tfenv).

### Configuring AWS Vault

If integrating with AWS resources, configure AWS Vault by editing the AWS configuration file, typically located at `~/.aws/config`:

```plaintext
[profile <environment-name>]
sso_start_url = <your-sso-url>
sso_region = <your-region>
sso_account_id = <your-account-id>
sso_role_name = <your-role-name>
region = <your-region>
output = json
```

*Note: Replace the placeholders (< >) with appropriate values.*

Authenticate to your AWS account:

```bash
aws-vault login <environment-name>
```

### 1. Initializing Terraform

Navigate to the directory containing your Terraform files and initialize:

```bash
cd terraform
terraform init
```

### 2. Planning and Applying Changes

Review the proposed changes and apply them:

```bash
terraform plan -var-file=<environment-name>/variables.tfvars
terraform apply -var-file=<environment-name>/variables.tfvars -auto-approve
cd ..
```

### 3. Exploring Created Resources

After setup, you'll have three S3 buckets for:

- **Raw Data**: `dlake-nubankcases-raw`
- **Staged Data**: `dlake-nubankcases-staged`
- **Analytics Data**: `dlake-nubankcases-analytics`

These buckets have distinct lifecycles and access controls for optimal data management.

### 4. Iterating for Other Environments

If setting up configurations for a different environment:

1. Authenticate to your AWS account (if using AWS resources):

```bash
aws-vault login <other-environment-name>
```

2. Clean local temporary Terraform files:

```bash
rm -rf .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup
```

3. Repeat steps 1 and 2, substituting the environment name accordingly.

### 5. Setting Up GitHub Secrets

For CI/CD workflow integration, configure GitHub Secrets for required credentials:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

Retrieve these credentials from your AWS account or any other secrets management service you're using. Ensure these secrets are configured in your GitHub repository before pushing any updates.
