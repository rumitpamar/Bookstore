#!/bin/bash

# Fetch the PostgreSQL RDS endpoint from Terraform output
RDS_ENDPOINT=$(terraform output rds_endpoint)

# Fetch the PostgreSQL RDS password from Secrets Manager
DB_SECRET_NAME="your_db_secret_name"
RDS_PASSWORD=$(aws secretsmanager get-secret-value --secret-id $DB_SECRET_NAME --query SecretString --output text)

# Command to connect to the PostgreSQL RDS instance using psql with the retrieved endpoint and password
psql -h $RDS_ENDPOINT -d postgres -U admin123 -W $RDS_PASSWORD -c "SELECT 'Connected to DB';"

# Exit the script after connecting
exit 0
