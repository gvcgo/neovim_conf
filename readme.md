## Requirements

- [Neovim](https://github.com/neovim/neovim)
- Git
- [Nerd Font](https://github.com/ryanoasis/nerd-fonts)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fzf](https://github.com/junegunn/fzf)
- curl
- [fd](https://github.com/sharkdp/fd) 
- unzip
- gzip
- tar
- [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md)
- make
- [opencode](https://github.com/anomalyco/opencode)
- [oh-my-opencode](https://github.com/code-yeongyu/oh-my-opencode)
- [oh-my-opencode-slim](https://github.com/alvinunreal/oh-my-opencode-slim)
- [superpowers](https://github.com/obra/superpowers/blob/main/docs/README.opencode.md)
- [superpowers-zh](https://github.com/jnMetaCode/superpowers-zh)

## Envs

```bash
# inline completion conf example. Add envs blow to .zshrc or .bashrc
# export AI_END_POINT="https://api.longcat.chat/openai/v1/chat/completions"
# export AI_API_KEY="xxx"
# export AI_MODEL="LongCat-Flash-Lite"
# export AI_MODEL="LongCat-Flash-Chat"
# export AI_MODEL="LongCat-Flash-Thinking"
# export AI_MODEL="LongCat-Flash-Thinking-2601"
```

## Install

```bash
git clone --filter=blob:none --sparse https://github.com/gvcgo/neovim_conf.git ~/.config/neovim_conf

cd ~/.config/neovim_conf

git sparse-checkout set nv_conf

ln -sfn ~/.config/neovim_conf/nv_conf ~/.config/nvim
```

## Tree-sitter plugins

```bash
:TSInstall lua rust javascript go markdown bash zsh cpp json typescript yaml proto
```

## Terminal Proxy

```bash
alias OnProxy="export http_proxy=http://127.0.0.1:2023;export https_proxy=http://127.0.0.1:2023;export no_proxy=127.0.0.1,localhost,::1"
alias OffProxy="unset http_proxy;unset https_proxy"
```

## Key Mappings

- leader = " "

| keys | desc | lua file |
|--------|----------|----------|
| `jk` (insert) | Esc | `core/keymap.lua` |
| `q` (visual) | Esc | `core/keymap.lua` |
| `<CR>` (insert) | Accept Blink completion or fallback | `plugins/blink.lua` |
| `gl` (normal/visual) | goto line end | `core/keymap.lua` |
| `gh` (normal/visual) | goto line start | `core/keymap.lua` |
| `gj` (normal) | goto screen bottom | `core/keymap.lua` |
| `gk` (normal) | goto screen top | `core/keymap.lua` |
| `ge` (normal/visual) | goto last line | `core/keymap.lua` |
| `gp` (normal) | got previous buffer | `plugins/bufferline.lua` |
| `gn` (normal) | goto next buffer | `plugins/bufferline.lua` |
| `gm` (normal) | goto specified buffer | `plugins/bufferline.lua` |
| `<leader>y` (normal/visual) | copy to clipboard | `core/keymap.lua` |
| `<C-a>` (normal) | select all | `core/keymap.lua` |
| `<C-s>` (normal) | write | `core/keymap.lua` |
| `<C-x>` (normal) | close current buffer | `plugins/bufferline.lua` |
| `<leader>a` (normal/visual) | Ask opencode… | `plugins/opencode.lua` |
| `<leader>b` (normal/visual) | Select opencode… | `plugins/opencode.lua` |
| `<leader>.` (normal/terminal) | Toggle opencode | `plugins/opencode.lua` |
| `<A-o>` (normal/terminal) | Focus opencode terminal or previous window | `plugins/opencode.lua` |
| `<leader>h` (normal/visual) | Append range to opencode | `plugins/opencode.lua` |
| `<leader>l` (normal) | Append line to opencode | `plugins/opencode.lua` |
| `<S-C-u>` (normal) | Scroll opencode up | `plugins/opencode.lua` |
| `<S-C-d>` (normal) | Scroll opencode down | `plugins/opencode.lua` |
| `<leader>t` (normal) | Search todo comments | `plugins/todo.lua` |
| `<leader>f` (normal) | find files | `plugins/fzf.lua` |
| `<leader>C` (normal) | find nvim config files | `plugins/fzf.lua` |
| `<leader>d` (normal) | Search Diagnostics | `plugins/fzf.lua` |
| `<leader>k` (normal) | Search keymaps | `plugins/fzf.lua` |
| `<leader>S` (normal) | Search LSP dynamic workspace symbols | `plugins/fzf.lua` |
| `<leader>s` (normal) | Search LSP document symbols | `plugins/fzf.lua` |
| `<leader>/` (normal) | Search string (live grep) | `plugins/fzf.lua` |
| `gc` (visual) | Toggle block comment | `default` |
| `gcc` (normal) | Toggle line comment | `default` |
| `<leader>L` (normal) | restart lsp | `core/keymap.lua` |
| `K` (normal) | Lspsaga hover documentation | `plugins/lspsaga.lua` |
| `gr` (normal) | Lspsaga LSP finder | `plugins/lspsaga.lua` |
| `gi` (normal) | Lspsaga implementation finder | `plugins/lspsaga.lua` |
| `gs` (normal) | Lspsaga peek definition | `plugins/lspsaga.lua` |
| `gd` (normal) | Lspsaga goto definition | `plugins/lspsaga.lua` |
| `<leader>r` (normal) | Lspsaga rename in project | `plugins/lspsaga.lua` |
| `<leader>c` (normal/visual) | Lspsaga code action | `plugins/lspsaga.lua` |
| `<leader>o` (normal) | Lspsaga toggle outline | `plugins/lspsaga.lua` |
| `<leader>v` (normal/terminal) | Lspsaga toggle terminal | `plugins/lspsaga.lua` |
| `<leader>e` (normal) | toggle nvim-tree | `plugins/nvim-tree.lua` |
| `<leader>R` (normal) | replace in workspace | `plugins/grug-far.lua` |
| `w` (normal/operator/visual) | spider motion w | `plugins/spider.lua` |
| `e` (normal/operator/visual) | spider motion e | `plugins/spider.lua` |
| `b` (normal/operator/visual) | spider motion b | `plugins/spider.lua` |
| `s` (normal/visual/operator) | Flash | `plugins/flash.lua` |
| `S` (normal/visual/operator) | Flash Treesitter | `plugins/flash.lua` |
| `r` (operator) | Remote Flash | `plugins/flash.lua` |
| `R` (operator/visual) | Treesitter Search | `plugins/flash.lua` |
| `<C-s>` (command) | Toggle Flash Search | `plugins/flash.lua` |
| `]f` (normal/visual/operator) | goto next function start | `plugins/treesitter-textobjects.lua` |
| `]c` (normal/visual/operator) | goto next class start | `plugins/treesitter-textobjects.lua` |
| `]t` (normal/visual/operator) | goto next class end | `plugins/treesitter-textobjects.lua` |
| `]m` (normal/visual/operator) | goto next function end | `plugins/treesitter-textobjects.lua` |
| `[f` (normal/visual/operator) | goto previous function start | `plugins/treesitter-textobjects.lua` |
| `[c` (normal/visual/operator) | goto previous class start | `plugins/treesitter-textobjects.lua` |
| `[t` (normal/visual/operator) | goto previous class end | `plugins/treesitter-textobjects.lua` |
| `[m` (normal/visual/operator) | goto previous function end | `plugins/treesitter-textobjects.lua` |
| `]d` (normal) | Next todo comment | `plugins/todo.lua` |
| `[d` (normal) | Previous todo comment | `plugins/todo.lua` |
| `<leader>gb` (normal/visual) | Open git blame link | `plugins/gitlinker.lua` |
| `<leader>gg` (normal/visual) | Open git link | `plugins/gitlinker.lua` |
| `<leader>gc` (normal) | search git commits for current buffer | `plugins/fzf.lua` |
| `<A-j>` (normal/visual) | Move line/block down | `plugins/move.lua` |
| `<A-k>` (normal/visual) | Move line/block up | `plugins/move.lua` |
| `<A-h>` (normal/visual) | Move word/horizontal block left | `plugins/move.lua` |
| `<A-l>` (normal/visual) | Move word/horizontal block right | `plugins/move.lua` |

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

## gallery

![neovim](https://github.com/moqsien/neovim_conf/blob/main/imgs/neovim.png)
![telescope](https://github.com/moqsien/neovim_conf/blob/main/imgs/neovim_telescope.png)


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
- [conform.nvim](https://github.com/stevearc/conform.nvim) - Formatting framework
- [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) - LSP configuration with Mason
- [lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim) - Enhanced LSP interface and workflows
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Treesitter integration
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) - Treesitter text objects
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - Highlight and search TODO comments
- [move.nvim](https://github.com/hinell/move.nvim) - Move lines and blocks with Alt+direction keys
- [opencode.nvim](https://github.com/nickjvandyke/opencode.nvim) - AI-powered coding assistant

### Plugin Dependencies

- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Utility library
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) - Web devicons
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Snippet collection
- [mason.nvim](https://github.com/mason-org/mason.nvim) - Package manager
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configurations
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim) - UI component library
- [nvim-notify](https://github.com/rcarriga/nvim-notify) - Notification system
- [snacks.nvim](https://github.com/folke/snacks.nvim) - UI components for Opencode

### Other References

- [awesome neovim](https://github.com/rockerBOO/awesome-neovim)
