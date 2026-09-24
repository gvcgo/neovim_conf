return {
	"gvcgo/uni-app.nvim",
	event = "VeryLazy",
	opts = {
		auto_lsp = true,
		auto_snippets = false,
		auto_commands = true,
		conditional_highlight = true,
		terminal = "split",
	},

	dependencies = {
		"neovim/nvim-lspconfig",
		"L3MON4D3/LuaSnip",
	},

	config = function()
		require("uni-app").setup()
	end,
}
