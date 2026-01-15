#!/bin/bash
set -euo pipefail

show_help() {
    cat <<EOF
Generate favicon variants from a source PNG image.

Usage: $(basename "$0") [OPTIONS] [SOURCE] [OUTPUT_DIR]

Arguments:
  SOURCE      Path to source PNG image (default: ./favicon.png)
  OUTPUT_DIR  Directory for generated files (default: ./static)

Options:
  -h, --help  Show this help message

Generated files:
  favicon-16x16.png     16x16 browser favicon
  favicon-32x32.png     32x32 browser favicon
  apple-touch-icon.png  180x180 iOS home screen icon
  android-icon.png      192x192 Android home screen icon

Requirements:
  sips        macOS built-in image tool (required)

Optional tools for better compression:
  pngquant    Lossy PNG compression (brew install pngquant)
  optipng     Lossless PNG optimization (brew install optipng)

Examples:
  $(basename "$0")                           # Use defaults
  $(basename "$0") logo.png                  # Custom source
  $(basename "$0") logo.png dist/            # Custom source and output
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    show_help
    exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
SOURCE="${1:-$PROJECT_ROOT/favicon.png}"
OUTPUT_DIR="${2:-$PROJECT_ROOT/static}"

if [[ ! -f "$SOURCE" ]]; then
    echo "Error: Source file not found: $SOURCE"
    echo "Run '$(basename "$0") --help' for usage information."
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

SIZES=(
    "16:favicon-16x16.png"
    "32:favicon-32x32.png"
    "180:apple-touch-icon.png"
    "192:android-icon.png"
)

echo "Generating favicons from: $SOURCE"
echo "Output directory: $OUTPUT_DIR"

for entry in "${SIZES[@]}"; do
    size="${entry%%:*}"
    filename="${entry#*:}"
    output="$OUTPUT_DIR/$filename"

    echo "  Creating ${filename} (${size}x${size})..."

    cp "$SOURCE" "$output"
    sips --resampleHeightWidth "$size" "$size" "$output" >/dev/null 2>&1
done

if command -v pngquant &>/dev/null; then
    echo "Optimizing with pngquant..."
    for entry in "${SIZES[@]}"; do
        filename="${entry#*:}"
        output="$OUTPUT_DIR/$filename"
        pngquant --force --quality=65-80 --output "$output" "$output" 2>/dev/null || true
    done
fi

if command -v optipng &>/dev/null; then
    echo "Optimizing with optipng..."
    for entry in "${SIZES[@]}"; do
        filename="${entry#*:}"
        optipng -quiet -o2 "$OUTPUT_DIR/$filename" 2>/dev/null || true
    done
fi

echo ""
echo "Generated favicons:"
for entry in "${SIZES[@]}"; do
    filename="${entry#*:}"
    output="$OUTPUT_DIR/$filename"
    size=$(stat -f '%z' "$output" 2>/dev/null || stat -c '%s' "$output" 2>/dev/null)
    dims=$(sips -g pixelWidth -g pixelHeight "$output" 2>/dev/null | grep -E 'pixel' | awk '{print $2}' | tr '\n' 'x' | sed 's/x$//')
    echo "  $filename: ${dims} (${size} bytes)"
done
