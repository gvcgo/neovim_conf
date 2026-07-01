return {
	"MagicDuck/grug-far.nvim",
	event = "VeryLazy",
	opts = {},
	config = function()
		vim.keymap.set("n", "<leader>R", "<cmd>GrugFar<CR>", { desc = "replace in workspace" })
	end,
}
