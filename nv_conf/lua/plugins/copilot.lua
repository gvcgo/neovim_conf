return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	enabled = false,
	config = function()
		require("copilot").setup({
			suggestion = { enabled = false },
			panel = { enabled = true },
			nes = {
				enabled = false,
			},
			copilot_node_command = "/home/moqsien/.vmr/versions/node_versions/node/bin/node",
		})
	end,
}
