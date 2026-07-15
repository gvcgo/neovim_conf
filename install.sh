#!/bin/sh

missing_dependencies=""

check_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        missing_dependencies="${missing_dependencies}\n- $2"
    fi
}

check_command nvim "Neovim (nvim)"
check_command git "Git (git)"
check_command rg "ripgrep (rg)"
check_command fzf "fzf"
check_command curl "curl"
check_command fd "fd"
check_command unzip "unzip"
check_command gzip "gzip"
check_command tar "tar"
check_command tree-sitter "tree-sitter-cli (tree-sitter)"
check_command make "make"
check_command opencode "opencode"

if [ "$(uname -s)" = "Darwin" ]; then
    nerd_font_found=false
    for font_dir in "$HOME/Library/Fonts" /Library/Fonts /System/Library/Fonts; do
        for font_file in "$font_dir"/*NerdFont* "$font_dir"/*"Nerd Font"*; do
            if [ -e "$font_file" ]; then
                nerd_font_found=true
                break 2
            fi
        done
    done

    if [ "$nerd_font_found" = false ]; then
        missing_dependencies="${missing_dependencies}\n- Nerd Font"
    fi
elif ! command -v fc-list >/dev/null 2>&1; then
    missing_dependencies="${missing_dependencies}\n- fontconfig (fc-list)\n- Nerd Font (cannot verify without fc-list)"
elif ! fc-list | grep -qi "Nerd Font"; then
    missing_dependencies="${missing_dependencies}\n- Nerd Font"
fi

if [ -n "$missing_dependencies" ]; then
    printf 'Missing required tools or fonts:%b\n' "$missing_dependencies" >&2
    printf 'Please install them before running this script again.\n' >&2
    exit 1
fi

git clone --filter=blob:none --sparse https://github.com/gvcgo/neovim_conf.git ~/.config/neovim_conf

cd ~/.config/neovim_conf

git sparse-checkout set nv_conf

mv ~/.config/nvim ~/.config/nvim.bak.$(date +%Y%m%d%H%M%S) 2>/dev/null

ln -sfn ~/.config/neovim_conf/nv_conf ~/.config/nvim
