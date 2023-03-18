#!/usr/bin/env bash
#
# Bash Profile
#
#
cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

# Load stashed environment files located at the home directory
if [[ -a ~/.localrc ]]
then
    source ~/.localrc
fi

function aws-bootstrap() {
    local config_file="${HOME}/.aws/config"

    if [[ -z "${AWS_SSO_URL}" ]]; then echo "The required environment variable 'AWS_SSO_URL' is missing for the 'sso_start_url'" && exit 1; fi
    if [[ -z "${AWS_SSO_REGION}" ]]; then echo "The required environment variable 'AWS_SSO_REGION' is missing for the 'sso_region'" && exit 1; fi
    if [[ -z "${AWS_SSO_ACCOUNT_ID}" ]]; then echo "The required environment variable 'AWS_SSO_ACCOUNT_ID' is missing for the 'sso_account_id'" && exit 1; fi
    if [[ -z "${AWS_SSO_ROLE_NAME}" ]]; then echo "The required environment variable 'AWS_SSO_ROLE_NAME' is missing for the 'sso_role_name'" && exit 1; fi
    if [[ -z "${AWS_REGION}" ]]; then echo "The required environment variable 'AWS_REGION' is missing for the 'region'" && exit 1; fi

    if [ -f "$config_file" ];
    then
        echo Copying "$config_file" to backup file as "$config_file".bak
        mv "$config_file" "${config_file}.bak"
    fi

    mkdir -p ~/.aws/
    touch "$config_file"
    echo "[default]" >> "$config_file"
    echo "sso_start_url = $AWS_SSO_URL" >> "$config_file"
    echo "sso_region = $AWS_SSO_REGION" >> "$config_file"
    echo "sso_account_id = $AWS_SSO_ACCOUNT_ID" >> "$config_file"
    echo "sso_role_name = $AWS_SSO_ROLE_NAME" >> "$config_file"
    echo "region = $AWS_REGION" >> "$config_file"
    echo "output = json" >> "$config_file"

    aws sso login --no-browser
}
