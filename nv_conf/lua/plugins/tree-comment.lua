return {
	"alexmozaidze/tree-comment.nvim",
	dependencies = "nvim-treesitter/nvim-treesitter",
	opts = {},
	keywords = {
		todo = { "TODO", "WIP" },
		note = { "NOTE", "INFO", "DOCS", "PERF", "TEST" },
		warning = { "WARN", "WARNING", "SAFETY", "HACK", "XXX" },
		error = { "FIX", "FIXME", "BUG", "ERROR" },
	},
}
