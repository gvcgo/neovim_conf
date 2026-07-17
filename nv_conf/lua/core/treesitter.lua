vim.api.nvim_create_autocmd("FileType", {
	pattern = {
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
		"comment",
	},
	callback = function(args)
		-- vim.treesitter.start()
		pcall(vim.treesitter.start, args.buf)
	end,
})
