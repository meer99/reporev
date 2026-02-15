#!/usr/bin/env bash
set -euo pipefail

# Usage: ./deploy.sh <resource-group> <parameters-file>
RG="${1:-rg-ae-revbc}"
PARAM_FILE="${2:-parameters.json}"

if [[ ! -f "$PARAM_FILE" ]]; then
  echo "Param file $PARAM_FILE not found"; exit 1
fi

az deployment group create \
  --resource-group "$RG" \
  --template-file main.bicep \
  --parameters @"$PARAM_FILE"