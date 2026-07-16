#!/bin/sh

set -eu

log() {
    printf '%s\n' "==> $*"
}

die() {
    printf '%s\n' "ERROR: $*" >&2
    exit 1
}

temp_dir=""
staging_path=""
rollback_target=""
rollback_backup=""
cleanup() {
    if [ -n "$temp_dir" ] && [ -d "$temp_dir" ]; then
        rm -rf "$temp_dir"
    fi
    if [ -n "$staging_path" ] && { [ -e "$staging_path" ] || [ -L "$staging_path" ]; }; then
        rm -rf "$staging_path"
    fi
    if [ -n "$rollback_target" ] && [ -n "$rollback_backup" ] && \
        [ ! -e "$rollback_target" ] && [ ! -L "$rollback_target" ] && \
        { [ -e "$rollback_backup" ] || [ -L "$rollback_backup" ]; }; then
        mv "$rollback_backup" "$rollback_target"
    fi
}
trap cleanup 0
trap 'cleanup; trap - HUP; kill -HUP $$' HUP
trap 'cleanup; trap - INT; kill -INT $$' INT
trap 'cleanup; trap - TERM; kill -TERM $$' TERM

new_temp_dir() {
    cleanup
    temp_dir=$(mktemp -d) || die "Could not create a temporary directory"
}

add_to_path() {
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$1:$PATH"; export PATH ;;
    esac
}

nvim_version_at_least_0_12_4() {
    command -v nvim >/dev/null 2>&1 || return 1
    version=$(nvim --version | { IFS= read -r first_line; printf '%s\n' "$first_line"; })
    version=${version#NVIM v}
    version=${version%%-*}
    old_ifs=$IFS
    IFS=.
    set -- $version
    IFS=$old_ifs
    [ "$#" -eq 3 ] || return 1
    major=$1 minor=$2 patch=$3
    for field in "$major" "$minor" "$patch"; do
        [ -n "$field" ] || return 1
        case "$field" in *[!0-9]*) return 1 ;; esac
    done
    [ "$major" -gt 0 ] || \
        { [ "$major" -eq 0 ] && [ "$minor" -gt 12 ]; } || \
        { [ "$major" -eq 0 ] && [ "$minor" -eq 12 ] && [ "$patch" -ge 4 ]; }
}

install_official_neovim() {
    machine=$(uname -m)
    case "$machine" in
        x86_64|amd64)
            nvim_asset=nvim-linux-x86_64.tar.gz
            nvim_sha=012bf3fcac5ade43914df3f174668bf64d05e049a4f032a388c027b1ebd78628
            ;;
        aarch64|arm64)
            nvim_asset=nvim-linux-arm64.tar.gz
            nvim_sha=ceb7e88c6b681f0515d135dcdfad54f5eb4373b25ce6172197cd9a69c758063f
            ;;
        *) die "Linux architecture '$machine' is not supported by the official Neovim installer" ;;
    esac

    log "Installing official Neovim 0.12.4"
    mkdir -p "$HOME/.local/bin" "$HOME/.local/opt"
    add_to_path "$HOME/.local/bin"
    new_temp_dir
    curl -fL "https://github.com/neovim/neovim/releases/download/v0.12.4/$nvim_asset" -o "$temp_dir/$nvim_asset"
    printf '%s  %s\n' "$nvim_sha" "$temp_dir/$nvim_asset" | sha256sum -c -
    staging_path=$(mktemp -d "$HOME/.local/opt/.nvim-0.12.4.XXXXXX") || die "Could not create Neovim staging directory"
    tar -xzf "$temp_dir/$nvim_asset" -C "$staging_path" --strip-components=1
    [ -x "$staging_path/bin/nvim" ] || die "Staged Neovim executable is missing"
    "$staging_path/bin/nvim" --version >/dev/null 2>&1 || die "Staged Neovim executable failed validation"
    nvim_target="$HOME/.local/opt/nvim-0.12.4"
    nvim_old="$HOME/.local/opt/.nvim-0.12.4.old.$$"
    if [ -e "$nvim_target" ] || [ -L "$nvim_target" ]; then
        rollback_target=$nvim_target
        rollback_backup=$nvim_old
        mv "$nvim_target" "$nvim_old"
    fi
    if mv "$staging_path" "$nvim_target"; then
        staging_path=""
        rm -rf "$nvim_old"
        rollback_target=""
        rollback_backup=""
    else
        die "Could not activate staged Neovim installation"
    fi
    link_stage="$HOME/.local/bin/.nvim-link.$$"
    staging_path=$link_stage
    [ ! -d "$HOME/.local/bin/nvim" ] || die "$HOME/.local/bin/nvim is a directory"
    ln -s "$nvim_target/bin/nvim" "$link_stage"
    mv -f "$link_stage" "$HOME/.local/bin/nvim"
    staging_path=""
}

