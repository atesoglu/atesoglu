#!/usr/bin/env bash
# Deletes .NET build output below a directory: the bin/ and obj/ directories that sit next to a
# project file. Anything else called bin/ or obj/ -- ~/bin, node_modules/.bin -- is left alone.
# Usage: scripts/clean-dotnet.sh [-n|--dry-run] [-y|--yes] [dir]
set -euo pipefail

usage() {
    echo "usage: scripts/clean-dotnet.sh [-n|--dry-run] [-y|--yes] [dir]"
}

die() {
    printf '❌ %s\n' "$1" >&2
    exit 1
}

dry_run=0
assume_yes=0
while [ $# -gt 0 ]; do
    case "$1" in
        -n | --dry-run) dry_run=1 ;;
        -y | --yes) assume_yes=1 ;;
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
            die "Unknown option: $1"
            ;;
        *) break ;;
    esac
    shift
done

[ $# -le 1 ] || {
    usage >&2
    exit 2
}

target="$(cd -- "${1:-.}" 2>/dev/null && pwd -P)" || die "Not a directory: ${1:-.}"

# A stray run in one of these is catastrophic and never what was meant.
case "$target" in
    / | "${HOME:-/nonexistent}") die "Refusing to clean $target." ;;
esac

targets=()
while IFS= read -r -d '' dir; do
    # bin/ and obj/ are build output only when a project file sits beside them.
    [ -n "$(find "$(dirname "$dir")" -maxdepth 1 -name '*.*proj' -print -quit)" ] || continue
    targets+=("$dir")
done < <(find "$target" -type d \( -name bin -o -name obj \) -prune -print0)

if [ ${#targets[@]} -eq 0 ]; then
    echo "✅ Nothing to clean under $target"
    exit 0
fi

printf '%s\n' "${targets[@]}"

if [ "$dry_run" -eq 1 ]; then
    echo "🔍 Dry run: ${#targets[@]} directories would be deleted."
    exit 0
fi

if [ "$assume_yes" -eq 0 ]; then
    [ -t 0 ] || die "Not a terminal; re-run with --yes to confirm."
    read -r -p "🧹 Delete these ${#targets[@]} directories? [y/N] " reply
    case "$reply" in
        [yY] | [yY][eE][sS]) ;;
        *) die "Aborted." ;;
    esac
fi

rm -rf -- "${targets[@]}"
echo "✅ Deleted ${#targets[@]} directories under $target"
