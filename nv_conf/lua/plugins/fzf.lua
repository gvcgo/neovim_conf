return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		local fzf = require("fzf-lua")
		local rg_opts =
			"--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden --no-ignore"

		fzf.setup({
			fzf_opts = {
				["--layout"] = "default",
			},

			files = {
				fd_opts = "--color=never --type f --hidden --no-ignore --follow --exclude .git",
			},
			grep = {
				rg_opts = rg_opts,
			},
			winopts = {
				height = 0.85,
				width = 0.80,
				preview = {
					layout = "flex",
				},
			},
		})

		vim.keymap.set("n", "<leader>f", function()
			fzf.files()
		end, { desc = "find files" })

		vim.keymap.set("n", "<leader>C", function()
			fzf.files({
				cwd = vim.fn.stdpath("config"),
			})
		end, { desc = "find nvim config files" })

		vim.keymap.set("n", "<leader>d", function()
			fzf.diagnostics_workspace({
				severity = vim.diagnostic.severity.WARN,
			})
		end, { desc = "Search Diagnostics" })

		vim.keymap.set("n", "<leader>k", function()
			fzf.keymaps()
		end, { desc = "Search keymaps" })

		vim.keymap.set("n", "<leader>S", function()
			fzf.lsp_live_workspace_symbols()
		end, { desc = "Search workspace symbols" })

		vim.keymap.set("n", "<leader>s", function()
			fzf.lsp_document_symbols()
		end, { desc = "Search document symbols" })

		vim.keymap.set("n", "<leader>/", function()
			fzf.live_grep()
		end, { desc = "Search string" })

		-- vim.keymap.set("n", "<leader>gd", function()
		-- 	fzf.git_diff()
		-- end, { desc = "Search git diff for workspace" })

		vim.keymap.set("n", "<leader>gc", function()
			fzf.git_bcommits()
		end, { desc = "Search git commit for current buffer" })

		vim.keymap.set("n", "<leader>gr", function()
			fzf.git_reflog()
		end, { desc = "Search git reflog" })

		local todo_pattern = [[(#|//|--|/\*|\*)[^\r\n]*\b(TODO|FIXME|HACK|BUG|NOTE|PERF)\b]]
		vim.keymap.set("n", "<leader>T", function()
			fzf.grep_project({
				search = todo_pattern,
				rg_opts = rg_opts .. " --glob '!**/.venv/**' --glob '!**/.git/**' --glob '!**/.cache/**'",
				no_esc = true,
				prompt = "Todos> ",
			})
		end, { desc = "Search TODO comments" })

		vim.keymap.set("n", "<leader>t", function()
			fzf.grep_curbuf({
				search = todo_pattern,
				no_esc = true,
				prompt = "Buffer Todos> ",
			})
		end, { desc = "Search TODOs in current buffer" })
	end,
}
