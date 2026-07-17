local parsers = {
	"lua",
	"rust",
	"javascript",
	"go",
	"comment",
	"markdown",
	"bash",
	"zsh",
	"cpp",
	"json",
	"typescript",
	"yaml",
	"proto",
}

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install(parsers)
	end,
}
