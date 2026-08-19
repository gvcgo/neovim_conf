#!/bin/sh
# install.sh — Install the neovim_conf configuration.
#
# Verifies the external tools required by the configuration (see README
# "Requirements") and, when all are present, installs this repository's
# nv_conf directory as a symlink at ~/.config/nvim, backing up any existing
# configuration first.
#
# Usage:
#   sh install.sh
#   curl -fsSL https://raw.githubusercontent.com/gvcgo/neovim_conf/refs/heads/main/install.sh | bash

set -eu

# --- Configuration ---------------------------------------------------------

REPO_URL="https://github.com/gvcgo/neovim_conf.git"
REPO_NAME="neovim_conf"
CONFIG_SUBDIR="nv_conf"

CONFIG_ROOT="$HOME/.config"
REPO_DIR="$CONFIG_ROOT/$REPO_NAME"
NVIM_CONFIG="$CONFIG_ROOT/nvim"

# Minimum supported Neovim version (see README "Requirements").
REQUIRED_NVIM_MAJOR=0
REQUIRED_NVIM_MINOR=12
REQUIRED_NVIM_PATCH=4

# External commands the configuration depends on (see README "Requirements").
REQUIRED_COMMANDS="nvim git rg fzf fd tree-sitter curl unzip gzip tar make omp"

os_name=$(uname -s)

# --- Logging and errors ----------------------------------------------------

log() {
    printf '%s\n' "==> $*"
}

die() {
    printf '%s\n' "ERROR: $*" >&2
    exit 1
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

is_integer() {
    case $1 in
        ''|*[!0-9]*) return 1 ;;
        *) return 0 ;;
    esac
}

# --- Prerequisite checks ---------------------------------------------------

# Exit nonzero unless `nvim` is available and >= REQUIRED_NVIM_*.
nvim_version_is_supported() {
    command_exists nvim || return 1

    version=$(nvim --version | { IFS= read -r line; printf '%s\n' "$line"; })
    version=${version#NVIM v}   # strip the leading "NVIM v"
    version=${version%%-*}      # drop any "-dev"/"-nightly" suffix

    major=${version%%.*}
    rest=${version#*.}
    minor=${rest%%.*}
    patch=${rest#*.}

    # Require a numeric MAJOR.MINOR.PATCH triplet.
    is_integer "$major" && is_integer "$minor" && is_integer "$patch" || return 1
    [ "$version" = "$major.$minor.$patch" ] || return 1

    [ "$major" -gt "$REQUIRED_NVIM_MAJOR" ] || \
        { [ "$major" -eq "$REQUIRED_NVIM_MAJOR" ] && [ "$minor" -gt "$REQUIRED_NVIM_MINOR" ]; } || \
        { [ "$major" -eq "$REQUIRED_NVIM_MAJOR" ] && [ "$minor" -eq "$REQUIRED_NVIM_MINOR" ] && \
          [ "$patch" -ge "$REQUIRED_NVIM_PATCH" ]; }
}

# Exit nonzero unless a JetBrains Mono Nerd Font is installed.
nerd_font_is_installed() {
    if [ "$os_name" = Darwin ]; then
        for dir in "$HOME/Library/Fonts" /Library/Fonts /System/Library/Fonts; do
            for file in "$dir"/*JetBrainsMono*NerdFont* "$dir"/*JetBrainsMono*"Nerd Font"*; do
                [ -e "$file" ] && return 0
            done
        done
        return 1
    fi

    command_exists fc-list || return 1
    fc-list : family fullname | grep -Eqi 'JetBrains ?Mono.*Nerd Font'
}

check_prerequisites() {
    case "$os_name" in
        Darwin|Linux) ;;
        *) die "Unsupported operating system: $os_name" ;;
    esac

    log "Verifying required commands"
    missing=""
    for cmd in $REQUIRED_COMMANDS; do
        command_exists "$cmd" || missing="$missing\n  - $cmd"
    done
    if [ -n "$missing" ]; then
        printf 'ERROR: Missing required commands:%b\n' "$missing" >&2
        exit 1
    fi

    nvim_version_is_supported || \
        die "Neovim $REQUIRED_NVIM_MAJOR.$REQUIRED_NVIM_MINOR.$REQUIRED_NVIM_PATCH or later is required"

    log "Verifying Nerd Font"
    if [ "$os_name" = Linux ] && ! command_exists fc-list; then
        die "fontconfig (fc-list) is missing"
    fi
    nerd_font_is_installed || die "JetBrains Mono Nerd Font could not be verified"
}

# --- Rollback on failure ---------------------------------------------------

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

trap cleanup EXIT
trap 'cleanup; trap - HUP; kill -HUP $$' HUP
trap 'cleanup; trap - INT; kill -INT $$' INT
trap 'cleanup; trap - TERM; kill -TERM $$' TERM

# --- Installation ----------------------------------------------------------

canonical_dir() {
    (CDPATH= cd -P "$1" 2>/dev/null && pwd -P)
}

# Exit 0 if $1 is a symlink that resolves (following links) to $2.
link_points_to_dir() {
    link_path=$1
    expected_dir=$2
    [ -L "$link_path" ] || return 1

    link_text=$(readlink "$link_path") || return 1
    case "$link_text" in
        /*) link_dir=$link_text ;;
        *)  link_dir=$(dirname "$link_path")/$link_text ;;
    esac

    actual=$(canonical_dir "$link_dir") || return 1
    expected=$(canonical_dir "$expected_dir") || return 1
    [ "$actual" = "$expected" ]
}

fetch_repo() {
    mkdir -p "$CONFIG_ROOT"

    if [ -d "$REPO_DIR/.git" ]; then
        current_branch=$(git -C "$REPO_DIR" symbolic-ref --quiet --short HEAD) || \
            die "$REPO_DIR is in a detached HEAD state; check out main before rerunning"
        [ "$current_branch" = main ] || \
            die "$REPO_DIR is on branch '$current_branch'; check out main before rerunning"
        git -C "$REPO_DIR" pull --ff-only origin main
    else
        [ ! -e "$REPO_DIR" ] || die "$REPO_DIR exists but is not a Git repository"
        git clone --filter=blob:none --sparse "$REPO_URL" "$REPO_DIR"
    fi

    git -C "$REPO_DIR" sparse-checkout set "$CONFIG_SUBDIR"
}

activate_symlink() {
    if link_points_to_dir "$NVIM_CONFIG" "$REPO_DIR/$CONFIG_SUBDIR"; then
        log "Neovim configuration link is already installed"
        return 0
    fi

    staging="$CONFIG_ROOT/.nvim.link.$$"
    [ ! -e "$staging" ] && [ ! -L "$staging" ] || \
        die "Configuration link staging path already exists: $staging"

    staging_path=$staging
    ln -s "$REPO_DIR/$CONFIG_SUBDIR" "$staging"

    if [ -e "$NVIM_CONFIG" ] || [ -L "$NVIM_CONFIG" ]; then
        backup="$CONFIG_ROOT/nvim.bak.$(date +%Y%m%d%H%M%S).$$"
        rollback_target=$NVIM_CONFIG
        rollback_backup=$backup
        log "Backing up existing configuration to $backup"
        mv "$NVIM_CONFIG" "$backup"
    fi

    mv "$staging" "$NVIM_CONFIG" || die "Could not activate Neovim configuration link"

    staging_path=""
    rollback_target=""
    rollback_backup=""
}

main() {
    check_prerequisites
    log "Installing Neovim configuration"
    fetch_repo
    activate_symlink
    log "Installation complete"
}

main "$@"
