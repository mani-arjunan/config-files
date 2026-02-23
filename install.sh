#!/usr/bin/env bash

IS_MAC=false
if [[ "$(uname)" == "Darwin" ]]; then
    IS_MAC=true
fi
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

set -e

# utils
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

check_command() {
    if command_exists "$1"; then
        echo "$1 is installed...\n"
        return 0
    else
        echo "$1 is not installed...\n"
        return 1
    fi
}

execute_sudo_command() {
  if command_exists sudo; then
    sudo "$@"
  else
    "$@"
  fi
}

# For mac, homebrew install
install_homebrew() {
    if command_exists brew; then
        echo "SKIPPING... Homebrew is already installed ... \n"
        return 0
    fi

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew installed successfully..."
}

# Package Installation
install_neovim() {
  echo "Installing Neovim"
  if [[ "$IS_MAC" == true ]]; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-macos-arm64.tar.gz
    tar xzf nvim-macos-arm64.tar.gz
    execute_sudo_command mv nvim-macos-arm64 /opt/nvim
  else
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    tar xzf nvim-linux-x86_64.tar.gz
    execute_sudo_command mv nvim-linux-x86_64 /opt/nvim
  fi
  execute_sudo_command ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
}

install_tmux() {
  if [[ "$IS_MAC" == true ]]; then
    brew install tmux
  else
    execute_sudo_command apt update && execute_sudo_command apt install -y tmux
  fi
}

install_zsh() {
  if [[ "$IS_MAC" != true ]]; then
    echo "Installing zsh via apt...\n"
    execute_sudo_command apt update && execute_sudo_command apt install -y zsh
  fi
}

install_fzf() {
  echo "Installing fzf...\n"

  if [[ "$IS_MAC" == true ]]; then
    brew install fzf
  else
    execute_sudo_command apt update && execute_sudo_command apt install -y fzf
  fi
}

install_ripgrep() {
  echo "Installing ripgrep...\n"
  if [[ "$IS_MAC" == true ]]; then
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-aarch64-apple-darwin.tar.gz
    tar xzf ripgrep-*.tar.gz
    execute_sudo_command mv ripgrep-*/rg /usr/local/bin/
  else
    execute_sudo_command apt update && execute_sudo_command apt install ripgrep
  fi
}

install_node() {
  echo "Installing Node.js via nvm...\n"
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  source "$NVM_DIR/nvm.sh"
  nvm install --lts
}

install_rust() {
  echo "Installing Rust...\n"
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  source "$HOME/.cargo/env"
}

install_go() {
  echo "Installing Go...\n"
  GO_VERSION="1.22.1"

  if [[ "$IS_MAC" == true ]]; then
    curl -LO "https://go.dev/dl/go${GO_VERSION}.darwin-amd64.tar.gz"
  else
    curl -LO "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
  fi

  # rm -rf /usr/local/go
  execute_sudo_command tar -C /usr/local -xzf go*.tar.gz

  echo 'export PATH="/usr/local/go/bin:$PATH"' >> "$HOME/.zshrc"
}

install_jq() {
  echo "Installing jq...\n"
  if [[ "$IS_MAC" == true ]]; then
    curl -L https://github.com/jqlang/jq/releases/latest/download/jq-macos-amd64 -o jq
  else
    curl -L https://github.com/jqlang/jq/releases/latest/download/jq-linux-amd64 -o jq
  fi
  chmod +x jq
  execute_sudo_command mv jq /usr/local/bin/
}

install_ansible() {
  echo "Installing Ansible ...\n"
  if [[ "$IS_MAC" == true ]]; then
    brew install ansible
  else
    execute_sudo_command apt update && execute_sudo_command apt install ansible
  fi
}

# Shell related configs and installation
install_zsh_plugin() {
    local plugin_name="$1"
    local plugin_url="$2"
    local plugin_dir="$HOME/.oh-my-zsh/custom/plugins/$plugin_name"

    if [[ ! -d "$plugin_dir" ]]; then
        echo "Installing $plugin_name...\n"
        git clone "$plugin_url" "$plugin_dir"
        echo "$plugin_name installed...\n"
    else
        echo "$plugin_name is already installed...\n"
    fi
}

