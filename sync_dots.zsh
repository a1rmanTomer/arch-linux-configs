#!/bin/zsh

files=(
    ".vimrc"
    ".bashrc"
    ".coding_aliases"
    ".shell_aliases"
)

REPO_DIR=$(pwd)

echo "🔄 Starting sync to: $REPO_DIR"

for file in $files; do
    if [ -f "$HOME/$file" ]; then
        cp "$HOME/$file" "$REPO_DIR/"
        echo "✅ Copied $file"
    else
        echo "⚠️  Warning: $HOME/$file not found, skipping."
    fi
done

echo "✨ Sync complete!"
