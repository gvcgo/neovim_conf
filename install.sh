#!/bin/sh

set -eu

log() {
    printf '%s\n' "==> $*"
}

die() {
    printf '%s\n' "ERROR: $*" >&2
    exit 1
}

staging_path=""
rollback_target=""
rollback_backup=""
cleanup() {
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

os=$(uname -s)
case "$os" in
    Darwin|Linux) ;;
    *) die "Cannot verify prerequisites on unsupported operating system: $os" ;;
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
