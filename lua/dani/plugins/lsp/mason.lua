return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-lspconfig").setup({
			-- list of servers for mason to install
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"emmet_ls",
				"dockerls",
				"gopls",
				"glint",
				"helm_ls",
				"templ",
				"terraformls",
				"yamlls",
				"ruff",
				"basedpyright",
				"typos_lsp",
			},
			automatic_enable = true,
		})
		require("mason-tool-installer").setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				-- "isort", -- python formatter
				-- "black", -- python formatter
				"gopls", -- go formatter
				-- "pylint",
				"eslint_d",
				"golangci-lint",
				"goimports",
				"gofumpt",
				"golines",
				"gomodifytags",
				"ruff", -- Alternative Python linter
				"black", -- Python formatter
				"isort", -- Python import sorter
				"basedpyright",
			},
			automatic_enable = true,
		})
	end,
}
