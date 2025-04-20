#!/bin/bash

# Set the source directory
SOURCE_DIR="source_configs"

# Set the destination directory (home)
DEST_DIR="$HOME"

FORCE_MOVE=false
# --force Flag to control overwriting existing files
if [ "$1" == "--force" ]; then
  FORCE_MOVE=true
fi

# Enable dotglob to include hidden files
shopt -s dotglob

for file in "$SOURCE_DIR"/*; do
  filename=$(basename "$file")
  dest_file="$DEST_DIR/$filename"
  
  if [ -e "$dest_file" ] && [ "$FORCE_MOVE" = false ]; then
    echo "Skipping $filename (already exists in home directory)"
  else
    cp -f "$file" "$dest_file"
    echo "Copied $filename to $DEST_DIR"
  fi
done

# Disable dotglob
shopt -u dotglob

#Installing tmux tpm package
TPM_PATH="$HOME/.tmux/plugins/tpm"
if [ ! -e "$TPM_PATH" ]; then
  echo "$TPM_PATH does not exist. Installing tmux package manager..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_PATH"
fi

echo "You will need to exit and reload tmux, then install the plugins from .tmux.conf with 'prefix' + I (uppercase)" 