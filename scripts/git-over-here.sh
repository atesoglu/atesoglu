#!/usr/bin/env bash

# gitoverhere.sh
# Pull all Git repositories in the current directory.
#
# Only fast-forward pulls are allowed.
# Repositories with local changes are skipped.

set -u

echo
echo "🔥 GET OVER HERE! 🔥"
echo

pulled=0
skipped=0
failed=0

for dir in */; do
    [[ -d "${dir}.git" ]] || continue

    repo="${dir%/}"

    echo "===== ${repo} ====="

    if [[ -n "$(git -C "$dir" status --porcelain)" ]]; then
        echo "⚠️  Skipped: local changes detected"
        ((skipped++))
        echo
        continue
    fi

    if git -C "$dir" pull --ff-only; then
        ((pulled++))
    else
        echo "❌ Pull failed"
        ((failed++))
    fi

    echo
done

echo "================================"
echo "🔥 GET OVER HERE! COMPLETE"
echo "================================"
echo
echo "  ✅ Pulled : $pulled"
echo "  ⚠️  Skipped: $skipped"
echo "  ❌ Failed  : $failed"
echo