install_oh_my_zsh() {
    echo "Setting up Oh My Zsh...\n"

    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo "Oh My Zsh is already installed...\n"
    fi

    install_zsh_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
    install_zsh_plugin "zsh-fzf-history-search" "https://github.com/joshskidmore/zsh-fzf-history-search"
}

install_powerlevel10k() {
  echo -e "Setting up Powerlevel10k theme...\n"

  P10K_DIR="$HOME/.config/powerlevel10k"

  if [[ -d "$P10K_DIR" ]]; then
    echo "Powerlevel10k already installed...\n"
    return
  fi

  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"

  touch "$HOME/.p10k.zsh"

  echo "Powerlevel10k installed...\n"
}

setup_zshrc() {
 echo -e "Setting up Zsh configuration...\n"

  local zshrc_path="$HOME/.zshrc"

  rm -rf ~/.zshrc
  ln -sf "$SCRIPT_DIR/.zshrc" "$zshrc_path"

  echo "Zshrc config symlinked...\n"
}

setup_shell_aliases() {
    echo "Setting up shell aliases...\n"

    local aliases_path="$HOME/alias"

    if [[ -f "$aliases_path" ]]; then
        echo "Existing alias file found...\n"
    else
        echo "Creating symlink: $aliases_path -> $SCRIPT_DIR/alias...\n"
        ln -sf "$SCRIPT_DIR/alias" "$aliases_path"
        echo "Shell aliases symlinked...\n"
    fi
}

setup_scripts() {
    echo "Setting up utility scripts...\n"

    local scripts=(
        "fzf_git.sh"
        "fzf_open.sh"
        "fzf_queries.sh"
        "create-tmux.sh"
        "tmux-kill-session.sh"
    )

    for script in "${scripts[@]}"; do
        local src="$SCRIPT_DIR/$script"
        local dst="$HOME/$script"

        if [[ -f "$src" ]]; then
            if [[ -L "$dst" ]]; then
                echo "$script is already symlinked...\n"
            elif [[ -f "$dst" ]]; then
                echo "Existing $script found at $dst"
                if prompt_user "Backup existing $script?" "y"; then
                    mv "$dst" "$dst.backup"
                    ln -sf "$src" "$dst"
                    chmod +x "$dst"
                    echo "$script symlinked and made executable...\n"
                fi
            else
                ln -sf "$src" "$dst"
                chmod +x "$dst"
                echo "$script symlinked and made executable...\n"
            fi
        else
            echo "Script $script not found in repo...\n"
        fi
    done
}

# tmux related configs and installation
install_tmux_plugins() {
    echo "Setting up Tmux Plugin Manager...\n"

    local tpm_dir="$HOME/.tmux/plugins/tpm"

    if [[ ! -d "$tpm_dir" ]]; then
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    else
        echo "Tmux Plugin Manager is already installed...\n"
    fi
}

setup_tmux_config() {
    echo "Setting up Tmux configuration...\n"

    local tmux_conf="$HOME/.tmux.conf"

    if [[ -f "$tmux_conf" ]]; then
        echo "Skipping setup tmux, existing .tmux.conf found...\n"
    else
      echo "Creating symlink: $tmux_conf -> $SCRIPT_DIR/.tmux.conf...\n"
      ln -sf "$SCRIPT_DIR/.tmux.conf" "$tmux_conf"
    fi
}

# neovim config
setup_neovim_config() {
    echo "Setting up Neovim configuration...\n"

    local nvim_config_dir="$HOME/.config/nvim"

    mkdir -p "$HOME/.config"

    if [[ -d "$nvim_config_dir" ]]; then
      echo "Existing Neovim config found at $nvim_config_dir...\n"
    else
      echo "Creating symlink: $nvim_config_dir -> $SCRIPT_DIR/.config/nvim...\n"
      mkdir -p "$(dirname "$nvim_config_dir")"
      ln -sf "$SCRIPT_DIR/.config/nvim" "$nvim_config_dir"
      echo "Success!! neovim will install plugins on first startup via Packer...\n"
    fi
}

