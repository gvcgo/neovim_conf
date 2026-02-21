return {
	"milanglacier/minuet-ai.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local ai_model = vim.env.AI_MODEL
		local ai_end_point = vim.env.AI_END_POINT
		require("minuet").setup({
			provider = "openai_compatible",
			provider_options = {
				openai_compatible = {
					-- model = "LongCat-Flash-Chat",
					-- model = "LongCat-Flash-Lite",
					-- model = "LongCat-Flash-Thinking"
					-- model = "LongCat-Flash-Thinking-2601"
					-- end_point = "https://api.longcat.chat/openai/v1/chat/completions",
					-- api_key = "LONGCAT_API_KEY",
					model = ai_model,
					end_point = ai_end_point,
					api_key = "AI_API_KEY",
					name = "default",
					optional = {
						max_tokens = 4096,
					},
				},
			},
			virtualtext = {
				auto_trigger_ft = { "go", "rust", "python", "javascript", "lua" },
				keymap = {
					accept = "<C-l>",
					-- accept_line = "<C-'>",
					-- accept_n_lines = "<C-;>",
					prev = "<C-[>",
					next = "<C-]>",
					dismiss = "<C-p>",
				},
			},
		})
	end,
}