install_arch() {
    [ "$(id -u)" -ne 0 ] || die "Do not run this script as root: makepkg refuses to run as root."

    if ! command -v paru >/dev/null 2>&1; then
        log "Installing paru build prerequisites"
        sudo pacman -Syu --needed --noconfirm base-devel git
        new_temp_dir
        git clone https://aur.archlinux.org/paru.git "$temp_dir/paru"
        log "Building paru as $(id -un)"
        (cd "$temp_dir/paru" && makepkg -si --noconfirm)
    fi

    log "Installing dependencies with paru"
    paru -Syu --needed --noconfirm \
        ttf-jetbrains-mono-nerd ripgrep fzf fd tree-sitter-cli \
        opencode git curl unzip gzip tar make fontconfig

    if paru -Si neovim >/dev/null 2>&1; then
        paru -S --needed --noconfirm neovim
    else
        log "Neovim is unavailable in the configured repositories; using the official release"
    fi

    mkdir -p "$HOME/.local/bin"
    add_to_path "$HOME/.local/bin"
    if ! nvim_version_at_least_0_12_4; then
        install_official_neovim
    fi
}

ubuntu_asset_details() {
    machine=$(uname -m)
    case "$machine" in
        x86_64|amd64)
            nvim_asset=nvim-linux-x86_64.tar.gz
            nvim_sha=012bf3fcac5ade43914df3f174668bf64d05e049a4f032a388c027b1ebd78628
            tree_asset=tree-sitter-linux-x64.gz
            tree_sha=8dac3c89bb632eece700ea7a261ad963b251f2228c4aef3b58458ebea8dbe4eb
            ;;
        aarch64|arm64)
            nvim_asset=nvim-linux-arm64.tar.gz
            nvim_sha=ceb7e88c6b681f0515d135dcdfad54f5eb4373b25ce6172197cd9a69c758063f
            tree_asset=tree-sitter-linux-arm64.gz
            tree_sha=e47dd59bf2f21ad7c15771546a724464ee3c008a60fbb61c6860bd19a44b3060
            ;;
        *) die "Ubuntu architecture '$machine' is not supported" ;;
    esac
}

install_ubuntu() {
    log "Installing Ubuntu packages"
    sudo apt-get update
    sudo apt-get install -y git curl unzip gzip tar make fontconfig ripgrep fzf fd-find ca-certificates bash

    mkdir -p "$HOME/.local/bin" "$HOME/.local/opt"
    add_to_path "$HOME/.local/bin"
    ln -sfn "$(command -v fdfind)" "$HOME/.local/bin/fd"
    ubuntu_asset_details

    install_official_neovim

    log "Installing tree-sitter CLI 0.26.11"
    new_temp_dir
    curl -fL "https://github.com/tree-sitter/tree-sitter/releases/download/v0.26.11/$tree_asset" -o "$temp_dir/$tree_asset"
    printf '%s  %s\n' "$tree_sha" "$temp_dir/$tree_asset" | sha256sum -c -
    staging_path=$(mktemp "$HOME/.local/bin/.tree-sitter.XXXXXX") || die "Could not create tree-sitter staging file"
    gzip -dc "$temp_dir/$tree_asset" > "$staging_path"
    chmod 755 "$staging_path"
    [ -x "$staging_path" ] || die "Staged tree-sitter executable is invalid"
    "$staging_path" --version >/dev/null 2>&1 || die "Staged tree-sitter executable failed validation"
    [ ! -d "$HOME/.local/bin/tree-sitter" ] || die "$HOME/.local/bin/tree-sitter is a directory"
    mv -f "$staging_path" "$HOME/.local/bin/tree-sitter"
    staging_path=""

    add_to_path "$HOME/.opencode/bin"
    if [ ! -x "$HOME/.opencode/bin/opencode" ] && ! command -v opencode >/dev/null 2>&1; then
        log "Installing OpenCode"
        new_temp_dir
        curl -fsSL https://opencode.ai/install -o "$temp_dir/opencode-install.sh"
        bash "$temp_dir/opencode-install.sh" --no-modify-path
    fi

    log "Installing JetBrains Mono Nerd Font 3.4.0"
    new_temp_dir
    curl -fL "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip" -o "$temp_dir/JetBrainsMono.zip"
    font_dir="$HOME/.local/share/fonts/JetBrainsMonoNerdFont"
    mkdir -p "$font_dir"
    unzip -oq "$temp_dir/JetBrainsMono.zip" -d "$font_dir"
    fc-cache -f
}

install_macos() {
    if ! command -v brew >/dev/null 2>&1; then
        log "Installing Homebrew"
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        case "$(uname -m)" in
            arm64) brew_bin=/opt/homebrew/bin/brew ;;
            x86_64) brew_bin=/usr/local/bin/brew ;;
            *) die "macOS architecture '$(uname -m)' is not supported" ;;
        esac
        [ -x "$brew_bin" ] || die "Homebrew installation did not create $brew_bin"
        eval "$($brew_bin shellenv)"
    fi

    log "Installing dependencies with Homebrew"
    brew install neovim tree-sitter-cli ripgrep fzf fd git curl unzip gzip gnu-tar make
    brew install anomalyco/tap/opencode
    brew install --cask font-jetbrains-mono-nerd-font
}

