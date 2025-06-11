return {
	cmd = { "helm_ls", "serve" },
	filetypes = { "helm", "helmfile" },
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
