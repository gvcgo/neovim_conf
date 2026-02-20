return {
	"mason-org/mason-lspconfig.nvim",
	event = "VeryLazy",
	opts = {
		ensure_installed = {
			"lua_ls",
			"gopls",
			"rust_analyzer",
			"pyright",
			"ruff",
			"ts_ls",
			"bashls",
			"yamlls",
			"buf_ls",
			"html",
			"cssls",
			"emmet_ls",
			"marksman",
		},
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	config = function(_, opts)
		require("mason").setup()

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
				},
			},
		})

		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					analyses = { unusedparams = true },
					staticcheck = true,
				},
			},
		})

		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					checkOnSave = { command = "clippy" },
				},
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.py",
			callback = function()
				vim.lsp.buf.format({ name = "ruff" })
				vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
			end,
		})

		require("mason-lspconfig").setup(opts)

		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
				spacing = 4,
			},
			signs = true,
			underline = true,
			update_in_insert = false,
			float = {
				border = "rounded",
				source = true,
			},
		})
	end,
}
