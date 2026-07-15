return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	event = "VeryLazy",

	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			["<CR>"] = { "accept", "fallback" },
		},
		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			documentation = { auto_show = true },
			list = {
				selection = {
					preselect = function()
						local ft = vim.bo.filetype
						return ft ~= "markdown" and ft ~= "sagarename"
					end,
					auto_insert = function()
						local ft = vim.bo.filetype
						return ft ~= "sagarename"
					end,
				},
			},
			trigger = { prefetch_on_insert = false },
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
		cmdline = { completion = { ghost_text = { enabled = true } } },
	},
	opts_extend = { "sources.default" },
}
