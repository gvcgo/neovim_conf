return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- 核心依赖
		},
		build = "make tiktoken",
		opts = {
			model = "gpt-5.3-codex",
			temperature = 0.1,
			auto_insert_mode = true,
			window = {
				layout = "float",
				width = 0.8,
				height = 0.8,
				border = "rounded",
			},
		},
		keys = {
			{ "<leader>ll", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - explain code" },
			{ "<leader>lt", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - toggle chat" },
		},
	},
}
