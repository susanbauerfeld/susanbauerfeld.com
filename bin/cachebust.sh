#!/bin/sh
# Append a content hash to the stylesheet URL in every page, so a changed
# stylesheet is a new URL and browsers cannot pair new HTML with old CSS.
# GitHub Pages serves both with max-age=600 and no way to set headers.
#
# Run after editing css/style.css, before committing.
set -e
cd "$(dirname "$0")/.."
HASH=$(md5 -q css/style.css 2>/dev/null || md5sum css/style.css | cut -d' ' -f1)
HASH=$(echo "$HASH" | cut -c1-8)
for f in *.html; do
  sed -i '' -E "s|href=\"css/style\.css(\?v=[a-f0-9]+)?\"|href=\"css/style.css?v=$HASH\"|g" "$f"
done
echo "stylesheet versioned as ?v=$HASH in $(ls *.html | wc -l | tr -d ' ') pages"
