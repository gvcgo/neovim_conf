return {
	"dlyongemallo/diffview-plus.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewFileHistory",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
	},
	event = "VeryLazy",
	keys = {
		{
			"<leader>gd",
			function()
				local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):gsub("\n", "")
				if is_git_repo ~= "true" then
					vim.notify("Current directory is not a Git repository", vim.log.levels.WARN)
					return
				end

				vim.notify("Comparing working tree with HEAD (uncommitted changes only)", vim.log.levels.INFO)
				vim.cmd("DiffviewOpen HEAD")
			end,
			desc = "Diffview: Compare working tree with HEAD (uncommitted changes)",
			mode = "n",
		},
	},
	opts = {
		enhanced_diff_hl = true,
		use_icons = true,

		view = {
			default = {
				layout = "diff2_horizontal",
				disable_diagnostics = true,
			},
		},

		file_panel = {
			listing_style = "list",
			win_config = {
				position = "left",
				width = 40,
			},
			tree_options = {
				flatten_dirs = true,
			},
		},

		watch_index = true,

		keymaps = {
			disable_defaults = false,
			view = {
				{ "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close the diff view" } },
				{ "n", "]b", "]c", { desc = "Jump to next change block (hunk)" } },
				{ "n", "[b", "[c", { desc = "Jump to previous change block (hunk)" } },
				{ "n", "]f", "<Cmd>DiffviewSelectNextEntry<CR>", { desc = "Jump to next file" } },
				{ "n", "[f", "<Cmd>DiffviewSelectPrevEntry<CR>", { desc = "Jump to previous file" } },
				{
					"n",
					"do",
					function()
						vim.cmd("normal! do")
					end,
					{ desc = "Get changes from the other side" },
				},
				{
					"n",
					"dp",
					function()
						vim.cmd("normal! dp")
					end,
					{ desc = "Push changes to the other side" },
				},
				{ "n", "t", "<Cmd>DiffviewCycleLayout<CR>", { desc = "Toggle layout" } },
				{ "n", "gc", "za", { desc = "Toggle fold (compact mode)" } },
				{ "n", "gf", "<Cmd>DiffviewGotoFileEdit<CR>", { desc = "Open file in previous tab" } },
				{ "n", "g?", "<Cmd>DiffviewOpenHelp<CR>", { desc = "Show keybinding help" } },
			},
			file_panel = {
				{ "n", "-", "<Cmd>DiffviewToggleStageEntry<CR>", { desc = "Stage/unstage the current file" } },
				{ "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close the diff view" } },
				{ "n", "]f", "<Cmd>DiffviewSelectNextEntry<CR>", { desc = "Jump to next file" } },
				{ "n", "[f", "<Cmd>DiffviewSelectPrevEntry<CR>", { desc = "Jump to previous file" } },
			},
		},
	},
}