os=$(uname -s)
case "$os" in
    Darwin)
        log "Detected macOS"
        install_macos
        ;;
    Linux)
        [ -r /etc/os-release ] || die "Cannot identify Linux distribution: /etc/os-release is unavailable"
        # shellcheck disable=SC1091
        . /etc/os-release
        case "${ID:-}" in
            arch|manjaro)
                log "Detected ${PRETTY_NAME:-$ID}"
                install_arch
                ;;
            ubuntu)
                log "Detected ${PRETTY_NAME:-Ubuntu}"
                install_ubuntu
                ;;
            *) die "Unsupported Linux distribution: ${PRETTY_NAME:-${ID:-unknown}}" ;;
        esac
        ;;
    *) die "Unsupported operating system: $os" ;;
esac

log "Verifying required commands"
missing_dependencies=""
for command_name in nvim git rg fzf curl fd unzip gzip tar tree-sitter make opencode; do
    if ! command -v "$command_name" >/dev/null 2>&1; then
        missing_dependencies="$missing_dependencies $command_name"
    fi
done
[ -z "$missing_dependencies" ] || die "Missing required commands:$missing_dependencies"

nvim_version_at_least_0_12_4 || die "Neovim >= 0.12.4 is required"

if [ "$os" = Darwin ]; then
    nerd_font_found=false
    for font_dir in "$HOME/Library/Fonts" /Library/Fonts /System/Library/Fonts; do
        for font_file in "$font_dir"/*JetBrainsMono*NerdFont* "$font_dir"/*JetBrainsMono*"Nerd Font"*; do
            if [ -e "$font_file" ]; then nerd_font_found=true; break 2; fi
        done
    done
    [ "$nerd_font_found" = true ] || die "JetBrains Mono Nerd Font could not be verified"
else
    command -v fc-list >/dev/null 2>&1 || die "fontconfig (fc-list) is missing"
    fc-list : family fullname | grep -Eqi 'JetBrains ?Mono.*Nerd Font' || die "JetBrains Mono Nerd Font could not be verified"
fi

log "Installing Neovim configuration"
config_root="$HOME/.config"
repo_dir="$config_root/neovim_conf"
mkdir -p "$config_root"
if [ -d "$repo_dir/.git" ]; then
    current_branch=$(git -C "$repo_dir" symbolic-ref --quiet --short HEAD) || \
        die "$repo_dir is in detached HEAD state; check out main before rerunning"
    [ "$current_branch" = main ] || die "$repo_dir is on branch '$current_branch'; check out main before rerunning"
    git -C "$repo_dir" pull --ff-only origin main
else
    [ ! -e "$repo_dir" ] || die "$repo_dir exists but is not a Git repository"
    git clone --filter=blob:none --sparse https://github.com/gvcgo/neovim_conf.git "$repo_dir"
fi
git -C "$repo_dir" sparse-checkout set nv_conf

canonical_dir() {
    (CDPATH= cd -P "$1" 2>/dev/null && pwd -P)
}

link_points_to_dir() {
    link_path=$1
    expected_dir=$2
    [ -L "$link_path" ] || return 1
    link_text=$(readlink "$link_path") || return 1
    case "$link_text" in
        /*) link_dir=$link_text ;;
        *) link_dir=$(dirname "$link_path")/$link_text ;;
    esac
    actual=$(canonical_dir "$link_dir") || return 1
    expected=$(canonical_dir "$expected_dir") || return 1
    [ "$actual" = "$expected" ]
}

nvim_config="$config_root/nvim"
if link_points_to_dir "$nvim_config" "$repo_dir/nv_conf"; then
    log "Neovim configuration link is already installed"
else
    config_link_stage="$config_root/.nvim.link.$$"
    staging_path=$config_link_stage
    [ ! -e "$config_link_stage" ] && [ ! -L "$config_link_stage" ] || \
        die "Configuration link staging path already exists: $config_link_stage"
    ln -s "$repo_dir/nv_conf" "$config_link_stage"

    if [ -e "$nvim_config" ] || [ -L "$nvim_config" ]; then
        backup="$config_root/nvim.bak.$(date +%Y%m%d%H%M%S).$$"
        rollback_target=$nvim_config
        rollback_backup=$backup
        log "Backing up existing configuration to $backup"
        mv "$nvim_config" "$backup"
    fi
    mv "$config_link_stage" "$nvim_config" || die "Could not activate Neovim configuration link"
    staging_path=""
    rollback_target=""
    rollback_backup=""
fi
log "Installation complete"
