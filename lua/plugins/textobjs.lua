return {
	"chrisgrieser/nvim-various-textobjs",
	event = "VeryLazy",
	opts = {
		keymaps = {
			useDefaults = true,
		},
	},
	config = function(_, opts)
		require("various-textobjs").setup(opts)
		vim.keymap.set({ "o", "x" }, "ai", '<cmd>lua require("various-textobjs").subword("outer")<CR>')
		vim.keymap.set({ "o", "x" }, "ii", '<cmd>lua require("various-textobjs").subword("inner")<CR>')
	end,
}
