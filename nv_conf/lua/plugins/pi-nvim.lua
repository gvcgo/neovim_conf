local omp_cmd = "omp 'You are a code assistant, writer and viewer.'"

local function omp_opts()
	return {
		win = {
			enter = false,
			position = "right",
			width = 0.4,
		},
	}
end

local function ensure_omp()
	local terminal = require("snacks.terminal").get(omp_cmd, { create = false })
	if terminal then
		return
	end

	require("snacks.terminal").open(omp_cmd, omp_opts())
end

local function run_pi_command(command)
	local mode = vim.fn.mode()
	local is_visual = mode == "v" or mode == "V" or mode == "\22"
	ensure_omp()

	local function execute()
		if is_visual then
			vim.cmd("'<,'>" .. command)
		else
			vim.cmd(command)
		end
	end

	local attempts = 0
	local function wait_for_session()
		if require("pi-nvim").get_socket_path() then
			execute()
			return
		end

		attempts = attempts + 1
		if attempts >= 50 then
			execute()
			return
		end

		vim.defer_fn(wait_for_session, 100)
	end

	wait_for_session()
end

return {
	"carderne/pi-nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/snacks.nvim",
		"rauls-kjarners/omp.nvim",
	},
	keys = {
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
	end,
}
