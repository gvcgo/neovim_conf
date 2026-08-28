return {
	"smjonas/inc-rename.nvim",

	keys = {
		{
			"<leader>r",
			function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end,
			expr = true,
			desc = "Rename Symbol",
		},
	},

	opts = {
		input_buffer_type = "snacks",
		post_hook = function()
			vim.cmd("silent! wa")
		end,
		show_message = true,
	},
}
