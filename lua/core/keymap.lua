vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "Esc" })
-- vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "cancel search highlight" })
vim.keymap.set({ "n", "v" }, "gl", "$", { desc = "goto line end" })
vim.keymap.set({ "n", "v" }, "gh", "^", { desc = "goto line start" })
vim.keymap.set({ "n", "v" }, "ge", "G", { desc = "goto last line" })
vim.keymap.set("v", "gy", '"+y', { desc = "copy to clipboard" })
vim.keymap.set("n", "gy", '"+yy', { desc = "copy to clipboard" })
