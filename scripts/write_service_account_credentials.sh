#!/usr/bin/env bash

terraform init

# write the non-prod service account credentials to secret store
terraform output DPSNonprodServiceAccount_encrypted_aws_secret_access_key | sed 's/"//g' | base64 -d | gpg -dq --passphrase ${GPG_KEY_PASSPHRASE} |  opw write cohort-base-aws-1 DPSNonprodServiceAccount-aws-secret-access-key -
terraform output DPSNonprodServiceAccount_aws_access_key_id | tr -d \\n | sed 's/"//g' | opw write cohort-base-aws-1 DPSNonprodServiceAccount-aws-access-key-id -

# write the prod service account credentials to secret store
#terraform output DPSProdServiceAccount_encrypted_aws_secret_access_key | sed 's/"//g' | base64 -d | gpg -dq --passphrase ${GPG_KEY_PASSPHRASE} |  opw write cohort-base-aws-1 DPSProdServiceAccount-aws-secret-access-key -
#terraform output DPSProdServiceAccount_aws_access_key_id | tr -d \\n | sed 's/"//g' | opw write cohort-base-aws-1 DPSProdServiceAccount-aws-access-key-id -
