return {
	"neko-night/nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	enabled = false,
	config = function()
		local nekonight = require("nekonight")

		nekonight.setup({
			transparent = true,
			-- use the night style
			style = "dracula-at-night",
			-- disable italic for functions
			styles = {
				functions = {},
			},
			-- Change the "hint" color to the "orange" color, and make the "error" color bright red
			on_colors = function(colors)
				colors.hint = colors.orange
				colors.error = "#ff0000"
			end,
			on_highlights = function(hl)
				hl.Visual = {
					bg = "#364A82",
					fg = "NONE",
				}
				hl.DiagnosticUnnecessary = {
					fg = "#7A88CF",
					italic = true,
				}

				hl.CursorLine = {
					bg = "#2e3c64",
				}

				hl.PmenuSel = {
					bg = "#7aa2f7",
					fg = "#15161e",
					bold = true,
				}

				hl.PmenuThumb = {
					bg = "#3b4261",
				}
			end,
		})

		nekonight.load()
	end,
}
