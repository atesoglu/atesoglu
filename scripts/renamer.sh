#!/usr/bin/env bash
# Tidies the filenames directly inside a directory. Not recursive; directories and dotfiles are
# left alone, and an existing file is never overwritten.
# Usage: scripts/renamer.sh [-n|--dry-run] [dir]
set -euo pipefail

usage() {
    echo "usage: scripts/renamer.sh [-n|--dry-run] [dir]"
}

dry_run=0
while [ $# -gt 0 ]; do
    case "$1" in
        -n | --dry-run) dry_run=1 ;;
        -h | --help)
            usage
            exit 0
            ;;
        --)
            shift
            break
            ;;
        -*)
            usage >&2
            printf '❌ %s\n' "Unknown option: $1" >&2
            exit 2
            ;;
        *) break ;;
    esac
    shift
done

[ $# -le 1 ] || {
    usage >&2
    exit 2
}

cd -- "${1:-.}" 2>/dev/null || {
    printf '❌ %s\n' "Not a directory: ${1:-.}" >&2
    exit 1
}

echo "📂 Processing files in: $(pwd -P)"

renamed=0
skipped=0

shopt -s nullglob
for file in *; do
    if [ ! -f "$file" ] || [ -L "$file" ]; then
        continue
    fi

    # --- CONFIGURATION AREA: ADD/REMOVE LOGIC HERE ---
    # Dots are escaped: an unescaped one matches any character.
    new_name=$(printf '%s' "$file" |
        sed -e 's/SANET\.ST[-_. ]//g' \
            -e 's/[Ss]anet\.st[-_. ]//g' \
            -e 's/[Ss]anet\.ST[-_. ]//g' \
            -e 's/_/ /g' \
            -e 's/  */ /g' \
            -e 's/^[[:space:]]*//' \
            -e 's/[[:space:]]*$//')
    # -------------------------------------------------

    [ "$new_name" != "$file" ] || continue

    # A rule that empties the name or introduces a slash would move or clobber the wrong thing.
    case "$new_name" in
        '' | '.' | '..' | */*)
            printf '⚠️  Skipped %s: rules produced an unusable name (%s)\n' "$file" "$new_name" >&2
            skipped=$((skipped + 1))
            continue
            ;;
    esac

    if [ -e "$new_name" ] || [ -L "$new_name" ]; then
        printf '⚠️  Skipped %s: %s already exists\n' "$file" "$new_name" >&2
        skipped=$((skipped + 1))
        continue
    fi

    if [ "$dry_run" -eq 1 ]; then
        printf 'would rename: %s -> %s\n' "$file" "$new_name"
    else
        mv -n -- "$file" "$new_name"
        printf 'renamed: %s -> %s\n' "$file" "$new_name"
    fi
    renamed=$((renamed + 1))
done
shopt -u nullglob

if [ "$dry_run" -eq 1 ]; then
    echo "🔍 Dry run: $renamed would be renamed, $skipped skipped."
else
    echo "✅ Renamed $renamed, skipped $skipped."
fi
