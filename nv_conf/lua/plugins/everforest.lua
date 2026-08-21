return {
	"neanias/everforest-nvim",
	version = false,
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.background = "dark"

		local everforest = require("everforest")
		everforest.setup({
			background = "hard",
			transparent_background_level = 1,
			italics = true,
			disable_italic_comments = false,
			inlay_hints_background = "dimmed",

			on_highlights = function(hl, _)
				-- 1. Plain text and punctuation
				local base_text = "#A9B1D6"
				local punctuation = "#7982A9"

				hl.Normal = { fg = base_text }
				hl["@operator"] = { fg = punctuation }
				hl["@punctuation.bracket"] = { fg = punctuation }
				hl["@punctuation.delimiter"] = { fg = punctuation }

				-- 2. Keywords
				local keyword_purple = "#BB9AF7"
				hl["@keyword"] = { fg = keyword_purple }
				hl["@keyword.function"] = { fg = keyword_purple }
				hl["@keyword.modifier"] = { fg = keyword_purple }
				hl["@include"] = { fg = keyword_purple }
				hl["@repeat"] = { fg = keyword_purple }
				hl["@conditional"] = { fg = keyword_purple }

				-- 3. Functions and methods
				local func_blue = "#7AA2F7"
				hl["@function"] = { fg = func_blue }
				hl["@function.call"] = { fg = func_blue }
				hl["@method"] = { fg = func_blue }
				hl["@method.call"] = { fg = func_blue }

				-- 4. Strings
				local string_green = "#50FA7B"
				hl["@string"] = { fg = string_green }

				-- 5. Macros, numbers, and booleans
				local image_purple = "#FF82AB"
				hl["@function.macro"] = { fg = image_purple }
				hl["@macro"] = { fg = image_purple }
				hl["@boolean"] = { fg = image_purple }
				hl["@number"] = { fg = image_purple }

				-- 6. Types and namespaces
				local type_cyan = "#7AA2F7"
				hl["@type"] = { fg = type_cyan }
				hl["@namespace"] = { fg = type_cyan }

				-- ==========================================
				-- 7. Variables and modules (covering Tree-sitter and LSP semantic highlighting)
				-- ==========================================
				local bright_coral = "#43CD80"

				-- Basic Tree-sitter variables
				hl["@variable"] = { fg = bright_coral }
				hl["@module"] = { fg = bright_coral }

				-- 8. Fields and properties (for AuthTeamAdminPermMiddleware etc.): light blue-gray
				hl["@property"] = { fg = "#C0CAF5" }
				hl["@field"] = { fg = "#C0CAF5" }

				-- 9. Comments
				hl.Comment = { fg = "#565F89", italic = true }

				-- Misc
				hl["@string.special.symbol.ruby"] = { link = "@field" }
				hl["DiagnosticUnderlineWarn"] = { undercurl = true, sp = keyword_purple }

				-- ==========================================
				-- 10. Lspsaga fixes: transparent backgrounds and brighter Finder text
				-- ==========================================
				local finder_guide = "#7982A9" -- Color of the Finder tree-structure guide lines

				-- Transparent native floating windows
				hl.NormalFloat = { bg = "NONE" }
				hl.FloatBorder = { bg = "NONE" }

				-- Transparent Lspsaga base windows, and brighten default text
				hl.SagaNormal = { fg = base_text, bg = "NONE" }
				hl.SagaBorder = { bg = "NONE" }
				hl.SagaTitle = { bg = "NONE" }

				-- Brighten the Finder tree-structure guide lines `| |`
				hl.SagaVirtLine = { fg = finder_guide }
				hl.FinderVirtText = { fg = finder_guide }

				-- Fix Finder code being too dark and italicized (override the default Comment link)
				hl.SagaText = { fg = base_text, italic = false }

				-- Highlight for the selected item
				hl.LspSagaFinderSelection = { fg = bright_coral, bold = true }

				-- Ensure the backgrounds of all Lspsaga submodules are also transparent
				hl.HoverNormal = { bg = "NONE" }
				hl.HoverBorder = { bg = "NONE" }
				hl.ActionPreviewNormal = { bg = "NONE" }
				hl.ActionPreviewBorder = { bg = "NONE" }
				hl.RenameNormal = { bg = "NONE" }
				hl.RenameBorder = { bg = "NONE" }
				hl.DiagnosticNormal = { bg = "NONE" }
				hl.DiagnosticBorder = { bg = "NONE" }
			end,
		})

		everforest.load()
	end,
}
