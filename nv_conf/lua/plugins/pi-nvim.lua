local omp_cmd = "omp"

local function omp_opts()
	return {
		win = {
			enter = false,
			position = "left",
			width = 0.3,
			keys = {
				{ "<Up>", "<C-u>", desc = "Scroll up (half page)" },
				{ "<Down>", "<C-d>", desc = "Scroll down (half page)" },
				-- { "<C-b>", "<C-b>", desc = "Scroll up (page)" },
				-- { "<C-f>", "<C-f>", desc = "Scroll down (page)" },
			},
		},
	}
end

local function omp_terminal()
	return require("snacks.terminal").get(omp_cmd, { create = false })
end

local function ensure_omp()
	local terminal = omp_terminal()
	if terminal then
		return terminal
	end

	return require("snacks.terminal").open(omp_cmd, omp_opts())
end

local function send_to_omp(message, retry)
	local terminal = omp_terminal()
	local buf = terminal and terminal.buf
	local job_id = buf and vim.b[buf].terminal_job_id
	if not job_id then
		retry = (retry or 0) + 1
		if retry < 50 then
			vim.defer_fn(function()
				send_to_omp(message, retry)
			end, 100)
			return true
		end
		return false
	end

	local payload = "\x1b[200~" .. message .. "\x1b[201~\r"
	vim.api.nvim_chan_send(job_id, payload)
	vim.notify("Sent to omp", vim.log.levels.INFO)
	return true
end

local function bridge_pi_prompt_to_omp()
	local pi = require("pi-nvim")
	local original_prompt = pi.prompt

	pi.prompt = function(message)
		if type(message) == "string" and omp_terminal() then
			if send_to_omp(message) then
				return
			end
		end
		return original_prompt(message)
	end
end

local function run_pi_command(command)
	local mode = vim.fn.mode()
	local is_visual = mode == "v" or mode == "V" or mode == "\22" or mode == "s" or mode == "S" or mode == "\19"
	local visual_start
	local visual_end
	local visual_range
	local source_win = vim.api.nvim_get_current_win()
	if is_visual then
		visual_start = vim.fn.getpos("v")
		visual_end = vim.fn.getpos(".")
		if visual_start[2] == 0 then
			visual_start = visual_end
		end
		local start_line = visual_start[2]
		local end_line = visual_end[2]
		visual_range = { math.min(start_line, end_line), math.max(start_line, end_line) }
	end

	if visual_start then
		vim.cmd([[normal! \<Esc>]])
		vim.fn.setpos("'<", visual_start)
		vim.fn.setpos("'>", visual_end)
	end

	ensure_omp()

	local function execute()
		if not vim.api.nvim_win_is_valid(source_win) then
			return
		end

		vim.api.nvim_win_call(source_win, function()
			if visual_range then
				vim.cmd(("%d,%d%s"):format(visual_range[1], visual_range[2], command))
			else
				vim.cmd(command)
			end
		end)
	end

	if visual_range then
		execute()
		return
	end

	local attempts = 0
	local wait_for_session
	wait_for_session = function()
		attempts = attempts + 1
		if attempts >= 50 then
			execute()
			return
		end

		local socket_path = require("pi-nvim").get_socket_path()
		if not socket_path then
			vim.defer_fn(wait_for_session, 100)
			return
		end

		local uv = vim.uv or vim.loop
		local client = uv.new_pipe(false)
		if not client then
			vim.defer_fn(wait_for_session, 100)
			return
		end

		client:connect(socket_path, function(err)
			client:close()
			vim.schedule(function()
				if err then
					vim.defer_fn(wait_for_session, 100)
				else
					execute()
				end
			end)
		end)
	end

	wait_for_session()
end

return {
	"carderne/pi-nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/snacks.nvim",
	},
	keys = {
		{
			"<leader>.",
			function()
				require("snacks.terminal").toggle(omp_cmd, omp_opts())
			end,
			desc = "Toggle Oh My Pi",
			mode = { "n", "v", "t" },
		},
		{
			"<C-S-o>",
			function()
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					local buf_name = vim.api.nvim_buf_get_name(buf)
					if vim.bo[buf].buftype == "terminal" and buf_name:find("omp") then
						vim.api.nvim_set_current_win(win)
						vim.cmd("startinsert") -- Auto-enter insert mode
						return
					end
				end
				vim.notify("OMP terminal window not found", vim.log.levels.warn)
			end,
			desc = "Jump to OMP Terminal",
			mode = { "n", "v" },
		},
		{
			"<C-S-o>",
			function()
				local current_win = vim.api.nvim_get_current_win()
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					if win ~= current_win then
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].buftype ~= "terminal" then
							vim.api.nvim_set_current_win(win)
							return
						end
					end
				end
				vim.notify("Regular editor window not found", vim.log.levels.WARN)
			end,
			desc = "Jump to Editor Buffer",
			mode = "t", -- Only active in terminal input mode
		},
		{
			"<leader>aa",
			function()
				run_pi_command("Pi")
			end,
			mode = { "n", "v" },
			desc = "Pi: Open dialog",
		},
		{
			"<leader>af",
			function()
				run_pi_command("PiSendFile")
			end,
			mode = "n",
			desc = "Pi: Send file",
		},
		{
			"<leader>as",
			function()
				run_pi_command("PiSendSelection")
			end,
			mode = "v",
			desc = "Pi: Send selection",
		},
		{
			"<leader>ab",
			function()
				run_pi_command("PiSendBuffer")
			end,
			mode = "n",
			desc = "Pi: Send buffer",
		},
		{
			"<leader>ao",
			function()
				run_pi_command("PiSessions")
			end,
			mode = "n",
			desc = "Pi: List sessions",
		},
	},
	config = function()
		require("pi-nvim").setup({
			socket_path = nil, -- auto-discover
			set_default_keymaps = false,
		})
		bridge_pi_prompt_to_omp()
	end,
}
