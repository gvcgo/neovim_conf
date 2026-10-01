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
--
-- fzf-lua builds the file list in a headless child process that asks this
-- instance for `FzfLua.config` over RPC with a 200 ms deadline
-- (`fzf-lua.utils.rpcexec`). When that request lands while the main loop is
-- busy with startup work, as it is while lazy.nvim loads its `VeryLazy`
-- plugins, the deadline is missed: the child dies with "loop or previous error
-- loading module 'fzf-lua.make_entry'" and the picker shows an empty list that
-- never fills in. So open the picker after the `VeryLazy` batch, never during
-- it.
local function find_files(cwd)
	local function open()
		local ok, err = pcall(require("fzf-lua").files, { cwd = cwd })
		if not ok then
			vim.notify("failed to open the file picker: " .. tostring(err), vim.log.levels.ERROR)
		end
	end

	-- fzf-lua is lazy-loaded, so `fzf.setup()` (lua/plugins/fzf.lua) has not run
	-- yet. `lazy.load` is synchronous and idempotent, which keeps the picker on
	-- the configured options.
	require("lazy").load({ plugins = { "fzf-lua" } })

	-- `VeryLazy` can fire before or after `VimEnter`. `vim.g.did_very_lazy` is
	-- set just before the event is dispatched, so when it is already set here
	-- the plugins it triggers are loaded; otherwise, the autocmd is registered
	-- after lazy's own handler (lazy registers it in `setup`, which runs
	-- earlier) and therefore runs after those plugins are loaded.
	local function when_ready()
		vim.schedule(open)
	end
	if vim.g.did_very_lazy then
		when_ready()
	else
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			once = true,
			callback = when_ready,
		})
	end
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
