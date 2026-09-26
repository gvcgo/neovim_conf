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
-- Open fzf-lua's file picker for the directory Neovim was started with.
local function find_files(cwd)
	vim.schedule(function()
		-- fzf-lua is lazy-loaded, so neither `fzf.setup()` (lua/plugins/fzf.lua)
		-- nor the plugin's runtime are ready unless we say so. Waiting for lazy's
		-- `VeryLazy` event is not deterministic: it can fire before or after
		-- `VimEnter`, and when it wins the race the picker never opens at all.
		-- Loading the plugin here is synchronous and idempotent, so the picker
		-- always runs with the configured options.
		require("lazy").load({ plugins = { "fzf-lua" } })

		local ok, err = pcall(require("fzf-lua").files, { cwd = cwd })
		if not ok then
			vim.notify("failed to open the file picker: " .. tostring(err), vim.log.levels.ERROR)
		end
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

		find_files(vim.fn.getcwd())
	end,
})
