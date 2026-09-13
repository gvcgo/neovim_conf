vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.colorcolumn = "100"

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0

vim.opt.autoread = true

vim.opt.showmode = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

vim.opt.signcolumn = "yes"

-- vim.opt.clipboard = "unnamedplus"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local function find_files()
	vim.schedule(function()
		require("fzf-lua").files()
	end)
end

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local arg = vim.fn.argv(0)
		if arg == "" or vim.fn.isdirectory(arg) == 0 then
			return
		end

		vim.cmd.cd(arg)
		vim.bo.buflisted = false

		-- fzf-lua is lazy-loaded, so `fzf.setup()` (lua/plugins/fzf.lua) has not
		-- run yet when VimEnter fires. Requiring the plugin here can hand back the
		-- module without its config, which leaves the picker on fzf-lua's stock
		-- options: `fd` then skips hidden files and honors .gitignore, so the list
		-- comes up empty even though the directory has files. Wait for lazy.nvim's
		-- VeryLazy event so the picker always uses the configured options.
		if vim.g.did_very_lazy then
			find_files()
		else
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				once = true,
				callback = find_files,
			})
		end
	end,
})
