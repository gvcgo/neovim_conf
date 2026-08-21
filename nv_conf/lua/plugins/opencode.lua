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

		-- Toggle focus between the code buffer and the OpenCode terminal
		vim.keymap.set({ "n", "t" }, "<S-C-o>", function()
			-- Get the currently open OpenCode terminal instance (no-op if not created)
			local win = require("snacks.terminal").get(opencode_cmd, { create = false })

			if win and win.win and vim.api.nvim_win_is_valid(win.win) then
				if vim.api.nvim_get_current_win() == win.win then
					-- 1. If the cursor is inside the OpenCode window, switch back to the previous window (code buffer)
					if vim.fn.mode() == "t" then
						-- Exit terminal insert mode so window navigation works correctly
						vim.cmd("stopinsert")
					end
					vim.cmd("wincmd p")
				else
					-- 2. If the cursor is inside the code buffer, jump to the OpenCode window
					vim.api.nvim_set_current_win(win.win)
					-- Auto-enter terminal insert mode so you can start typing right away
					vim.cmd("startinsert")
				end
			end
		end, { desc = "Focus OpenCode Terminal" })
	end,
}
