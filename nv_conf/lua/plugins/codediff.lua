return {
	"esmuellert/codediff.nvim",
	cmd = "CodeDiff",
	event = "VeryLazy",
	keys = {
		{
			"<leader>gd", -- Keybinding to trigger the diff
			function()
				-- 1. Check whether we are inside a Git repository to avoid errors
				local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):gsub("\n", "")
				if is_git_repo ~= "true" then
					vim.notify("Current directory is not a Git repository", vim.log.levels.WARN)
					return
				end

				-- 2. Notify the user of the operation being performed
				vim.notify("Comparing working tree with HEAD (uncommitted changes only)", vim.log.levels.INFO)

				-- 3. Execute the Diff command
				-- Compare the current buffer's working tree (staged + unstaged changes)
				-- against the latest commit of the current branch (HEAD).
				-- This perfectly matches the requirement: "only uncommitted changes in the current branch".
				vim.cmd("CodeDiff HEAD")
			end,
			desc = "CodeDiff: Compare working tree with HEAD (uncommitted changes)",
			mode = "n", -- Only active in Normal mode
		},
	},
	opts = {
		-- 1. Highlight configuration (auto-adapts to your current theme's dark/light background)
		highlights = {
			line_insert = "DiffAdd", -- Line-level insertion highlight
			line_delete = "DiffDelete", -- Line-level deletion highlight
			char_insert = nil, -- Character-level insertion (nil = auto-compute brightness)
			char_delete = nil, -- Character-level deletion (nil = auto-compute brightness)
			-- Note: moved code highlights are also supported by codediff if you want to enable them
		},

		-- 2. Diff view behavior
		diff = {
			layout = "side-by-side", -- Default layout: "side-by-side" or "inline"
			filler_text = "╱", -- Filler character for blank alignment lines
			disable_inlay_hints = true, -- Disable inlay hints in the diff window to keep UI clean
			original_position = "left", -- Position of the original (HEAD) content: "left" or "right"
			jump_to_first_change = true, -- Auto-jump to the first change when opening the diff
			compact = false, -- Whether to enable compact mode by default (auto-fold unchanged regions)
			cycle_next_hunk = true, -- Whether ]b/[b wraps around at the end of the file
		},

		-- 3. Explorer panel configuration
		explorer = {
			position = "left", -- Panel position: "left" or "bottom"
			hidden = false, -- Whether to hide the panel initially
			width = 40, -- Left panel width
			height = 15, -- Bottom panel height
			auto_refresh = true, -- Auto-refresh the file list on focus change or git status change
			view_mode = "list", -- View mode: "list" or "tree"
			indent_markers = true, -- Show indent guide lines in tree view
		},

		-- 4. Keymap configuration (kept your custom ]b / [b mappings)
		keymaps = {
			view = {
				quit = "q", -- Close the diff tab
				next_hunk = "]b", -- Jump to the next change block (hunk)
				prev_hunk = "[b", -- Jump to the previous change block
				next_file = "]f", -- Jump to the next file (in explorer mode)
				prev_file = "[f", -- Jump to the previous file (in explorer mode)
				diff_get = "do", -- Get changes from the other side (like native vimdiff)
				diff_put = "dp", -- Push current changes to the other side (like native vimdiff)
				toggle_layout = "t", -- Toggle between side-by-side / inline layout
				toggle_compact = "gc", -- Toggle compact mode (fold/unfold unchanged regions)
				toggle_stage = "-", -- Stage/unstage the current file
				open_in_prev_tab = "gf", -- Jump back to the real editable buffer in the previous tab
				show_help = "g?", -- Show the keybinding help floating window
			},
		},
	},
}
