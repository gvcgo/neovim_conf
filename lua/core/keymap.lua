vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "Esc" })
-- vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "cancel search highlight" })
vim.keymap.set({ "n", "v" }, "gl", "$", { desc = "goto line end" })
vim.keymap.set({ "n", "v" }, "gh", "^", { desc = "goto line start" })
vim.keymap.set({ "n", "v" }, "ge", "G", { desc = "goto last line" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "copy to clipboard" })
vim.keymap.set("n", "<leader>y", '"+yy', { desc = "copy to clipboard" })
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "select all" })
vim.keymap.set("n", "<C-s>", ":w!<CR>", { desc = "write" })
vim.keymap.set("n", "<leader>lr", "<cmd>lsp restart<CR>", { desc = "restart lsp" })
vim.keymap.set("n", "gj", "Lzz", { desc = "goto screen bottom" })
vim.keymap.set("n", "gk", "Hzz", { desc = "goto screen top" })

vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment block" })
