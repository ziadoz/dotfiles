echo "Installing Pure ZSH theme..."
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

echo "Copying ZSH files..."
cp ./zsh/* ~/

echo "Copying HomeBrew files..."
cp ./brew/.Brewfile ~/

# @todo: Install HomeBrew
# @todo: Cleanup HomeBrew packages
# @todo: Install HomeBrew packages: mas signin <email> && brew bundle --file ~/.Brewfile
# @todo: Disable HomeBrew analytics: brew analytics off
# @todo: Cleanup HomeBrew: brew cleanup && brew cleanup --prune-prefix

echo "Copy Git files..."
cp ./git/.gitconfig ~/

echo "Copy SSH files..."
mkdir -p ~/.ssh
chmod +700 ~/.ssh
cp ./ssh/config ~/.ssh

echo "Copy font files..."
cp ./fonts/* ~/Library/Fonts

echo "Installing Terminal theme..."
open ./terminal/Snazzy.terminal

echo "Installing PhpStorm theme..."
open ./ide/Atom One Light.icls
open ./ide/Atom_One_Light__Material_.icls

echo "Symlinking Sublime Text..."
if [ -d "/Applications/Sublime Text.app" ] && [ ! -f "~/.bin/subl" ]; then
    ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ~/.bin/subl
fi
