#!/bin/bash
# update_examples.sh - Copy shared template files into all examples
# Excludes _*.* files (e.g. _main.asm, _main.c) which are per-example starters.
# Usage: ./update_examples.sh [asm|c]
# If no type is given, both asm and c examples are updated.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

update_type() {
    local type="$1"
    local template_dir="$SCRIPT_DIR/${type}_template"
    local examples_dir="$SCRIPT_DIR/${type}_examples"

    echo "Updating $type examples..."

    for example in "$examples_dir"/*/; do
        [ -d "$example" ] || continue
        name="$(basename "$example")"
        for src in "$template_dir"/*; do
            filename="$(basename "$src")"
            # Skip _*.* template starters
            case "$filename" in _*) continue ;; esac
            cp "$src" "$example/$filename"
            echo "  $name/$filename"
        done
    done
}

TYPE="${1:-}"

case "$TYPE" in
    asm) update_type asm ;;
    c)   update_type c   ;;
    "")  update_type asm; update_type c ;;
    *)
        echo "Error: type must be 'asm' or 'c' (got '$TYPE')"
        exit 1
        ;;
esac

echo "Done."
