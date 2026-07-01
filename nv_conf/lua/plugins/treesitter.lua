return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	ensure_installed = {
		"lua",
		"rust",
		"javascript",
		"go",
		"markdown",
		"bash",
		"zsh",
		"cpp",
		"json",
		"typescript",
		"yaml",
		"proto",
	},
	build = ":TSUpdate",
	opts = {
		highlight = { enable = true },
	},
}
