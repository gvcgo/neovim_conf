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
				-- 1. 普通文本和标点
				local base_text = "#A9B1D6"
				local punctuation = "#7982A9"

				hl.Normal = { fg = base_text }
				hl["@operator"] = { fg = punctuation }
				hl["@punctuation.bracket"] = { fg = punctuation }
				hl["@punctuation.delimiter"] = { fg = punctuation }

				-- 2. 关键字
				local keyword_purple = "#BB9AF7"
				hl["@keyword"] = { fg = keyword_purple }
				hl["@keyword.function"] = { fg = keyword_purple }
				hl["@keyword.modifier"] = { fg = keyword_purple }
				hl["@include"] = { fg = keyword_purple }
				hl["@repeat"] = { fg = keyword_purple }
				hl["@conditional"] = { fg = keyword_purple }

				-- 3. 函数和方法
				local func_blue = "#7AA2F7"
				hl["@function"] = { fg = func_blue }
				hl["@function.call"] = { fg = func_blue }
				hl["@method"] = { fg = func_blue }
				hl["@method.call"] = { fg = func_blue }

				-- 4. 字符串
				local string_green = "#50FA7B"
				hl["@string"] = { fg = string_green }

				-- 5. 宏、数字与布尔值
				local image_purple = "#FF82AB"
				hl["@function.macro"] = { fg = image_purple }
				hl["@macro"] = { fg = image_purple }
				hl["@boolean"] = { fg = image_purple }
				hl["@number"] = { fg = image_purple }

				-- 6. 类型和命名空间
				local type_cyan = "#7AA2F7"
				hl["@type"] = { fg = type_cyan }
				hl["@namespace"] = { fg = type_cyan }

				-- ==========================================
				-- 7. 变量和模块 (涵盖 Tree-sitter 与 LSP 语义高亮)
				-- ==========================================
				local bright_coral = "#43CD80"

				-- 基础 Tree-sitter 变量
				hl["@variable"] = { fg = bright_coral }
				hl["@module"] = { fg = bright_coral }

				-- 8. 字段和属性 (针对 AuthTeamAdminPermMiddleware 等)：浅蓝灰
				hl["@property"] = { fg = "#C0CAF5" }
				hl["@field"] = { fg = "#C0CAF5" }

				-- 9. 注释
				hl.Comment = { fg = "#565F89", italic = true }

				-- 杂项
				hl["@string.special.symbol.ruby"] = { link = "@field" }
				hl["DiagnosticUnderlineWarn"] = { undercurl = true, sp = keyword_purple }

				-- ==========================================
				-- 10. Lspsaga 修复区：透明背景与 Finder 文本提亮
				-- ==========================================
				local finder_guide = "#7982A9" -- Finder 树状结构引导线的颜色

				-- 原生浮动窗口透明
				hl.NormalFloat = { bg = "NONE" }
				hl.FloatBorder = { bg = "NONE" }

				-- Lspsaga 基础窗口透明，并提亮默认文本
				hl.SagaNormal = { fg = base_text, bg = "NONE" }
				hl.SagaBorder = { bg = "NONE" }
				hl.SagaTitle = { bg = "NONE" }

				-- Finder 树状结构引导线 `| |` 提亮
				hl.SagaVirtLine = { fg = finder_guide }
				hl.FinderVirtText = { fg = finder_guide }

				-- 修复 Finder 代码太暗和变成斜体的问题 (覆盖默认的 Comment 链接)
				hl.SagaText = { fg = base_text, italic = false }

				-- 选中项的高亮
				hl.LspSagaFinderSelection = { fg = bright_coral, bold = true }

				-- 确保 Lspsaga 各个子模块的背景也是透明的
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
