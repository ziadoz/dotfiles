set -euo pipefail

function install_zsh_theme() {
    # @see: https://github.com/sindresorhus/pure/issues/664
    echo "Installing Pure ZSH theme..."
    mkdir -p "$HOME/.zsh"
    if [ ! -d "$HOME/.zsh/pure" ]; then
        git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
    fi
}

function install_zsh_config() {
    echo "Copying ZSH files..."
    cp -r ./zsh/. "$HOME"
}

function install_homebrew_config() {
    echo "Copying Homebrew files..."
    cp ./brew/.Brewfile "$HOME"
}

function install_homebrew_apps() {
    echo "Installing Homebrew packages..."
    brew analytics off
    brew bundle --file "$HOME/.Brewfile"
    brew cleanup
}

function install_git_config() {
    echo "Copying Git files..."
    cp ./git/.gitconfig "$HOME"
}

function install_ssh_config() {
    echo "Copying SSH files..."
    mkdir -p "$HOME/.ssh"
    chmod +700 "$HOME/.ssh"
    cp ./ssh/config "$HOME/.ssh"
}

function install_fonts() {
    echo "Copying fonts..."
    cp ./fonts/* "$HOME/Library/Fonts"
}

function install_terminal_theme() {
    echo "Installing Terminal theme..."
    open ./terminal/Snazzy.terminal
}

function install_editor_themes() {
    echo "Installing PhpStorm themes..."
    open ./editors/phpstorm/Atom\ One\ Light.icls
    open ./editors/phpstorm/Atom_One_Light__Material_.icls
}

function install_editor_configs() {
    echo "Copying Sublime Text config..."
    mkdir -p "$HOME/Library/Application Support/Sublime Text/Packages/User"
    cp ./editors/subl/* "$HOME/Library/Application Support/Sublime Text/Packages/User"

    echo "Copying VS Code config..."
    cp ./editors/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"

    echo "Copying Zed config..."
    mkdir -p "$HOME/.config/zed"
    cp ./editors/zed/settings.json "$HOME/.config/zed/settings.json"
}

function install_editor_symlinks() {
    mkdir -p ~/.bin

    # @see: https://gist.github.com/michellephung/9601603cfb235401a3fd
    echo "Symlinking Sublime Text..."
    if [ -d "/Applications/Sublime Text.app" ] && [ ! -f "$HOME/.bin/subl" ]; then
        ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ~/.bin/subl
    fi

    echo "Symlinking VS Code..."
    if [ -d "/Applications/Visual Studio Code.app" ] && [ ! -f "$HOME/.bin/vscode" ]; then
        ln -s /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code ~/.bin/vscode
    fi

    # @see: https://www.jetbrains.com/help/phpstorm/working-with-the-ide-features-from-command-line.html
    echo "Symlinking PhpStorm..."
    if [ -d "/Applications/PhpStorm.app" ] && [ ! -f "$HOME/.bin/phpstorm" ]; then
        echo -en '#!/usr/bin/env bash\n\nopen -na "PhpStorm.app" --args "$@"' > "$HOME/.bin/phpstorm"
        chmod +x "$HOME/.bin/phpstorm"
    fi
}

function install_automator_workflows() {
    # @see: https://blog.gingerbeardman.com/2024/07/30/taking-command-of-the-context-menu-in-macos/
    echo "Copying Automator workflows..."
    cp -r ./automator/* "$HOME/Library/Services"
}

function install_ai_apps() {
    echo "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
}

function install_ai_configs() {
    echo "Copying Claude config..."
    cp -r ./ai/claude/ "$HOME/.claude/"
    chmod +x "$HOME/.claude/statusline.sh"
}

function install_all() {
    install_zsh_theme
    install_zsh_config
    install_homebrew_config
    install_homebrew_apps
    install_git_config
    install_ssh_config
    install_fonts
    install_terminal_theme
    install_editor_configs
    install_editor_symlinks
    # install_editor_themes
    install_automator_workflows
    install_ai_apps
    install_ai_configs
}

install_all