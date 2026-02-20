return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- optional but recommended
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		-- require("telescope").setup({
		-- 	pickers = {
		-- 		find_files = {
		-- 			theme = "dropdown",
		-- 		},
		-- 	},
		-- })

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>f", function()
			builtin.find_files({})
		end, { desc = "find files" })

		vim.keymap.set("n", "<leader>c", function()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end, { desc = "find nvim config files" })

		vim.keymap.set("n", "<leader>d", function()
			builtin.diagnostics({
				severity_limit = vim.diagnostic.severity.WARN,
			})
		end, { desc = "Search Diagnostics" })

		vim.keymap.set("n", "<leader>k", function()
			builtin.keymaps()
		end, { desc = "Search keymaps" })

		vim.keymap.set("n", "<leader>S", function()
			builtin.lsp_dynamic_workspace_symbols()
		end, { desc = "Search keymaps" })

		vim.keymap.set("n", "<leader>s", function()
			builtin.lsp_document_symbols()
		end, { desc = "Search keymaps" })
	end,
}
