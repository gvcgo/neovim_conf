local function omp_cmd()
	local profile = vim.env.OMP_PROFILE
	if profile then
		return string.format("omp --profile %s", profile)
	end
	return "omp"
end

local function omp_opts()
	return {
		-- The terminal is a singleton; pin the count so opening it with a count
		-- prefix cannot spawn a second one.
		count = 1,
		win = {
			enter = false,
			position = "left",
			width = 0.3,
		},
	}
end

-- Handle on the single omp terminal. `snacks.terminal.get` keys its registry by
-- command, cwd, env and count, so a lookup after a `:cd` (or with a count
-- prefix) misses the running terminal and starts a second one.
local omp_term = nil

-- The running omp terminal, or nil when it was never started or was wiped.
local function omp_terminal()
	local terminal = omp_term
	if terminal and terminal:buf_valid() then
		return terminal
	end
	omp_term = nil
	return nil
end

-- The omp terminal, starting it when it is not running yet.
local function ensure_omp()
	local terminal = omp_terminal()
	if terminal then
		return terminal
	end

	omp_term = require("snacks.terminal").open(omp_cmd(), omp_opts())
	return omp_term
end

-- Close the terminal window, keeping the terminal buffer (and the omp process)
-- alive.
-- Closing the last window of a tab fails with E444, in which case snacks splits
-- the terminal buffer into a new full-screen window: the terminal stays visible
-- and every further toggle stacks another window showing it. Hand the tab an
-- editor window to fall back on before closing the terminal window, and let
-- snacks close its own window so its `fixbuf` guard stays out of the way.
local function hide_omp(terminal)
	local win = terminal.win
	local tab = vim.api.nvim_win_get_tabpage(win)
	if #vim.api.nvim_tabpage_list_wins(tab) > 1 then
		terminal:hide()
		return
	end

	local editor_win = vim.api.nvim_win_call(win, function()
		vim.cmd("silent keepalt vnew")
		return vim.api.nvim_get_current_win()
	end)
	-- Window options are inherited from the split parent; drop the winbar that
	-- snacks set up for the terminal.
	vim.api.nvim_set_option_value("winbar", vim.go.winbar, { win = editor_win })

	terminal:hide()

	-- Focus the new window, but never jump to another tab to do so.
	local valid = vim.api.nvim_win_is_valid(editor_win)
	if valid and vim.api.nvim_win_get_tabpage(editor_win) == vim.api.nvim_get_current_tabpage() then
		vim.api.nvim_set_current_win(editor_win)
	end
end

local function toggle_omp()
	local terminal = omp_terminal()
	if terminal and terminal:win_valid() then
		hide_omp(terminal)
		return
	end

	ensure_omp():show()
end

-- Show the terminal window (starting the terminal when needed) and focus it.
local function focus_omp()
	local terminal = ensure_omp()
	terminal:show()
	terminal:focus()
	if vim.api.nvim_get_current_buf() == terminal.buf then
		vim.cmd("startinsert")
	end
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

local function capture_visual_selection(start_pos, end_pos, visual_mode)
	local selection_type = ({
		s = "v",
		S = "V",
		["\19"] = "\22",
	})[visual_mode] or visual_mode
	if selection_type == "" then
		selection_type = "v"
	end

	local ok, lines = pcall(vim.fn.getregion, start_pos, end_pos, {
		type = selection_type,
	})
	if not ok or not lines or #lines == 0 then
		return nil
	end

	return {
		text = table.concat(lines, "\n"),
		file = vim.fn.expand("%:."),
		start_line = math.min(start_pos[2], end_pos[2]),
		end_line = math.max(start_pos[2], end_pos[2]),
		ft = vim.bo.filetype,
	}
end

local function send_visual_selection(selection)
	local pi = require("pi-nvim")

	vim.ui.input({ prompt = "Pi prompt (selection): " }, function(input)
		if not input then
			return
		end

		local header = string.format("%s lines %d-%d", selection.file, selection.start_line, selection.end_line)
		local message
		if input == "" then
			message =
				string.format("Look at this code from %s:\n\n```%s\n%s\n```", header, selection.ft, selection.text)
		else
			message = string.format("%s\n\nFrom %s:\n```%s\n%s\n```", input, header, selection.ft, selection.text)
		end
		pi.prompt(message)
	end)
end

local function open_pi_with_selection(selection)
	require("pi-nvim.ui").open({ selection = selection })
end

local function run_pi_command(command)
	local mode = vim.fn.mode()
	local is_visual = mode == "v" or mode == "V" or mode == "\22" or mode == "s" or mode == "S" or mode == "\19"
	local visual_start
	local visual_end
	local visual_range
	local visual_selection
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
		visual_selection = capture_visual_selection(visual_start, visual_end, mode)
		if not visual_selection then
			vim.notify("Unable to capture visual selection", vim.log.levels.ERROR)
			return
		end
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
			if command == "PiSendSelection" and visual_selection then
				send_visual_selection(visual_selection)
			elseif command == "Pi" and visual_selection then
				open_pi_with_selection(visual_selection)
			elseif visual_range then
				vim.cmd(("%d,%d%s"):format(visual_range[1], visual_range[2], command))
			else
				vim.cmd(command)
			end
		end)
	end
	execute()
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
			toggle_omp,
			desc = "Toggle Oh My Pi",
			mode = { "n", "v", "t" },
		},
		{
			"<C-S-o>",
			focus_omp,
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
