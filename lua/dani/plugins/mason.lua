return {
	"mason-org/mason.nvim",
	dependencies = {
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

		require("mason-tool-installer").setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				-- "isort", -- python formatter
				-- "black", -- python formatter
				"gopls", -- go formatter
				-- "pylint",
				"golangci-lint",
				"goimports",
				"gofumpt",
				"golines",
				"gomodifytags",
				"go-debug-adapter",
				"gotests",
				"terraform",
				"tflint",
				-- docker
				"hadolint",
				"ruff", -- Alternative Python linter
				"black", -- Python formatter
				"isort", -- Python import sorter
				"basedpyright",
				"lua-language-server",
				"basedpyright",
				"ruff",
				"azure-pipelines-language-server",
				"bash-language-server",
				"css-lsp",
				"dockerfile-language-server",
				"dot-language-server",
				"html-lsp",
				"json-lsp",
				"tailwindcss-language-server",
				"typescript-language-server",
				"yaml-language-server",
				"typos-lsp",
				"html-lsp",
				"json-lsp",
				"helm-ls",
				"terraform-ls",
				-- Bash stuff
				"shellcheck",
				"beautysh",
				-- YAML stuff
				"yamllint",
				"prettierd",
				-- eslint
				"eslint_d",
				-- sql
				"sqlfluff",
				-- markdown
				"markdownlint-cli2",
				"markdown-toc",
				--- Python stuff
				"jupytext",
				"pylint",
				--- Lua stuff
				"prettier",
				"stylua",
				-- JSON stuff
				"jsonlint",
				"jq",
			},
			automatic_enable = true,
		})
	end,
}
