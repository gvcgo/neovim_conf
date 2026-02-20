return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	opts = {
		options = {
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},
		extensions = { "nvim-tree" },
		sections = {
			lualine_b = { "branch", "diff" },
			lualine_x = {
				"filesize",
				"encoding",
				"filetype",
			},
		},
	},
	config = function()
		local function get_lspsaga_breadcrumbs()
			return require("lspsaga.symbol.winbar").get_bar()
		end
		require("lualine").setup({
			winbar = {
				lualine_c = { get_lspsaga_breadcrumbs },
			},
		})
	end,
}
