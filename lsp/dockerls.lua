-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/dockerls.lua

---@class vim.lsp.Config
return {
	cmd = {
		"docker-langserver",
		"--stdio",
	},
	filetypes = {
		"dockerfile",
	},
	root_markers = {
		".git",
		"Dockerfile",
	},

	single_file_support = true,
}
