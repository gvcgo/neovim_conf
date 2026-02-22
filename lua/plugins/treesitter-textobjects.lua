return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	select = {
		-- Automatically jump forward to textobj, similar to targets.vim
		lookahead = true,
		selection_modes = {
			["@parameter.outer"] = "v", -- charwise
			["@function.outer"] = "V", -- linewise
			-- ['@class.outer'] = '<c-v>', -- blockwise
		},
		include_surrounding_whitespace = false,
	},
	move = {
		-- whether to set jumps in the jumplist
		set_jumps = true,
	},
	init = function()
		-- Disable entire built-in ftplugin mappings to avoid conflicts.
		-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
		vim.g.no_plugin_maps = true

		-- Or, disable per filetype (add as you like)
		-- vim.g.no_python_maps = true
		-- vim.g.no_ruby_maps = true
		-- vim.g.no_rust_maps = true
		-- vim.g.no_go_maps = true
	end,
	config = function()
		local to_select = require("nvim-treesitter-textobjects.select")
		vim.keymap.set({ "x", "o" }, "af", function()
			to_select.select_textobject("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "if", function()
			to_select.select_textobject("@function.inner", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ac", function()
			to_select.select_textobject("@class.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ic", function()
			to_select.select_textobject("@class.inner", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "aa", function()
			to_select.select_textobject("@parameter.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ia", function()
			to_select.select_textobject("@class.parameter", "textobjects")
		end)
		-- You can also use captures from other query groups like `locals.scm`
		vim.keymap.set({ "x", "o" }, "as", function()
			to_select.select_textobject("@local.scope", "locals")
		end)

		local to_swap = require("nvim-treesitter-textobjects.swap")
		vim.keymap.set("n", "ms", function()
			to_swap.swap_next("@parameter.inner")
		end)
		vim.keymap.set("n", "mS", function()
			to_swap.swap_previous("@parameter.outer")
		end)

		local to_move = require("nvim-treesitter-textobjects.move")
		vim.keymap.set({ "n", "x", "o" }, "]f", function()
			to_move.goto_next_start("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "]c", function()
			to_move.goto_next_start("@class.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "[F", function()
			to_move.goto_previous_start("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "[C", function()
			to_move.goto_previous_start("@class.outer", "textobjects")
		end)
	end,
}
