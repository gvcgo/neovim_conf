return {
	"AlbinZhu/dsh.nvim",
	lazy = false, -- 插件很小，直接启动加载即可
	enabled = false,
	keys = {
		-- 2. 从普通 Buffer 跳转到 OMP 终端 (Normal Mode)
		{
			"<C-S-o>",
			function()
				-- 遍历所有窗口，寻找名称包含 "omp" 的终端窗口
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					local buf_name = vim.api.nvim_buf_get_name(buf)

					-- 如果缓冲区是终端，且名称包含 "omp"
					if vim.bo[buf].buftype == "terminal" and buf_name:find("dsh") then
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
		require("dsh").setup({
			dsh_cmd = nil, -- dsh 可执行文件；nil = 自动探测（PATH → ~/.npm/_npx 最新副本）
			profile = "headless", -- dsh profile
			launcher_args = {}, -- 额外的启动器参数，例如 { "--patch", "/path/x.yml" }
			cwd = "root", -- 运行目录："root"(git 根) | "buffer" | "cwd" | 绝对路径
			timeout_ms = nil, -- 任务超时（毫秒），nil = 不限
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
				profile = "tui", -- tianshu TUI 所在的 profile
				launcher_args = {}, -- 额外的启动器参数，例如 { "--patch", "/path/x.yml" }
				cwd = "root", -- 运行目录："root" | "buffer" | "cwd" | 绝对路径
				layout = "vsplit", -- 默认布局："float" | "split" | "vsplit" | "tab"
				close_key = "<leader>.", -- 终端 normal 模式下关闭/收起窗口的按键
				file_mode = "mention", -- 添加文件方式："mention"(引用) | "content"(粘贴全文)
				skip_update = false, -- true = 跳过启动时的 npm 版本检查
				float = {
					relative = "editor",
					width = 0.94, -- 小数按编辑器尺寸换算；也支持整数（字符列）
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
				width = 0.72, -- 小数按编辑器尺寸换算；也支持整数（字符列）
				height = 0.5,
				row = 0.25, -- (1 - height) / 2，配合 anchor="NW" 居中
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
