#!/bin/bash

# Target directories
DIRS=("assets/art" "assets/sketches")

echo "Starting thumbnail generation..."

for DIR in "${DIRS[@]}"; do
  if [ -d "$DIR" ]; then
    echo "Processing directory: $DIR"
    mkdir -p "$DIR/thumbs"

    # Find images (case insensitive extensions)
    find "$DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | while read -r FILE; do
      FILENAME=$(basename "$FILE")
      THUMB="$DIR/thumbs/$FILENAME"

      if [ ! -f "$THUMB" ]; then
        echo "Generating thumbnail for: $FILENAME"
        # Resize to 400px width (maintaining aspect ratio)
        convert "$FILE" -resize 400 "$THUMB"
      else
        echo "Thumbnail exists for: $FILENAME (skipping)"
      fi
    done
  else
    echo "Directory not found: $DIR (skipping)"
  fi
done

echo "Thumbnail generation complete."
