#!/bin/bash
# new_example.sh - Create a new example from a template
# Usage: ./new_example.sh <asm|c> [name]
# If name is omitted, today's date (yyyy-mm-dd) is used.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

TYPE="$1"
NAME="${2:-$(date +%Y-%m-%d)}"

if [ -z "$TYPE" ]; then
    echo "Usage: $0 <asm|c> [name]"
    exit 1
fi

case "$TYPE" in
    asm)
        TEMPLATE_DIR="$SCRIPT_DIR/asm_template"
        EXAMPLES_DIR="$SCRIPT_DIR/asm_examples"
        MAIN_SRC="_main.asm"
        MAIN_DST="main.asm"
        ;;
    c)
        TEMPLATE_DIR="$SCRIPT_DIR/c_template"
        EXAMPLES_DIR="$SCRIPT_DIR/c_examples"
        MAIN_SRC="_main.c"
        MAIN_DST="main.c"
        ;;
    *)
        echo "Error: type must be 'asm' or 'c' (got '$TYPE')"
        exit 1
        ;;
esac

DEST="$EXAMPLES_DIR/$NAME"

if [ -e "$DEST" ]; then
    echo "Error: '$DEST' already exists"
    exit 1
fi

cp -r "$TEMPLATE_DIR" "$DEST"
mv "$DEST/$MAIN_SRC" "$DEST/$MAIN_DST"
mkdir -p "$DEST/output"

cat > "$DEST/README.md" <<EOF
# $NAME
EOF

echo "Created $TYPE example: $DEST"
