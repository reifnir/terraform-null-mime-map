#!/bin/bash
# =============================================================================
# Executing this script will replace the contents of the locals_mappings.tf
# file with the current mappings from https://github.com/jshttp. (Many thanks
# for using the MIT license, too!)
# =============================================================================

set -e
REPO_ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null 2>&1 && pwd )"
MAPPINGS_FILE_PATH="$REPO_ROOT_DIR/locals_mappings.tf"

echo "Getting list of mime-type mappings from jshttp's mime-db..."
DB="`curl -Js -H 'Accept: application/json' "https://raw.githubusercontent.com/jshttp/mime-db/master/db.json"`"

# Small set for local testing...
# DB='{
#   "application/json": {
#     "source": "iana",
#     "charset": "UTF-8",
#     "compressible": true,
#     "extensions": ["json","map"]
#   },
#   "text/css": {
#     "source": "iana",
#     "charset": "UTF-8",
#     "compressible": true,
#     "extensions": ["css"]
#   },
#   "application/vnd.artisan+json": {
#     "source": "iana",
#     "compressible": true
#   }
# }'

echo "Transforming into key-value pair of filename extensions to mime types..."
MAPPINGS="$(echo "$DB" | jq 'to_entries | [ .[] | select(.value.extensions != null) | "\"\(.value.extensions[])\"=\"\(.key)\"" ] | sort | .[]' -r)"

echo "Replacing the contents of locals_mappings.tf..."
        cat << EOF > "$MAPPINGS_FILE_PATH"
# DON'T MAKE CHANGES DIRECTLY TO THIS FILE!
# Intead, execute this script to regenerate the file: ./scripts/rebuild-local-map-file.sh
locals {
  content_type_mappings = {
$MAPPINGS
  }
}
EOF

echo "Validating Terraform..."
terraform -chdir="$REPO_ROOT_DIR" validate

echo "Formatting Terraform..."
terraform -chdir="$REPO_ROOT_DIR" fmt
