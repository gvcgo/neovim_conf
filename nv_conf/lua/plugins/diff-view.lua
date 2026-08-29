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
	config = function(_, opts)
		-- Swap sides: put the newer side ("b" = working tree) on the left,
		-- older side ("a" = HEAD) on the right. `diff2_horizontal` hardcodes
		-- "a" left / "b" right, so override its window-creation order.
		local diffview = require("diffview") -- bootstrap: sets up DiffviewGlobal
		local async = require("diffview.async")
		local Diff2Hor = require("diffview.scene.layouts.diff_2_hor").Diff2Hor
		Diff2Hor.create = async.void(function(self, pivot)
			async.await(self:create_wins(pivot, {
				{ "b", "aboveleft vsp" },
				{ "a", "aboveleft vsp" },
			}, { "b", "a" }))
		end)
		diffview.setup(opts)
	end,
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
				{ "n", "<leader>h", "<C-w>h", { desc = "Focus left diff view" } },
				{ "n", "<leader>l", "<C-w>l", { desc = "Focus right diff view" } },
				{ "n", "]e", "]c", { desc = "Jump to next change block (hunk)" } },
				{ "n", "[e", "[c", { desc = "Jump to previous change block (hunk)" } },
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
				{
					"n",
					"gf",
					function()
						require("diffview.actions").goto_file_edit_close()
					end,
					{ desc = "Open file in previous tab and close diffview" },
				},
				{ "n", "g?", "<Cmd>DiffviewOpenHelp<CR>", { desc = "Show keybinding help" } },
			},
			file_panel = {
				{
					"n",
					"gf",
					function()
						require("diffview.actions").goto_file_edit_close()
					end,
					{ desc = "Open file in previous tab and close diffview" },
				},
				{ "n", "<leader>h", "<C-w>h", { desc = "Focus left diff view" } },
				{ "n", "<leader>l", "<C-w>l", { desc = "Focus right diff view" } },
				{ "n", "-", "<Cmd>DiffviewToggleStageEntry<CR>", { desc = "Stage/unstage the current file" } },
				{ "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close the diff view" } },
				{ "n", "]f", "<Cmd>DiffviewSelectNextEntry<CR>", { desc = "Jump to next file" } },
				{ "n", "[f", "<Cmd>DiffviewSelectPrevEntry<CR>", { desc = "Jump to previous file" } },
			},
		},
	},
}