install_lsp_servers() {
  echo -e "Installing LSP servers...\n"

  if ! command_exists typescript-language-server; then
    if command_exists npm; then
      echo "1. Installing typescript-language-server...\n"
      npm install -g typescript typescript-language-server
    fi
  fi

  if ! command_exists lua-language-server; then
    if [[ "$IS_MAC" == true ]] && command_exists brew; then
      echo "2. Installing lua-language-server...\n"
      brew install lua-language-server
    fi
  fi

  if ! command_exists rust-analyzer; then
    if command_exists rustup; then
      echo "3. Installing rust-analyzer...\n"
      rustup component add rust-analyzer
    fi
  fi

  if ! command_exists gopls; then
    if command_exists go; then
      echo "Installing gopls...\n"
      go install golang.org/x/tools/gopls@latest
    fi
  fi
}

# Ghostty config
setup_ghostty_config() {
    echo "Setting up Ghostty configuration...\n"

    local ghostty_dir="$HOME/.config/ghostty"

    mkdir -p "$ghostty_dir"

    if [[ -f "$ghostty_dir/config" ]]; then
        echo "Existing Ghostty config found...\n"
    else
        echo "Creating symlink: $ghostty_dir/config -> $SCRIPT_DIR/ghostty/config...\n"
        ln -sf "$SCRIPT_DIR/ghostty/config" "$ghostty_dir/config"
        echo "Ghostty config symlinked...\n"
    fi
}

# Font config
install_nerd_fonts() {
    echo "Installing Nerd Fonts...\n"

    if [[ "$IS_MAC" == true ]]; then
      brew install --cask font-jetbrains-mono-nerd-font
    else
     if ! command_exists unzip; then
        execute_sudo_command apt update
        execute_sudo_command apt install -y unzip
      fi

      FONT_DIR="$HOME/.local/share/fonts"
      FONT_NAME="JetBrainsMono"
      FONT_VERSION="v3.2.1"

      mkdir -p "$FONT_DIR"
      cd /tmp || exit 1

      curl -LO "https://github.com/ryanoasis/nerd-fonts/releases/download/${FONT_VERSION}/${FONT_NAME}.zip"
      unzip -o "${FONT_NAME}.zip" -d "$FONT_DIR"
      if ! command_exists fc-cache; then
        execute_sudo_command apt update && apt install -y fontconfig
      else
        fc-cache -fv
      fi
    fi
}

# Secrets config
setup_secrets() {
    echo "Setting up secrets directory...\n"

    local secrets_dir="$HOME/secrets"

    if [[ ! -d "$secrets_dir" ]]; then
        mkdir -p "$secrets_dir"
    fi

    ln -sf "$SCRIPT_DIR/secrets/load-envs.sh" "$secrets_dir/load-envs.sh"
}

main() {
    uname=$(uname)
    echo "$uname"
    
    if [[ "$uname" == "Darwin" ]]; then
        IS_MAC=true
    fi
    
    if [[ "$IS_MAC" == true ]]; then
        echo "Setting up your mac..."
        echo "Installing Homebrew..."
        install_homebrew
    else
        echo "Setting up your linux..."
        install_zsh
    fi

    echo "Shell Configuration...\n"
    setup_zshrc
    install_oh_my_zsh
    install_powerlevel10k
    setup_shell_aliases
    setup_scripts
    setup_secrets

    echo "Installing Packages..."
    declare -A PACKAGE_TO_COMMAND=(
      [neovim]="nvim"
      [tmux]="tmux"
      [fzf]="fzf"
      [ripgrep]="rg"
      [git]="git"
      [node]="node"
      [rust]="cargo"
      [go]="go"
      [ansible]="ansible"
      [jq]="jq"
    )

    for package in "${!PACKAGE_TO_COMMAND[@]}"; do
      cmd="${PACKAGE_TO_COMMAND[$package]}"

      if command_exists "$cmd"; then
        echo "$package already installed ($cmd)....\n"
        continue
      fi

      installer="install_${package}"
      if declare -f "$installer" >/dev/null; then
        $installer
        echo "$package installed...\n"
      else
        echo "No installer defined for $package... \n"
      fi
    done


    echo "Tmux Configuration...\n"
    install_tmux_plugins
    setup_tmux_config

    echo "Neovim Configuration...\n"
    setup_neovim_config

    echo "Ghostty setup...\n"
    setup_ghostty_config

    echo "Nerdfont setup...\n"
    install_nerd_fonts

    echo "LSP setup...\n"
    install_lsp_servers

    zsh
}

# Run main function
main "$@"
