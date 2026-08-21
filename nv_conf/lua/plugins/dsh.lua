return {
	"AlbinZhu/dsh.nvim",
	lazy = false, -- Small plugin; load it directly at startup
	enabled = false,
	keys = {
		-- 2. Jump from a normal buffer to the OMP terminal (Normal Mode)
		{
			"<C-S-o>",
			function()
				-- Iterate all windows to find the terminal window whose name contains "omp"
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					local buf_name = vim.api.nvim_buf_get_name(buf)

					-- If the buffer is a terminal and its name contains "omp"
					if vim.bo[buf].buftype == "terminal" and buf_name:find("dsh") then
						vim.api.nvim_set_current_win(win)
						vim.cmd("startinsert") -- Auto-enter insert mode
						return
					end
				end
				vim.notify("OMP terminal window not found", vim.log.levels.warn)
			end,
			desc = "Jump to OMP Terminal",
			mode = "n",
		},
		-- 3. Switch back from the OMP terminal to a normal buffer (Terminal Mode)
		{
			"<C-S-o>",
			function()
				local current_win = vim.api.nvim_get_current_win()
				-- Iterate all windows to find the first non-terminal regular editing window
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					if win ~= current_win then
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].buftype ~= "terminal" then
							vim.api.nvim_set_current_win(win)
							return
						end
					end
				end
				vim.notify("Regular editor window not found", vim.log.levels.WARN)
			end,
			desc = "Jump to Editor Buffer",
			mode = "t", -- Only active in terminal input mode
		},
	},
	config = function()
		require("dsh").setup({
			dsh_cmd = nil, -- dsh executable; nil = auto-detect (PATH → latest copy under ~/.npm/_npx)
			profile = "headless", -- dsh profile
			launcher_args = {}, -- Extra launcher args, e.g. { "--patch", "/path/x.yml" }
			cwd = "root", -- Working directory: "root" (git root) | "buffer" | "cwd" | absolute path
			timeout_ms = nil, -- Task timeout (ms), nil = unlimited
			include_file_content = true,
			max_inline_file_chars = 20000,
			close_key = "q",
			keymaps = {
				ask = "<leader>aa",
				ask_file = "<leader>af",
				ask_visual = "<leader>av",
				tui = "<leader>tt",
				tui_file = "<leader>tf",
				tui_visual = "<leader>tv",
			},
			tui = {
				profile = "tui", -- Profile that hosts the tianshu TUI
				launcher_args = {}, -- Extra launcher args, e.g. { "--patch", "/path/x.yml" }
				cwd = "root", -- Working directory: "root" | "buffer" | "cwd" | absolute path
				layout = "vsplit", -- Default layout: "float" | "split" | "vsplit" | "tab"
				close_key = "<leader>.", -- Key to close/collapse the window in terminal normal mode
				file_mode = "mention", -- How files are added: "mention" (reference) | "content" (paste full content)
				skip_update = false, -- true = skip the npm version check at startup
				float = {
					relative = "editor",
					width = 0.94, -- Decimals scale by editor size; integers (character columns) also supported
					height = 0.9,
					row = 0.03,
					col = 0.03,
					anchor = "NW",
					border = "rounded",
					title = " dsh-tianshu-tui ",
					title_pos = "center",
					style = "minimal",
					focusable = true,
				},
				split = { position = "below", size = 0.4 }, -- position: "below" | "above"
				vsplit = { position = "right", size = 0.5 }, -- position: "right" | "left"
			},
			window = {
				relative = "editor",
				width = 0.72, -- Decimals scale by editor size; integers (character columns) also supported
				height = 0.5,
				row = 0.25, -- (1 - height) / 2, centering with anchor="NW"
				col = 0.14, -- (1 - width) / 2
				anchor = "NW",
				border = "rounded",
				title = " dsh ",
				title_pos = "center",
				style = "minimal",
				focusable = true,
			},
		})
	end,
}
