## Requirements

- [Neovim](https://github.com/neovim/neovim)
- Git
- [Nerd Font](https://github.com/ryanoasis/nerd-fonts)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- curl
- [fd](https://github.com/sharkdp/fd) 
- unzip
- gzip
- tar
- [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md)
- make
- [opencode](https://github.com/anomalyco/opencode)
- [oh-my-opencode](https://github.com/code-yeongyu/oh-my-opencode)
- [superpowers](https://github.com/obra/superpowers/blob/main/docs/README.opencode.md)
- [iflow](https://github.com/iflow-ai/iflow-cli)

## Envs

```bash
# inline completion conf example. Add envs blow to .zshrc or .bashrc
export AI_END_POINT="https://api.longcat.chat/openai/v1/chat/completions"
export AI_API_KEY="xxx"
export AI_MODEL="LongCat-Flash-Lite"
# export AI_MODEL="LongCat-Flash-Chat"
# export AI_MODEL="LongCat-Flash-Thinking"
# export AI_MODEL="LongCat-Flash-Thinking-2601"
```

## Tree-sitter plugins

```bash
:TSInstall lua rust javascript go markdown bash zsh cpp json typescript yaml proto
```

## Key Mappings

- leader = " "

| keys | desc |
|--------|----------|
| `jk` (insert) | Esc |
| `gl` (normal/visual) | goto line end |
| `gh` (normal/visual) | goto line start |
| `ge` (normal/visual) | goto last line |
| `gp` (normal) | got previous buffer |
| `gn` (normal) | goto next buffer |
| `gm` (normal) | goto specified buffer |
| `<leader>y` (normal/visual) | copy to clipboard |
| `<C-a>` (normal) | select all |
| `<C-s>` (normal) | write |
| `<C-x>` (normal) | close current buffer |
| `<leader>a` (normal/visual) | Ask opencode… |
| `<leader>x` (normal/visual) | Execute opencode action… |
| `<leader>.` (normal/terminal) | Toggle opencode |
| `<C-y>` (insert) | minuet ai completion(manually invoke) |
| `<C-l>` (insert) | minuet ai completion(accept) |
| `<C-[>` (insert) | minuet ai completion(previous) |
| `<C-]>` (insert) | minuet ai completion(next) |
| `<leader>t` (normal) | Open todos in telescope |
| `<C-p>` (insert) | minuet ai completion(dismiss) |
| `<leader>f` (normal) | find files |
| `<leader>C` (normal) | find nvim config files |
| `<leader>d` (normal) | Search Diagnostics |
| `<leader>k` (normal) | Search keymaps |
| `<leader>S` (normal) | Search LSP dynamic workspace symbols |
| `<leader>s` (normal) | Search LSP document symbols |
| `K` | Lspsaga: Hover Documentation |
| `gr` (normal) | Lspsaga: LSP Finder (references) |
| `gi` (normal) | Lspsaga: LSP Finder (implementations) |
| `gs` (normal) | Lspsaga: Peek Definition |
| `gd` (normal) | Lspsaga: Goto Definition |
| `gt` (normal) | Lspsaga: Toggle Terminal |
| `<leader>r` (normal) | Lspsaga: Rename in Project |
| `<leader>c` (normal) | Lspsaga: Code Action |
| `<leader>o` (normal) | Lspsaga: Toggle Outline |
| `<leader>e` (normal) | toggle nvim-tree |
| `<leader>R` (normal) | replace in workspace |
| `w` (normal/operator/visual) | spider motion w |
| `e` (normal/operator/visual) | spider motion e |
| `b` (normal/operator/visual) | spider motion b |
| `s` (normal/visual/operator) | Flash |
| `S` (normal/visual/operator) | Flash Treesitter |
| `r` (operator) | Remote Flash |
| `R` (operator/visual) | Treesitter Search |
| `<C-s>` (command) | Toggle Flash Search |
| `ms` (normal) | swap next parameter inner |
| `mS` (normal) | swap previous parameter outer |
| `]f` (normal/visual/operator) | goto next function start |
| `]c` (normal/visual/operator) | goto next class start |
| `]t` (normal/visual/operator) | goto next class end |
| `]m` (normal/visual/operator) | goto next function end |
| `[f` (normal/visual/operator) | goto previous function start |
| `[c` (normal/visual/operator) | goto previous class start |
| `[t` (normal/visual/operator) | goto previous class end |
| `[m` (normal/visual/operator) | goto previous function end |
| `]d` (normal) | Next todo comment |
| `[d` (normal) | Previous todo comment |
| `<leader>gb` (normal/visual) | Open git blame link |
| `<leader>gg` (normal/visual) | Open git link |
| `<leader>gg` (normal/visual) | Open git link |
| `gcc` (normal) | Line-comment toggle |
| `gbc` (normal) | Block-comment toggle |
| `gc` (normal/visual) | Line-comment operator |
| `gb` (normal/visual) | Block-comment operator |
| `gcO` (normal) | Add comment on line above |
| `gco` (normal) | Add comment on line below |
| `gcA` (normal) | Add comment at end of line |
| `<A-j>` (normal/visual) | Move line/block down |
| `<A-k>` (normal/visual) | Move line/block up |
| `<A-h>` (normal/visual) | Move word/horizontal block left |
| `<A-l>` (normal/visual) | Move word/horizontal block right |
| `<leader>ll` (normal/visual) | CopilotChat - explain code |
| `<leader>lt` (normal/visual) | CopilotChat - toggle chat |

## tree-sitter textobjects

| keys | desc |
|--------|----------|
| `af` (visual/operator) | select function outer |
| `if` (visual/operator) | select function inner |
| `ac` (visual/operator) | select class outer |
| `ic` (visual/operator) | select class inner |
| `aa` (visual/operator) | select parameter outer |
| `ia` (visual/operator) | select parameter inner |
| `as` (visual/operator) | select local scope |

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
- [lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim) - LSP UI enhancements
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

