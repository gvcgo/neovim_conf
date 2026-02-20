vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "rust", "javascript", "go", "markdown" },
	callback = function()
		vim.treesitter.start()
	end,
})
