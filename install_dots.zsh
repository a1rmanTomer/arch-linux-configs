#!/zsh

files=(
    ".vimrc"
    ".bashrc"
    ".coding_aliases"
    ".shell_aliases"
)

DOTFILES_DIR=$(dirname "$(readlink -f "$0")")

echo "🔗 Setting up symlinks from: $DOTFILES_DIR"

for file in $files; do
    TARGET="$HOME/$file"
    SOURCE="$DOTFILES_DIR/$file"

    if [ -f "$TARGET" ] && [ ! -L "$TARGET" ]; then
        echo "📦 Backing up existing $file to $file.bak"
        mv "$TARGET" "$TARGET.bak"
    fi

    ln -sf "$SOURCE" "$TARGET"
    echo "✅ Linked $TARGET -> $SOURCE"
done

echo "✨ Environment setup complete, תומר הגדול!"
