# aws-lambda-pdf-splitter
Splits PDFs when PDF is received in input bucket and uploads them to a destination bucket

# PDF Splitter

How it works:

1. PDF is uploaded to S3 bucket
2. S3 Event notification is triggered
3. Lambda function is triggered by this notification
4. Lambda function splits the file and writes metadata
5. Data is sent to destination bucket

# Usage
Read the [Makefile](Makefile) to understand the deployment process. Also change the value of the CODE_BUCKET_NAME to the bucket that is created for hosting your code. This is the output of `code_bucket_name` in [outputs.tf](infra/outputs.tf)

```bash
# Setup environment
make setup

# Create and move package to infra
make build

# Initialize Terraform
make init

# Plan and apply
make plan
make apply

# Deploy latest code
make deploy

# Tear everything down
make cleanup
make destroy
```

# Terraform
Add credentials for terraform provider to be used. You can follow the [docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs).

## Setup env
Add credentials for terraform provider to be used. You can follow the [docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs).

# Lambda function

## Setup env

```zsh
cd code
uv venv
source .venv/bin/activate
uv pip install -r requirements-dev.txt
```

## Package lambda function

```zsh
make package
```

## Deploy
```zsh
make deploy
```

# Deployment

Deploy complete configuration
```zsh
terraform init
terraform apply -auto-approve
```

## Functionality
The function splits the PDF page by page.