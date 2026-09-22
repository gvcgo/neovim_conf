vim.keymap.set("n", "<F5>", "<cmd>restart<CR>", {
	desc = "restart Neovim and reload all config",
})

require("core.basic")
require("core.keymap")
require("config.lazy")
require("core.treesitter")
