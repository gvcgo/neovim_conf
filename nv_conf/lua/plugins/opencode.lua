return {
	"nickjvandyke/opencode.nvim",
	version = "*", -- Latest stable release
	enabled = false,
	dependencies = {
		"folke/snacks.nvim",
	},
	config = function()
		local opencode_cmd = "opencode --port"
		local snacks_terminal_opts = {
			win = {
				position = "right",
				enter = false,
			},
		}
		vim.g.opencode_opts = {
			server = {
				start = function()
					require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
				end,
			},
		}

		-- Can also leverage toggle functionality.
		-- If you use <leader> here, remove 't' — otherwise Neovim will add input delay to your <leader> when typing in the terminal to watch for the mapping.
		vim.keymap.set({ "n", "t" }, "<leader>.", function()
			require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
		end, { desc = "Toggle OpenCode" })

		-- Optionally show upon submitting prompt
		vim.api.nvim_create_autocmd("User", {
			pattern = { "OpencodeEvent:tui.command.execute" },
			callback = function(args)
				local event = args.data.event
				if event.properties.command == "prompt.submit" then
					local win = require("snacks.terminal").get(opencode_cmd, { create = false })
					if win then
						win:show()
					end
				end
			end,
		})

		vim.o.autoread = true -- Required for `vim.g.opencode_opts.events.reload`

		-- Recommended/example keymaps
		vim.keymap.set({ "n", "x" }, "<leader>a", function()
			require("opencode").ask("@this: ")
		end, { desc = "Ask OpenCode…" })
		vim.keymap.set({ "n", "x" }, "<leader>b", function()
			require("opencode").select()
		end, { desc = "Select OpenCode…" })

		vim.keymap.set({ "n", "x" }, "<leader>h", function()
			return require("opencode").operator("@this ")
		end, { desc = "Append range to OpenCode", expr = true })
		vim.keymap.set("n", "<leader>l", function()
			return require("opencode").operator("@this ") .. "_"
		end, { desc = "Append line to OpenCode", expr = true })

		vim.keymap.set({ "n", "t" }, "<A-u>", function()
			require("opencode").command("session.half.page.up")
		end, { desc = "Scroll OpenCode up" })
		vim.keymap.set({ "n", "t" }, "<A-d>", function()
			require("opencode").command("session.half.page.down")
		end, { desc = "Scroll OpenCode down" })

		-- 在代码 buffer 和 OpenCode 终端之间切换焦点
		vim.keymap.set({ "n", "t" }, "<S-C-o>", function()
			-- 获取当前已打开的 OpenCode 终端实例（如果未创建则不操作）
			local win = require("snacks.terminal").get(opencode_cmd, { create = false })

			if win and win.win and vim.api.nvim_win_is_valid(win.win) then
				if vim.api.nvim_get_current_win() == win.win then
					-- 1. 如果当前光标在 OpenCode 窗口内，切回上一个窗口（代码 buffer）
					if vim.fn.mode() == "t" then
						-- 退出终端插入模式，确保可以正常执行窗口跳转
						vim.cmd("stopinsert")
					end
					vim.cmd("wincmd p")
				else
					-- 2. 如果当前光标在代码 buffer 内，跳转到 OpenCode 窗口
					vim.api.nvim_set_current_win(win.win)
					-- 自动进入终端插入模式，方便你直接开始打字交流
					vim.cmd("startinsert")
				end
			end
		end, { desc = "Focus OpenCode Terminal" })
	end,
}
