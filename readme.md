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
| `<leader>x` (normal/visual) | Execute opencode action… | `plugins/opencode.lua` |
| `<leader>.` (normal/terminal) | Toggle opencode | `plugins/opencode.lua` |
| `<C-y>` (insert) | minuet ai completion(manually invoke) | `plugins/ai.lua` |
| `<C-l>` (insert) | minuet ai completion(accept) | `plugins/ai.lua` |
| `<C-[>` (insert) | minuet ai completion(previous) | `plugins/ai.lua` |
| `<C-]>` (insert) | minuet ai completion(next) | `plugins/ai.lua` |
| `<leader>t` (normal) | Open todos in telescope | `plugins/todo.lua` |
| `<C-p>` (insert) | minuet ai completion(dismiss) | `plugins/ai.lua` |
| `<leader>f` (normal) | find files | `plugins/fzf.lua` |
| `<leader>C` (normal) | find nvim config files | `plugins/fzf.lua` |
| `<leader>d` (normal) | Search Diagnostics | `plugins/fzf.lua` |
| `<leader>k` (normal) | Search keymaps | `plugins/fzf.lua` |
| `<leader>S` (normal) | Search LSP dynamic workspace symbols | `plugins/fzf.lua` |
| `<leader>s` (normal) | Search LSP document symbols | `plugins/fzf.lua` |
| `<leader>/` (normal) | Search string (live grep) | `plugins/fzf.lua` |
| `K` (normal) | LspUI: Hover Documentation | `plugins/lspui.lua` |
| `gr` (normal) | LspUI: LSP Finder (references) | `plugins/lspui.lua` |
| `gi` (normal) | LspUI: LSP Finder (implementations) | `plugins/lspui.lua` |
| `gs` (normal) | LspUI: Peek Definition | `plugins/lspui.lua` |
| `gd` (normal) | LspUI: Goto Definition | `plugins/lspui.lua` |
| `<leader>lr` (normal) | restart lsp | `core/keymap.lua` |
| `<leader>r` (normal) | LspUI: Rename in Project | `plugins/lspui.lua` |
| `<leader>c` (normal) | LspUI: Code Action | `plugins/lspui.lua` |
| `<leader>jh` (normal) | LspUI: Jump History | `plugins/lspui.lua` |
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
| `ms` (normal) | swap next parameter inner | `plugins/treesitter-textobjects.lua` |
| `mS` (normal) | swap previous parameter outer | `plugins/treesitter-textobjects.lua` |
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
| `gcc` (normal) | Line-comment toggle | `plugins/comment.lua` |
| `gbc` (normal) | Block-comment toggle | `plugins/comment.lua` |
| `gc` (normal/visual) | Line-comment operator | `plugins/comment.lua` |
| `gb` (normal/visual) | Block-comment operator | `plugins/comment.lua` |
| `gcO` (normal) | Add comment on line above | `plugins/comment.lua` |
| `gco` (normal) | Add comment on line below | `plugins/comment.lua` |
| `gcA` (normal) | Add comment at end of line | `plugins/comment.lua` |
| `<A-j>` (normal/visual) | Move line/block down | `plugins/move.lua` |
| `<A-k>` (normal/visual) | Move line/block up | `plugins/move.lua` |
| `<A-h>` (normal/visual) | Move word/horizontal block left | `plugins/move.lua` |
| `<A-l>` (normal/visual) | Move word/horizontal block right | `plugins/move.lua` |
| `<leader>ll` (normal/visual) | CopilotChat - explain code | `plugins/copilot_chat.lua` |
| `<leader>lt` (normal/visual) | CopilotChat - toggle chat | `plugins/copilot_chat.lua` |

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
| `ii` (operator) | select subword inner | `plugins/textobjs.lua` |
| `as` (operator) | select subword outter | `plugins/textobjs.lua` |

## gallery

![neovim](https://github.com/moqsien/neovim_conf/blob/main/imgs/neovim.png)
![telescope](https://github.com/moqsien/neovim_conf/blob/main/imgs/neovim_telescope.png)


## references

### Neovim Plugins

- [minuet-ai.nvim](https://github.com/milanglacier/minuet-ai.nvim) - AI completion for Neovim
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Autopairs for Neovim
- [blink.cmp](https://github.com/saghen/blink.cmp) - Fast completion engine
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - Buffer line/tabline
- [conform.nvim](https://github.com/stevearc/conform.nvim) - Formatting framework
- [Comment.nvim](https://github.com/numToStr/Comment.nvim) - Comment plugin for Neovim
- [everforest-nvim](https://github.com/neanias/everforest-nvim) - Everforest colorscheme
- [nekonight.nvim](https://github.com/neko-night/nvim) - Vibrant color scheme with multiple variants for Neovim
- [flash.nvim](https://github.com/folke/flash.nvim) - Lightning-fast motions
- [synthweave.nvim](https://github.com/samharju/synthweave.nvim) - Synthwave '84 colorscheme port for Neovim
- [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) - Find and replace across workspace
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) - Indent line visualization
- [LspUI.nvim](https://github.com/jinzhongjia/LspUI.nvim) - LSP UI enhancements
- [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) - LSP configuration with Mason
- [noice.nvim](https://github.com/folke/noice.nvim) - UI enhancements and command history
- [copilot.lua](https://github.com/zbirenbaum/copilot.lua) - GitHub Copilot plugin(for login only)
- [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) - AI chat interface for GitHub Copilot
- [opencode.nvim](https://github.com/nickjvandyke/opencode.nvim) - AI-powered coding assistant
- [nvim-spider](https://github.com/chrisgrieser/nvim-spider) - Enhanced word motion
- [nvim-surround](https://github.com/kylechui/nvim-surround) - Surround text objects
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) - Treesitter text objects
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Treesitter integration
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - Highlight and search TODO comments
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) - File explorer
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Statusline
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git integration with signs
- [gitlinker.nvim](https://github.com/linrongbin16/gitlinker.nvim) - Generate shareable links to code on GitHub, GitLab, etc.
- [move.nvim](https://github.com/hinell/move.nvim) - Move lines and blocks with Alt+direction keys
- [garbage-day.nvim](https://github.com/Zeioth/garbage-day.nvim) - Garbage collector that stops inactive LSP clients to free RAM
- [nvim-various-textobjs](https://github.com/chrisgrieser/nvim-various-textobjs) - Bundle of more than 30 new text objects for Neovim
- [fzf-lua](https://github.com/ibhagwan/fzf-lua) - Improved fzf.vim written in lua

### Plugin Dependencies

- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Utility library
- [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) - FZF native extension for Telescope
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Utility library (dependency for CopilotChat)
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) - Web devicons
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Snippet collection
- [mason.nvim](https://github.com/mason-org/mason.nvim) - Package manager
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configurations
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim) - UI component library
- [nvim-notify](https://github.com/rcarriga/nvim-notify) - Notification system
- [snacks.nvim](https://github.com/folke/snacks.nvim) - UI components for Opencode

### Other References

- [awesome neovim](https://github.com/rockerBOO/awesome-neovim)
