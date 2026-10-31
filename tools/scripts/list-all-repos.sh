#!/usr/bin/env bash
set -uo pipefail

# List SSH git clone commands for every accessible repository in an Azure DevOps
# organization. This script prints commands; it does NOT execute git clone.

usage() {
    cat <<'USAGE'
Usage:
  ./list-all-repos.sh ORGANIZATION

Example:
  ./list-all-repos.sh my-organization
  ./list-all-repos.sh my-organization > clone-commands.txt
USAGE
}

if [[ $# -ne 1 || -z "${1:-}" ]]; then
    usage >&2
    exit 2
fi

ORGANIZATION="$1"
ORGANIZATION_URL="https://dev.azure.com/${ORGANIZATION}"
SSH_PREFIX="git@ssh.dev.azure.com:v3/${ORGANIZATION}"

if ! command -v az >/dev/null 2>&1; then
    echo "ERROR: Azure CLI ('az') is not installed." >&2
    exit 1
fi

# Encode a single URL path segment (for project/repository names containing spaces
# or other reserved characters). Python 3 is used only for URL encoding.
if ! command -v python3 >/dev/null 2>&1; then
    echo "ERROR: Python 3 is required to URL-encode project and repository names." >&2
    exit 1
fi

encode_segment() {
    python3 -c 'import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1], safe=""))' "$1"
}

# Keep diagnostics on stderr so redirecting stdout produces only clone commands.
if ! projects="$(az devops project list \
    --organization "$ORGANIZATION_URL" \
    --query 'value[].name' \
    --output tsv)"; then
    echo "ERROR: Failed to retrieve projects. Run 'az login' and check your permissions." >&2
    exit 1
fi

while IFS= read -r project; do
    [[ -z "$project" ]] && continue

    if ! repositories="$(az repos list \
        --organization "$ORGANIZATION_URL" \
        --project "$project" \
        --query '[].name' \
        --output tsv)"; then
        echo "WARNING: Failed to list repositories for project: $project" >&2
        continue
    fi

    encoded_project="$(encode_segment "$project")"

    while IFS= read -r repository; do
        [[ -z "$repository" ]] && continue

        encoded_repository="$(encode_segment "$repository")"
        printf 'git clone %s/%s/%s\n' \
            "$SSH_PREFIX" "$encoded_project" "$encoded_repository"
    done <<< "$repositories"
done <<< "$projects"
