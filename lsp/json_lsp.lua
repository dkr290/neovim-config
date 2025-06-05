--- @type vim.lsp.Config
return {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { ".git" },
	init_options = {
		provideFormatter = true,
	},
	settings = {
		json = {
			format = { enable = true },
			validate = { enable = true },
			schemas = (function()
				local ok, schemastore = pcall(require, "schemastore")
				if ok then
					return schemastore.json.schemas()
				else
					vim.notify("SchemaStore.nvim not available for JSON LSP", vim.log.levels.WARN)
					return {}
				end
			end)(),
		},
	},
}
