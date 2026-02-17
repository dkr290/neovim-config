return {
	-- "buf beta lsp" is now deprecated in favor of "buf lsp serve"
	cmd = { "buf", "lsp", "serve" },
	filetypes = { "proto" },
	-- These markers are standard for the Buf ecosystem
	root_markers = { "buf.yaml", "buf.work.yaml", ".git" },
	settings = {
		-- Usually empty as Buf reads from your project's buf.yaml
	},
}
