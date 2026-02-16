#!/usr/bin/env bash
set -euo pipefail

# Usage: ./deploy.sh <resource-group> <parameters-file>
RG="${1:-rg-ae-revbc}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARAM_FILE_INPUT="${2:-parameters.json}"

if [[ -f "$PARAM_FILE_INPUT" ]]; then
  PARAM_FILE="$PARAM_FILE_INPUT"
elif [[ -f "$SCRIPT_DIR/$PARAM_FILE_INPUT" ]]; then
  PARAM_FILE="$SCRIPT_DIR/$PARAM_FILE_INPUT"
else
  echo "Param file $PARAM_FILE_INPUT not found"; exit 1
fi

TEMPLATE_FILE="$SCRIPT_DIR/main.bicep"

if [[ ! -f "$TEMPLATE_FILE" ]]; then
  echo "Template file $TEMPLATE_FILE not found"; exit 1
fi

az deployment group create \
  --resource-group "$RG" \
  --template-file "$TEMPLATE_FILE" \
  --parameters @"$PARAM_FILE"