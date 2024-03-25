echo "Installing Pure ZSH theme..."
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

echo "Copying ZSH files..."
cp ./zsh/* "$HOME"

echo "Copying HomeBrew files..."
cp ./brew/.Brewfile

# @todo: Install HomeBrew
# @todo: Cleanup HomeBrew packages
# @todo: Install HomeBrew packages: mas signin <email> && brew bundle --file ~/.Brewfile
# @todo: Disable HomeBrew analytics: brew analytics off
# @todo: Cleanup HomeBrew: brew cleanup && brew cleanup --prune-prefix

echo "Copy Git files..."
cp ./git/.gitconfig "$HOME"

echo "Copy SSH files..."
mkdir -p "$HOME/.ssh"
chmod +700 "$HOME/.ssh"
cp ./ssh/config "$HOME/.ssh"

echo "Copy font files..."
cp ./fonts/* "$HOME/Library/Fonts"

echo "Installing Terminal theme..."
open ./terminal/Snazzy.terminal

echo "Installing PhpStorm theme..."
open ./ide/Atom One Light.icls
open ./ide/Atom_One_Light__Material_.icls

# @see: https://gist.github.com/michellephung/9601603cfb235401a3fd
echo "Symlinking Sublime Text..."
if [ -d "/Applications/Sublime Text.app" ] && [ ! -f "$HOME/.bin/subl" ]; then
    mkdir -p ~/.bin
    ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ~/.bin/subl
fi

# @see: https://www.jetbrains.com/help/phpstorm/working-with-the-ide-features-from-command-line.html
echo "Symlinking PhpStorm..."
if [ -d "/Applications/PhpStorm.app" ] && [ ! -f "$HOME/.bin/phpstorm" ]; then
    mkdir -p ~/.bin
    echo -en '#!/bin/sh\n\nopen -na "PhpStorm.app" --args "$@"' > "$HOME/.bin/phpstorm"
    chmod +x "$HOME/.bin/phpstorm"
fi
