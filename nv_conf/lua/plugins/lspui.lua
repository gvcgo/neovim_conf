return {
	"jinzhongjia/LspUI.nvim",
	branch = "main",
	event = "BufReadPre",
	keys = {
		{ "K", "<cmd>LspUI hover<CR>", desc = "LspUI: Hover Documentation" },
		{ "gr", "<cmd>LspUI reference<CR>", desc = "LspUI: LSP Finder (references)" },
		{ "gi", "<cmd>LspUI implementation<CR>", desc = "LspUI: LSP Finder (implementations)" },
		{ "gd", "<cmd>LspUI definition<CR>", desc = "LspUI: Goto Definition" },
		{ "gs", "<cmd>LspUI definition<CR>", desc = "LspUI: Peek Definition" },
		{ "<leader>r", "<cmd>LspUI rename<CR>", desc = "LspUI: Rename in Project" },
		{ "<leader>c", "<cmd>LspUI code_action<CR>", desc = "LspUI: Code Action" },
		{ "<leader>jh", "<cmd>LspUI history<CR>", desc = "LspUI: Jump History" },
	},
	config = function()
		require("LspUI").setup({
			hover = {
				key_binding = {
					prev = "p",
					next = "n",
					quit = "q",
				},
			},
			rename = {
				auto_select = true,
				key_binding = {
					exec = "<CR>",
					quit = "<ESC>",
				},
			},
			pos_keybind = {
				secondary = {
					jump = "o",
					jump_split = "sh",
					jump_vsplit = "sv",
					quit = "q",
				},
			},
		})
	end,
}
