vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"lua",
		"rust",
		"javascript",
		"go",
		"markdown",
		"bash",
		"json",
		"typescript",
		"yaml",
		"proto",
	},
	callback = function()
		vim.treesitter.start()
	end,
})
