return {
	{
		"linrongbin16/gitlinker.nvim",
		cmd = "GitLink",
		opts = {
			remote = "origin",
		},
		keys = {
			{ "<leader>gb", "<cmd>GitLink! blame<cr>", mode = { "n", "v" }, desc = "Open git blame link" },
			{ "<leader>gg", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
		},
	},
}
