return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	-- event = "VeryLazy",
	lazy = true,
	-- enabled = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
		})
	end,
	keys = {
		{ "<leader>e", ":NvimTreeToggle<CR>", silent = true, desc = "toggle nvim-tree" },
	},
}
