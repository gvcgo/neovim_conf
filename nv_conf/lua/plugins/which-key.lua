return {
	"folke/which-key.nvim",
	event = "VeryLazy", -- Load on VeryLazy to avoid impacting startup time
	opts = {
		-- Preset style: "classic", "modern", or "helix"
		preset = "modern",

		-- Delay before showing the popup (ms).
		-- Can be a number or a function. 0 for immediate display.
		delay = function(ctx)
			return ctx.plugin and 0 or 200
		end,

		-- Window appearance options
		win = {
			no_overlap = true, -- Prevent popup from overlapping the cursor
			col = math.huge, -- Align popup to the right
			padding = { 1, 2 }, -- Window padding [top/bottom, right/left]
			title = true, -- Show group title
			title_pos = "center",
			zindex = 1000,
		},

		-- Layout options
		layout = {
			width = { min = 20 }, -- Min width of columns
			spacing = 3, -- Spacing between columns
		},

		-- Icon configuration (requires Nerd Fonts)
		icons = {
			breadcrumb = "»", -- Symbol for active key combo in cmdline
			separator = "➜", -- Separator between key and description
			group = "+", -- Group name prefix
			-- Custom icons for specific keys
			keys = {
				Space = "󱁐 ",
				Leader = "󰌟 ",
				C = "󰘴 ",
				M = " ",
				S = "󰘶 ",
			},
		},

		-- Disable which-key for specific filetypes or buftypes
		disable = {
			ft = {},
			bt = {},
		},

		-- Auto-show help for default Neovim keymaps (operators, motions, etc.)
		plugins = {
			marks = true,
			registers = true,
			spelling = { enabled = true, suggestions = 20 },
			presets = {
				operators = true,
				motions = true,
				text_objects = true,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
		},
	},
	-- Define a keymap to manually trigger which-key (e.g., for buffer-local maps)
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
