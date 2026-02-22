return {
	"nvimdev/lspsaga.nvim",
	event = "BufReadPre",
	config = function()
		require("lspsaga").setup({
			symbol_in_winbar = {
				enable = false,
			},
			lightbulb = {
				enable = false,
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	keys = {
		{ "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Lspsaga: Hover Documentation" },
		{ "gr", "<cmd>Lspsaga finder<CR>", desc = "Lspsaga: LSP Finder" },
		{ "gi", "<cmd>Lspsaga finder imp<CR>", desc = "Lspsaga: LSP Finder" },
		{ "gs", "<cmd>Lspsaga peek_definition<CR>", desc = "Lspsaga: Peek Definition" },
		{ "gd", "<cmd>Lspsaga goto_definition<CR>", desc = "Lspsaga: Goto Definition" },

		-- { "<leader>D", "<cmd>Lspsaga show_workspace_diagnostics<CR>", desc = "Lspsaga: Show workspace diagnostics" },
		{ "<leader>r", "<cmd>Lspsaga rename ++project<CR>", desc = "Lspsaga: Rename in Project" },
		{ "<leader>c", "<cmd>Lspsaga code_action<CR>", mode = { "n", "v" }, desc = "Lspsaga: Code Action" },
		{ "<leader>o", "<cmd>Lspsaga outline<CR>", desc = "Lspsaga: Toggle Outline" },

		{ "gt", "<cmd>Lspsaga term_toggle<CR>", mode = { "n", "t" }, desc = "Lspsaga: Toggle Terminal" },
	},
}
