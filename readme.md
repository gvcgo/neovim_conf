## Introduction

This project is a modern, batteries-included Neovim configuration built with
[lazy.nvim](https://github.com/folke/lazy.nvim). It aims to provide a full-featured
coding environment out of the box:

- **Editor UX** — fuzzy finding (fzf-lua), file explorer (nvim-tree), enhanced
  motions (flash.nvim, nvim-spider), buffer/tabline, and a polished statusline.
- **LSP & completion** — Mason-managed language servers, lspsaga.nvim workflows,
  and fast blink.cmp completion, all wired into treesitter text objects.
- **AI coding agent** — first-class integration with the
  [Oh My Pi](https://github.com/can1357/oh-my-pi) coding agent via pi-nvim.
- **Git & code quality** — gitsigns, gitlinker, codediff, grug-far, conform.nvim,
  and TODO comment highlighting.
- **Looks & feel** — Everforest colorscheme, nerdfont icons, and a curated set of
  keybindings documented below.

> **Note:** opencode and deepseek-harness integrations are deprecated (struck
> through below); Oh My Pi is the active AI-agent backend.

## Requirements

- [neovim 0.12.4+](https://github.com/neovim/neovim)
- [nerd font](https://github.com/ryanoasis/nerd-fonts)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fzf](https://github.com/junegunn/fzf)
- [fd](https://github.com/sharkdp/fd) 
- [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md)
- [oh-my-pi](https://github.com/can1357/oh-my-pi)
- [~~opencode~~](https://github.com/anomalyco/opencode)
- [~~deepseek-harness~~](https://github.com/deepseek-ai/deepseek-harness)
- git
- curl
- unzip
- gzip
- tar
- make

## Recommanded

- [~~oh-my-opencode~~](https://github.com/code-yeongyu/oh-my-opencode)
- [~~oh-my-opencode-slim~~](https://github.com/alvinunreal/oh-my-opencode-slim)
- [~~superpowers~~](https://github.com/obra/superpowers/blob/main/docs/README.opencode.md)
- [~~superpowers-zh~~](https://github.com/jnMetaCode/superpowers-zh)

## Install 

```bash
curl -fsSL https://raw.githubusercontent.com/gvcgo/neovim_conf/refs/heads/main/install.sh | bash
```

## Pre-Install

```bash
bun install -g @oh-my-pi/pi-coding-agent
```

## Post-Install(tree-sitter plugins needed by this project)

```bash
:TSInstall lua rust javascript go markdown bash zsh cpp json typescript yaml proto
```

## Terminal Proxy

```bash
# fix opencode connection for opencode.nvim when a proxy has been set for terminal
alias OnProxy="export http_proxy=http://127.0.0.1:2023;export https_proxy=http://127.0.0.1:2023;export no_proxy=127.0.0.1,localhost,::1"
alias OffProxy="unset http_proxy;unset https_proxy"
```

## Key Mappings

- leader = " "

| keys | desc | lua file |
|--------|----------|----------|
| `<leader>wh` (normal) | move to window left | `core/keymap.lua` |
| `<leader>wj` (normal) | move to window below | `core/keymap.lua` |
| `<leader>wk` (normal) | move to window above | `core/keymap.lua` |
| `<leader>wl` (normal) | move to window right | `core/keymap.lua` |
| `<leader>ww` (normal) | cycle to next window | `core/keymap.lua` |
| `<leader>ws` (normal) | split window horizontally | `core/keymap.lua` |
| `<leader>wv` (normal) | split window vertically | `core/keymap.lua` |
| `<leader>wq` (normal) | close current window | `core/keymap.lua` |
| `jk` (insert) | Esc | `core/keymap.lua` |
| `q` (visual) | exit visual mode | `core/keymap.lua` |
| `<CR>` (insert) | Accept Blink completion or fallback | `plugins/blink.lua` |
| `gl` (normal/visual) | goto line end | `core/keymap.lua` |
| `gh` (normal/visual) | goto line start | `core/keymap.lua` |
| `gj` (normal) | goto screen bottom | `core/keymap.lua` |
| `gk` (normal) | goto screen top | `core/keymap.lua` |
| `ge` (normal/visual) | goto last line | `core/keymap.lua` |
| `gp` (normal) | goto previous buffer | `plugins/bufferline.lua` |
| `gn` (normal) | goto next buffer | `plugins/bufferline.lua` |
| `gm` (normal) | goto specified buffer | `plugins/bufferline.lua` |
| `<leader>y` (normal/visual) | copy to clipboard | `core/keymap.lua` |
| `<C-a>` (normal) | select all | `core/keymap.lua` |
| `<C-s>` (normal) | write | `core/keymap.lua` |
| `<C-A-n>` (terminal) | Terminal normal mode | `core/keymap.lua` |
| `<C-x>` (normal) | close current buffer | `plugins/bufferline.lua` |
| `<A-j>` (normal) | move current line down | `plugins/move.lua` |
| `<A-k>` (normal) | move current line up | `plugins/move.lua` |
| `<A-h>` (normal) | move current word left | `plugins/move.lua` |
| `<A-l>` (normal) | move current word right | `plugins/move.lua` |
| `<A-j>` (visual) | move selected block down | `plugins/move.lua` |
| `<A-k>` (visual) | move selected block up | `plugins/move.lua` |
| `<A-h>` (visual) | move selected block left | `plugins/move.lua` |
| `<A-l>` (visual) | move selected block right | `plugins/move.lua` |
| `<leader>.` (normal/visual/terminal) | Toggle Oh My Pi | `plugins/pi-nvim.lua` |
| `<C-S-o>` (normal/visual) | Jump to OMP terminal | `plugins/pi-nvim.lua` |
| `<C-S-o>` (terminal) | Jump to editor buffer | `plugins/pi-nvim.lua` |
| `<leader>aa` (normal/visual) | Pi: Open dialog | `plugins/pi-nvim.lua` |
| `<leader>af` (normal) | Pi: Send file | `plugins/pi-nvim.lua` |
| `<leader>as` (visual) | Pi: Send selection | `plugins/pi-nvim.lua` |
| `<leader>ab` (normal) | Pi: Send buffer | `plugins/pi-nvim.lua` |
| `<leader>ao` (normal) | Pi: List sessions | `plugins/pi-nvim.lua` |
| `<leader>f` (normal) | find files | `plugins/fzf.lua` |
| `<Up>` (Oh My Pi terminal) | scroll up half page | `plugins/pi-nvim.lua` |
| `<Down>` (Oh My Pi terminal) | scroll down half page | `plugins/pi-nvim.lua` |
| `<leader>t` (normal) | Search TODOs in current buffer | `plugins/fzf.lua` |
| `<leader>T` (normal) | Search TODO comments in project | `plugins/fzf.lua` |
| `<leader>C` (normal) | find nvim config files | `plugins/fzf.lua` |
| `<leader>d` (normal) | Search Diagnostics | `plugins/fzf.lua` |
| `<leader>k` (normal) | Search keymaps | `plugins/fzf.lua` |
| `<leader>S` (normal) | Search workspace symbols | `plugins/fzf.lua` |
| `<leader>s` (normal) | Search document symbols | `plugins/fzf.lua` |
| `<leader>/` (normal) | Search string (live grep) | `plugins/fzf.lua` |
| `<leader>L` (normal) | restart lsp | `core/keymap.lua` |
| `K` (normal) | Lspsaga hover documentation | `plugins/lspsaga.lua` |
| `gr` (normal) | Lspsaga LSP finder | `plugins/lspsaga.lua` |
| `gi` (normal) | Lspsaga implementation finder | `plugins/lspsaga.lua` |
| `gs` (normal) | Lspsaga peek definition | `plugins/lspsaga.lua` |
| `gd` (normal) | Lspsaga goto definition | `plugins/lspsaga.lua` |
| `<leader>r` (normal) | LSP: rename symbol | `core/keymap.lua` |
| `<leader>c` (normal/visual) | Lspsaga code action | `plugins/lspsaga.lua` |
| `<leader>o` (normal) | Lspsaga toggle outline | `plugins/lspsaga.lua` |
| `<leader>v` (normal/terminal) | Lspsaga toggle terminal | `plugins/lspsaga.lua` |
| `<C-d>` (Lspsaga preview) | Scroll preview down | `plugins/lspsaga.lua` |
| `q` (Lspsaga rename UI) | quit rename UI | `plugins/lspsaga.lua` |
| `<C-u>` (Lspsaga preview) | Scroll preview up | `plugins/lspsaga.lua` |
| `<leader>e` (normal) | toggle nvim-tree | `plugins/nvim-tree.lua` |
| `<leader>R` (normal) | replace in workspace | `plugins/grug-far.lua` |
| `w` (normal/operator/visual) | spider motion w | `plugins/spider.lua` |
| `e` (normal/operator/visual) | spider motion e | `plugins/spider.lua` |
| `b` (normal/operator/visual) | spider motion b | `plugins/spider.lua` |
| `s` (normal/visual/operator) | Flash | `plugins/flash.lua` |
| `S` (normal/visual/operator) | Flash Treesitter | `plugins/flash.lua` |
| `<C-s>` (command) | Toggle Flash Search | `plugins/flash.lua` |
| `]f` (normal/visual/operator) | goto next function start | `plugins/treesitter-textobjects.lua` |
| `]c` (normal/visual/operator) | goto next class start | `plugins/treesitter-textobjects.lua` |
| `]t` (normal/visual/operator) | goto next class end | `plugins/treesitter-textobjects.lua` |
| `]m` (normal/visual/operator) | goto next function end | `plugins/treesitter-textobjects.lua` |
| `[f` (normal/visual/operator) | goto previous function start | `plugins/treesitter-textobjects.lua` |
| `[c` (normal/visual/operator) | goto previous class start | `plugins/treesitter-textobjects.lua` |
| `[t` (normal/visual/operator) | goto previous class end | `plugins/treesitter-textobjects.lua` |
| `[m` (normal/visual/operator) | goto previous function end | `plugins/treesitter-textobjects.lua` |
| `<leader>gb` (normal/visual) | Open git blame link | `plugins/gitlinker.lua` |
| `<leader>gg` (normal/visual) | Open git link | `plugins/gitlinker.lua` |
| `<leader>gc` (normal) | Search git commits log | `plugins/fzf.lua` |
| `<leader>gr` (normal) | Search git reflog | `plugins/fzf.lua` |
| `<leader>gd` (normal) | CodeDiff: compare working tree with HEAD (uncommitted changes) | `plugins/codediff.lua` |
| `]e` (normal, Git buffer) | next Git hunk | `plugins/git.lua` |
| `[e` (normal, Git buffer) | previous Git hunk | `plugins/git.lua` |
| `q` (CodeDiff view) | close diff tab | `plugins/codediff.lua` |
| `]b` (CodeDiff view) | next change block | `plugins/codediff.lua` |
| `[b` (CodeDiff view) | previous change block | `plugins/codediff.lua` |
| `]f` (CodeDiff view) | next file | `plugins/codediff.lua` |
| `[f` (CodeDiff view) | previous file | `plugins/codediff.lua` |
| `do` (CodeDiff view) | get changes from the other side | `plugins/codediff.lua` |
| `dp` (CodeDiff view) | push changes to the other side | `plugins/codediff.lua` |
| `t` (CodeDiff view) | toggle diff layout | `plugins/codediff.lua` |
| `gc` (CodeDiff view) | toggle compact mode | `plugins/codediff.lua` |
| `-` (CodeDiff view) | stage/unstage current file | `plugins/codediff.lua` |
| `gf` (CodeDiff view) | open file in previous tab | `plugins/codediff.lua` |
| `g?` (CodeDiff view) | show CodeDiff help | `plugins/codediff.lua` |

## tree-sitter textobjects

| keys | desc | lua file |
|--------|----------|----------|
| `af` (visual/operator) | select function outer | `plugins/treesitter-textobjects.lua` |
| `if` (visual/operator) | select function inner | `plugins/treesitter-textobjects.lua` |
| `ac` (visual/operator) | select class outer | `plugins/treesitter-textobjects.lua` |
| `ic` (visual/operator) | select class inner | `plugins/treesitter-textobjects.lua` |
| `aa` (visual/operator) | select parameter outer | `plugins/treesitter-textobjects.lua` |
| `ia` (visual/operator) | select parameter inner | `plugins/treesitter-textobjects.lua` |
| `as` (visual/operator) | select local scope | `plugins/treesitter-textobjects.lua` |
| `ii` (visual/operator) | select subword inner | `plugins/textobjs.lua` |
| `ai` (visual/operator) | select subword outer | `plugins/textobjs.lua` |
| `r` (operator) | Remote Flash | `plugins/flash.lua` |
| `R` (operator/visual) | Treesitter Search | `plugins/flash.lua` |

## gallery

![neovim](https://github.com/moqsien/neovim_conf/blob/main/imgs/neovim.png)
![fzf](https://github.com/moqsien/neovim_conf/blob/main/imgs/neovim_fzf.png)
![outline](https://github.com/moqsien/neovim_conf/blob/main/imgs/neovim_outline.png)


## references

### Neovim Plugins

- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Autopairs for Neovim
- [blink.cmp](https://github.com/saghen/blink.cmp) - Fast completion engine
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - Buffer line/tabline
- [nvim-surround](https://github.com/kylechui/nvim-surround) - Surround text objects
- [nvim-spider](https://github.com/chrisgrieser/nvim-spider) - Enhanced word motion
- [nvim-various-textobjs](https://github.com/chrisgrieser/nvim-various-textobjs) - Additional text objects
- [flash.nvim](https://github.com/folke/flash.nvim) - Lightning-fast motions
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) - Indent line visualization
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Statusline
- [noice.nvim](https://github.com/folke/noice.nvim) - UI enhancements and command history
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) - File explorer
- [everforest-nvim](https://github.com/neanias/everforest-nvim) - Everforest colorscheme
- [fzf-lua](https://github.com/ibhagwan/fzf-lua) - Fuzzy finder
- [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) - Find and replace across workspace
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git integration with signs
- [gitlinker.nvim](https://github.com/linrongbin16/gitlinker.nvim) - Generate shareable links to code on GitHub, GitLab, etc.
- [codediff.nvim](https://github.com/esmuellert/codediff.nvim) - Side-by-side diff
- [conform.nvim](https://github.com/stevearc/conform.nvim) - Formatting framework
- [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) - LSP configuration with Mason
- [lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim) - Enhanced LSP interface and workflows
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Treesitter integration
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) - Treesitter text objects
- [todo-comments.nvim](https://github.com/alexmozaidze/tree-comment.nvim) - Highlight TODO comments
- [move.nvim](https://github.com/hinell/move.nvim) - Move lines and blocks with Alt+direction keys
- [pi-nvim](https://github.com/carderne/pi-nvim) - Bridge between pi coding agent and Neovim
- [~~opencode.nvim~~](https://github.com/nickjvandyke/opencode.nvim) - AI-powered coding assistant
- [~~dsh.nvim~~](https://github.com/AlbinZhu/dsh.nvim) - DeepSeek Harness (dsh) coding agent integration

### Plugin Dependencies

- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Utility library
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) - Web devicons
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Snippet collection
- [mason.nvim](https://github.com/mason-org/mason.nvim) - Package manager
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configurations
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim) - UI component library
- [nvim-notify](https://github.com/rcarriga/nvim-notify) - Notification system
- [snacks.nvim](https://github.com/folke/snacks.nvim) - UI components for OhMyPi

### Other References

- [awesome neovim](https://github.com/rockerBOO/awesome-neovim)
