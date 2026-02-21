## Requirements
- Neovim
- Git
- Nerd Font
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- curl
- [fd](https://github.com/sharkdp/fd) 
- unzip
- gzip
- tar
- [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md)
- make
- [opencode](https://github.com/anomalyco/opencode)

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
| `gb` (normal) | goto specified buffer |
| `gy` (normal/visual) | copy to clipboard |
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

## gallery
![neovim](https://github.com/moqsien/neovim_conf/blob/main/imgs/neovim.png)
![telescope](https://github.com/moqsien/neovim_conf/blob/main/imgs/neovim_telescope.png)

