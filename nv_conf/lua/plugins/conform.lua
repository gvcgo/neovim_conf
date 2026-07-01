return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	opts = {},
	config = function(_, _)
		local formatters = {
			"stylua",
			"isort",
			"black",
			"rustfmt",
			"prettierd",
			"prettier",
			"gofmt",
			"goimports",
		}

		require("mason").setup()
		local registry = require("mason-registry")
		registry.refresh(function()
			for _, pkg_name in ipairs(formatters) do
				local ok, pkg = pcall(registry.get_package, pkg_name)
				if ok and not pkg:is_installed() then
					pkg:install()
				end
			end
		end)

		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black" },
				-- You can customize some of the format options for the filetype (:help conform.format)
				rust = { "rustfmt", lsp_format = "fallback" },
				-- Conform will run the first available formatter
				javascript = { "prettierd", "prettier", stop_after_first = true },
				go = { "goimports", "gofmt" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 1000,
				lsp_format = "fallback",
			},
		})
	end,
}
