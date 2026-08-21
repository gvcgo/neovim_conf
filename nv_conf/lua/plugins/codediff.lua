return {
	"esmuellert/codediff.nvim",
	cmd = "CodeDiff",
	event = "VeryLazy",
	keys = {
		{
			"<leader>gd", -- You can change this keybinding to suit your habits, e.g. "<leader>cd" or "gd"
			function()
				-- 1. Check whether we are inside a Git repository to avoid errors
				local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):gsub("\n", "")
				if is_git_repo ~= "true" then
					vim.notify("Current directory is not a Git repository", vim.log.levels.WARN)
					return
				end

				-- 2. Intelligently detect the main branch name
				local main_branch = "main" -- Default fallback value

				-- Try to get the default branch of remote origin first (e.g. origin/main or origin/master)
				local remote_head =
					vim.fn.system("git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null"):gsub("\n", "")
				if remote_head ~= "" and remote_head ~= "refs/remotes/origin/HEAD" then
					main_branch = remote_head:gsub("^origin/", "")
				-- If remote detection fails, check whether a local "main" branch exists
				elseif vim.fn.system("git show-ref --verify --quiet refs/heads/main") == 0 then
					main_branch = "main"
				-- Finally check whether a local "master" branch exists
				elseif vim.fn.system("git show-ref --verify --quiet refs/heads/master") == 0 then
					main_branch = "master"
				end

				-- 3. Notify the user of the operation being performed
				vim.notify("Comparing current branch with: " .. main_branch, vim.log.levels.INFO)

				-- 4. Execute the Diff command
				-- [Mode A] Compare the current workspace (including your uncommitted changes) with the main branch (most common)
				vim.cmd("CodeDiff " .. main_branch)

				-- [Mode B] If you only want to compare the clean code of two branches (ignoring local uncommitted changes),
				-- comment out the line above and uncomment the line below:
				-- vim.cmd("CodeDiff HEAD " .. main_branch)
			end,
			desc = "CodeDiff: Compare with main/master branch",
			mode = "n", -- Only active in Normal mode
		},
	},
	opts = {
		-- 1. Highlight configuration (usually keep the defaults; the plugin auto-adapts to your current theme's dark/light background)
		highlights = {
			line_insert = "DiffAdd", -- Line-level insertion highlight
			line_delete = "DiffDelete", -- Line-level deletion highlight
			char_insert = nil, -- Character-level insertion (nil = auto-compute brightness based on background color)
			char_delete = nil, -- Character-level deletion (nil = auto-compute brightness based on background color)
		},

		-- 2. Diff view behavior
		diff = {
			layout = "side-by-side", -- Default layout: "side-by-side" (left/right split) or "inline" (single-window inline)
			filler_text = "╱", -- Filler character for blank alignment lines; set to "" (pure blank) if you prefer
			disable_inlay_hints = true, -- Disable inlay hints in the diff window to keep the UI clean
			original_position = "left", -- Position of the original (old) content: "left" or "right"
			jump_to_first_change = true, -- Auto-jump to the first change when opening the diff
			compact = false, -- Whether to enable compact mode by default (auto-fold unchanged regions)
			cycle_next_hunk = true, -- Whether ]c/[c wraps around at the end of the file
		},

		-- 3. Explorer panel configuration
		explorer = {
			position = "left", -- Panel position: "left" (left side) or "bottom" (bottom)
			hidden = false, -- Whether to hide the panel initially
			width = 40, -- Left panel width
			height = 15, -- Bottom panel height
			auto_refresh = true, -- Auto-refresh the file list on focus change or git status change
			view_mode = "list", -- View mode: "list" or "tree" (directory tree)
			indent_markers = true, -- Show indent guide lines (│, ├, └) in tree view
		},

		-- 4. Keymap configuration (you can change these to suit your muscle memory)
		keymaps = {
			view = {
				quit = "q", -- Close the diff tab
				next_hunk = "]b", -- Jump to the next change block (hunk)
				prev_hunk = "[b", -- Jump to the previous change block
				next_file = "]f", -- Jump to the next file
				prev_file = "[f", -- Jump to the previous file
				diff_get = "do", -- Get changes from the other side (like native vimdiff)
				diff_put = "dp", -- Push current changes to the other side (like native vimdiff)
				toggle_layout = "t", -- Toggle between side-by-side / inline layout
				toggle_compact = "gc", -- Toggle compact mode (fold/unfold unchanged regions)
				toggle_stage = "-", -- Stage/unstage the current file
				show_help = "g?", -- Show the keybinding help floating window
			},
		},
	},
}
