return {
	"esmuellert/codediff.nvim",
	cmd = "CodeDiff",
	event = "VeryLazy",
	keys = {
		{
			"<leader>gd", -- 你可以根据习惯修改快捷键，例如 "<leader>cd" 或 "gd"
			function()
				-- 1. 检查当前是否在 Git 仓库中，避免报错
				local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):gsub("\n", "")
				if is_git_repo ~= "true" then
					vim.notify("当前目录不是 Git 仓库", vim.log.levels.WARN)
					return
				end

				-- 2. 智能探测主分支名称
				local main_branch = "main" -- 默认兜底值

				-- 优先尝试获取远程 origin 的默认分支 (例如 origin/main 或 origin/master)
				local remote_head =
					vim.fn.system("git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null"):gsub("\n", "")
				if remote_head ~= "" and remote_head ~= "refs/remotes/origin/HEAD" then
					main_branch = remote_head:gsub("^origin/", "")
				-- 如果远程获取失败，检查本地是否存在 main
				elseif vim.fn.system("git show-ref --verify --quiet refs/heads/main") == 0 then
					main_branch = "main"
				-- 最后检查本地是否存在 master
				elseif vim.fn.system("git show-ref --verify --quiet refs/heads/master") == 0 then
					main_branch = "master"
				end

				-- 3. 提示用户正在执行的操作
				vim.notify("正在对比当前分支与: " .. main_branch, vim.log.levels.INFO)

				-- 4. 执行 Diff 命令
				-- 【模式 A】对比当前工作区（包含你未提交的修改）与 主分支 (最常用)
				vim.cmd("CodeDiff " .. main_branch)

				-- 【模式 B】如果你只想对比两个分支的纯净代码（忽略本地未提交的修改），
				-- 请注释掉上面一行，取消注释下面这一行：
				-- vim.cmd("CodeDiff HEAD " .. main_branch)
			end,
			desc = "CodeDiff: Compare with main/master branch",
			mode = "n", -- 仅在普通模式(Normal mode)下生效
		},
	},
	opts = {
		-- 1. 高亮配置 (通常保持默认即可，插件会自动适配你当前主题的深色/浅色背景)
		highlights = {
			line_insert = "DiffAdd", -- 行级插入高亮
			line_delete = "DiffDelete", -- 行级删除高亮
			char_insert = nil, -- 字符级插入 (nil = 自动根据背景色计算亮度)
			char_delete = nil, -- 字符级删除 (nil = 自动根据背景色计算亮度)
		},

		-- 2. Diff 视图行为
		diff = {
			layout = "side-by-side", -- 默认布局: "side-by-side" (左右分栏) 或 "inline" (单窗口内联)
			filler_text = "╱", -- 空白对齐行的填充字符，如果不喜欢可以设为 "" (纯空白)
			disable_inlay_hints = true, -- 在 diff 窗口中禁用 inlay hints，保持界面整洁
			original_position = "left", -- 原始(旧)内容的位置: "left" 或 "right"
			jump_to_first_change = true, -- 打开 diff 时自动跳转到第一个变更处
			compact = false, -- 默认是否开启紧凑模式（自动折叠未更改的区域）
			cycle_next_hunk = true, -- 使用 ]c/[c 时是否在文件末尾循环到开头
		},

		-- 3. 资源管理器 (Explorer) 面板配置
		explorer = {
			position = "left", -- 面板位置: "left" (左侧) 或 "bottom" (底部)
			hidden = false, -- 初始是否隐藏面板
			width = 40, -- 左侧面板宽度
			height = 15, -- 底部面板高度
			auto_refresh = true, -- 焦点切换或 git 状态改变时自动刷新文件列表
			view_mode = "list", -- 视图模式: "list" (列表) 或 "tree" (树形目录)
			indent_markers = true, -- 在树形视图中显示缩进连线 (│, ├, └)
		},

		-- 4. 快捷键映射 (可根据你的肌肉记忆修改)
		keymaps = {
			view = {
				quit = "q", -- 关闭 diff 标签页
				next_hunk = "]b", -- 跳转到下一个变更块 (hunk)
				prev_hunk = "[b", -- 跳转到上一个变更块
				next_file = "]f", -- 跳转到下一个文件
				prev_file = "[f", -- 跳转到上一个文件
				diff_get = "do", -- 从另一侧获取变更 (类似原生 vimdiff)
				diff_put = "dp", -- 将当前变更推送到另一侧 (类似原生 vimdiff)
				toggle_layout = "t", -- 动态切换 左右分栏 / 内联 布局
				toggle_compact = "gc", -- 切换紧凑模式 (折叠/展开未更改区域)
				toggle_stage = "-", -- 暂存/取消暂存当前文件
				show_help = "g?", -- 显示快捷键帮助浮窗
			},
		},
	},
}
