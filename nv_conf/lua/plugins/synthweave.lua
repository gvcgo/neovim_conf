return {
	"samharju/synthweave.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000,
	enabled = false,
	config = function()
		vim.cmd.colorscheme("synthweave")
		local synthweave = require("synthweave")
		synthweave.setup({
			transparent = 0.9,
			overrides = {
				-- override any group
				Identifier = { fg = "#f22f52" },
			},
			palette = {
				-- override palette colors, take a peek at synthweave/palette.lua
				bg0 = "#040404",
			},
		})
		synthweave.load()
	end,
}
