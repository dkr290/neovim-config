return {
	cmd = { "helm-ls", "serve" },
	filetypes = { "helm" },
	root_markers = { "Chart.yaml" },
	single_file_support = true,
	capabilities = {
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
		},
	},
}
