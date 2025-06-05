-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/basedpyright.lua

---@type vim.lsp.ClientConfig
return {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	},
	workspace_required = false,
	settings = {
		basedpyright = {
			disableOrganizeImports = true, -- Let ruff handle imports if used together
			typeCheckingMode = "standard",
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
}
