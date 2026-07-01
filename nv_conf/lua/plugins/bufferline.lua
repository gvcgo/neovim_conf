return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {},
	keys = {
		{ "gp", ":BufferLineCyclePrev<CR>", silent = true, desc = "got previous buffer" },
		{ "gn", ":BufferLineCycleNext<CR>", silent = true, desc = "goto next buffer" },
		{ "gm", ":BufferLinePick<CR>", silent = true, desc = "goto specified buffer" },
		{ "<C-x>", ":bdelete<CR>", silent = true, desc = "close current buffer" },
	},
	lazy = false,
}
