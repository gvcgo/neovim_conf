local function restart_without_terminals()
	vim.opt.sessionoptions:remove("terminal")
	vim.cmd("restart")
end

vim.keymap.set("n", "<F5>", restart_without_terminals, {
	desc = "restart Neovim and reload all config",
})

require("core.basic")
require("core.keymap")
require("config.lazy")
require("core.treesitter")
