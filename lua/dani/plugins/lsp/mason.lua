return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")
		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
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
			},
		})
		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				-- "isort", -- python formatter
				-- "black", -- python formatter
				"gopls", -- go formatter
				"pylint",
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
		})
	end,
}
