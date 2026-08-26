return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged_enable = true,

			signcolumn = true,
			current_line_blame = true,

			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 500,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%R> • <summary>",

			numhl = false,
			linehl = false,

			-- Define keymaps when a buffer is attached
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				-- Helper function for buffer-local keymapping
				local function map(mode, lhs, rhs, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, lhs, rhs, opts)
				end

				-- Navigation: Jump to next/previous hunk using ]e and [e
				-- Falls back to default Vim navigation if native diff mode is active
				map("n", "]e", function()
					if vim.wo.diff then
						return "]e"
					end
					vim.schedule(function()
						gs.next_hunk()
						vim.cmd("normal! zz") -- Auto-center the view after jumping
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Next Git hunk" })

				map("n", "[e", function()
					if vim.wo.diff then
						return "[e"
					end
					vim.schedule(function()
						gs.prev_hunk()
						vim.cmd("normal! zz") -- Auto-center the view after jumping
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Previous Git hunk" })

				-- (Optional) Uncomment these if you want quick actions for the current hunk
				-- map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
				-- map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
				-- map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
			end,
		})
	end,
}
