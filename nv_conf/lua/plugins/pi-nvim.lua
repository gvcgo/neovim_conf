return {
	"carderne/pi-nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>aa", "<cmd>Pi<cr>", mode = { "n", "v" }, desc = "Pi: Open dialog" },
		{ "<leader>af", "<cmd>PiSendFile<cr>", mode = "n", desc = "Pi: Send file" },
		{ "<leader>as", "<cmd>PiSendSelection<cr>", mode = "v", desc = "Pi: Send selection" },
		{ "<leader>ab", "<cmd>PiSendBuffer<cr>", mode = "n", desc = "Pi: Send buffer" },
		{ "<leader>ao", "<cmd>PiSessions<cr>", mode = "n", desc = "Pi: List sessions" },
	},
	config = function()
		require("pi-nvim").setup({
			socket_path = nil, -- auto-discover
			set_default_keymaps = false,
		})
	end,
}
