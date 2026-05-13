#!/usr/bin/env bash

set -euo pipefail

# Ensure installer works no matter which directory it's run from.
cd "$(dirname "${BASH_SOURCE[0]}")"

if [ "${DOTFILES_INSTALL_DEBUG:-0}" = "1" ]; then
    set -x
fi

function success() { echo "$(tput setaf 2)$*$(tput sgr0)"; }
function info()    { echo "$(tput setaf 4)$*$(tput sgr0)"; }
function error()   { echo "$(tput setaf 1)$*$(tput sgr0)" >&2; }

function install_brew_apps() {
    info "Installing Homebrew packages..."
    brew analytics off
    brew bundle --file ./apps/.Brewfile
    brew cleanup
}

function install_cli_zsh_theme() {
    # @see: https://github.com/sindresorhus/pure/issues/664
    info "Installing Pure ZSH theme..."
    mkdir -p "$HOME/.zsh"
    if [ ! -d "$HOME/.zsh/pure" ]; then
        git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
    fi
}

function install_cli_zsh_config() {
    info "Copying ZSH files..."
    cp -r ./cli/zsh/. "$HOME"
}

function install_cli_bin_scripts() {
    info "Copying bin scripts..."
    mkdir -p "$HOME/.bin"
    cp ./cli/bin/* "$HOME/.bin/"
    chmod +x "$HOME/.bin/"*
}

function install_cli_git_config() {
    info "Copying Git files..."
    cp ./cli/git/.gitconfig "$HOME"
}

function install_cli_ssh_config() {
    info "Copying SSH files..."
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    if [ -s ./cli/ssh/config ]; then
        cp ./cli/ssh/config "$HOME/.ssh"
    fi
}

function install_cli_theme() {
    info "Installing Terminal themes..."
    open ./cli/themes/*.terminal
}

function install_cli_ghostty_config() {
    info "Copying Ghostty config..."
    mkdir -p "$HOME/.config/ghostty"
    cp ./cli/ghostty/config "$HOME/.config/ghostty/config"
}

function install_fonts() {
    info "Installing fonts..."
    brew bundle --file ./fonts/.Brewfile
}

function install_editor_symlinks() {
    mkdir -p ~/.bin

    # @see: https://gist.github.com/michellephung/9601603cfb235401a3fd
    info "Symlinking Sublime Text..."
    if [ -d "/Applications/Sublime Text.app" ] && [ ! -f "$HOME/.bin/subl" ]; then
        ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ~/.bin/subl
    fi

    info "Symlinking VS Code..."
    if [ -d "/Applications/Visual Studio Code.app" ] && [ ! -f "$HOME/.bin/code" ]; then
        ln -s /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code ~/.bin/code
    fi

    # @see: https://www.jetbrains.com/help/phpstorm/working-with-the-ide-features-from-command-line.html
    info "Symlinking PhpStorm..."
    if [ -d "/Applications/PhpStorm.app" ] && [ ! -f "$HOME/.bin/phpstorm" ]; then
        ln -s /Applications/PhpStorm.app/Contents/MacOS/phpstorm ~/.bin/phpstorm
    fi

    # Zed bundles its CLI as `cli`, so we symlink it as `zed` to match the conventional command name.
    info "Symlinking Zed..."
    if [ -d "/Applications/Zed.app" ] && [ ! -f "$HOME/.bin/zed" ]; then
        ln -s /Applications/Zed.app/Contents/MacOS/cli ~/.bin/zed
    fi
}

function install_editor_configs() {
    info "Copying Sublime Text config..."
    mkdir -p "$HOME/Library/Application Support/Sublime Text/Packages/User"
    cp ./editors/subl/*.sublime-settings "$HOME/Library/Application Support/Sublime Text/Packages/User"

    info "Copying VS Code config..."
    cp ./editors/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"

    info "Copying Zed config..."
    mkdir -p "$HOME/.config/zed"
    cp ./editors/zed/settings.json "$HOME/.config/zed/settings.json"
}

function install_editor_themes() {
    # info "Installing PhpStorm themes..."
    # Catppuccin PhpStorm plugin: install manually via Settings > Plugins > Marketplace ("Catppuccin Theme").
    # @see: https://plugins.jetbrains.com/plugin/18682-catppuccin-theme

    # info "Installing Sublime Text themes..."
    # Catppuccin Sublime Text: install manually via Package Control ("Catppuccin Color Scheme").
    # @see: https://packagecontrol.io/packages/Catppuccin%20Color%20Scheme

    # @see: https://github.com/catppuccin/vscode
    info "Installing VS Code themes..."
    if command -v code &>/dev/null; then
        code --install-extension catppuccin.catppuccin-vsc
    fi

    # info "Installing Zed themes..."
    # Catppuccin Zed: install manually via the Extensions panel (cmd+shift+x, search "Catppuccin").
    # @see: https://github.com/catppuccin/zed
}

function install_automator_workflows() {
    # @see: https://blog.gingerbeardman.com/2024/07/30/taking-command-of-the-context-menu-in-macos/
    info "Copying Automator workflows..."
    cp -r ./automator/* "$HOME/Library/Services"
}

function install_ai_apps() {
    info "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
}

function install_ai_configs() {
    info "Copying Claude config..."
    cp -r ./ai/claude/ "$HOME/.claude/"
    chmod +x "$HOME/.claude/statusline.sh"
}

function install_all() {
    install_brew_apps
    install_cli_zsh_theme
    install_cli_zsh_config
    install_cli_bin_scripts
    install_cli_git_config
    install_cli_ssh_config
    install_cli_theme
    install_cli_ghostty_config
    install_fonts
    install_editor_symlinks
    install_editor_configs
    install_editor_themes
    install_automator_workflows
    install_ai_apps
    install_ai_configs
    success "All done."
}

# Only run install_all when executed directly, not when sourced to call individual functions.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_all
fi
