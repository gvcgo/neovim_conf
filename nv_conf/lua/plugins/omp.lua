return {
	{
		"rauls-kjarners/omp.nvim",
		dependencies = {
			"folke/snacks.nvim",
		},
		event = "VeryLazy",
		keys = {
			-- 1. 打开/关闭 omp 终端面板
			{
				"<leader>.",
				function()
					require("snacks.terminal").toggle("omp 'You are a code assistant, writer and viewer.'", {
						win = {
							enter = false,
							position = "right",
							width = 0.4,
						},
					})
				end,
				desc = "Toggle Oh My Pi",
				mode = { "n", "v", "t" },
			},

			-- 2. 从普通 Buffer 跳转到 OMP 终端 (Normal Mode)
			{
				"<C-S-o>",
				function()
					-- 遍历所有窗口，寻找名称包含 "omp" 的终端窗口
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						local buf = vim.api.nvim_win_get_buf(win)
						local buf_name = vim.api.nvim_buf_get_name(buf)

						-- 如果缓冲区是终端，且名称包含 "omp"
						if vim.bo[buf].buftype == "terminal" and buf_name:find("omp") then
							vim.api.nvim_set_current_win(win)
							vim.cmd("startinsert") -- 自动进入插入模式
							return
						end
					end
					vim.notify("未找到 omp 终端窗口", vim.log.levels.warn)
				end,
				desc = "Jump to OMP Terminal",
				mode = "n",
			},

			-- 3. 从 OMP 终端切回普通 Buffer (Terminal Mode)
			{
				"<C-S-o>",
				function()
					local current_win = vim.api.nvim_get_current_win()
					-- 遍历所有窗口，寻找第一个非终端的普通编辑窗口
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						if win ~= current_win then
							local buf = vim.api.nvim_win_get_buf(win)
							if vim.bo[buf].buftype ~= "terminal" then
								vim.api.nvim_set_current_win(win)
								return
							end
						end
					end
					vim.notify("未找到普通编辑窗口", vim.log.levels.WARN)
				end,
				desc = "Jump to Editor Buffer",
				mode = "t", -- 仅在终端输入模式下生效
			},
		},
		config = function()
			require("omp").setup()
		end,
	},
}
