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
		require("telescope").setup({
			pickers = {
				find_files = {
					no_ignore = true,
					hidden = false,
				},
				live_grep = {
					additional_args = function(_)
						return { "--no-ignore", "--hidden" }
					end,
				},
			},
		})

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>f", function()
			builtin.find_files({})
		end, { desc = "find files" })

		vim.keymap.set("n", "<leader>C", function()
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
		end, { desc = "Search workspace symbols" })

		vim.keymap.set("n", "<leader>s", function()
			builtin.lsp_document_symbols()
		end, { desc = "Search document symbols" })

		vim.keymap.set("n", "<leader>/", function()
			builtin.live_grep()
		end, { desc = "Search string" })
	end,
}
