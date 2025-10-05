--- @type vim.lsp.Config
return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
	root_markers = { ".git" },
	settings = {
		-- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
		redhat = { telemetry = { enabled = false } },
		yaml = {
			keyOrdering = false,
			format = { enable = true },
			validate = true,
			completion = true,
			hover = true,
			schemaStore = {
				-- Must disable built-in schemaStore support to use
				-- schemas from SchemaStore.nvim plugin
				enable = false,
				-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
				url = "",
			},
			schemas = (function()
				local ok, schemastore = pcall(require, "schemastore")
				local schemas = {}

				if ok then
					schemas = schemastore.yaml.schemas()
				else
					vim.notify("SchemaStore.nvim not available for YAML LSP", vim.log.levels.WARN)
				end

				schemas["https://json.schemastore.org/github-workflow.json"] = {
					".github/workflows/*.yaml",
					".github/workflows/*.yml",
				}

				schemas["https://json.schemastore.org/github-action.json"] = {
					"action.yaml",
					"action.yml",
				}
				schemas["https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/argoproj.io/application_v1alpha1.json"] =
					{
						-- Common file patterns for ArgoCD Applications
						"**/application.yaml",
						"**/application.yml",
						"**/app.yaml",
						"**/app.yml",
						"**/argocd-*",
						"**/*-app.yaml",
						"**/*-app.yml",
						"**/*-application.yaml",
						"**/*-application.yml",
						"**/argocd/**/*.yaml",
						"**/argocd/**/*.yml",
					}

				-- Add explicit Kubernetes schema for better detection
				schemas["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.34.1-standalone-strict/all.json"] =
					{
						-- K8s directories
						"**/k8s/**/*.yaml",
						"**/k8s/**/*.yml",
						"**/kubernetes/**/*.yaml",
						"**/kubernetes/**/*.yml",
						"**/manifests/**/*.yaml",
						"**/manifests/**/*.yml",
						-- Common K8s file patterns
						"**/*-deployment.yaml",
						"**/*-deployment.yml",
						"**/*-service.yaml",
						"**/*-service.yml",
						"**/*-configmap.yaml",
						"**/*-configmap.yml",
						"**/*-secret.yaml",
						"**/*-secret.yml",
						"**/*-ingress.yaml",
						"**/*-ingress.yml",
						"**/*-pv.yaml",
						"**/*-pv.yml",
						"**/*-pvc.yaml",
						"**/*-pvc.yml",
						-- Standard K8s resource names
						"**/deployment.yaml",
						"**/deployment.yml",
						"**/service.yaml",
						"**/service.yml",
						"**/configmap.yaml",
						"**/configmap.yml",
						"**/secret.yaml",
						"**/secret.yml",
						"**/ingress.yaml",
						"**/ingress.yml",
						"**/namespace.yaml",
						"**/namespace.yml",
						-- Files with k8s in name
						"**/*k8s*.yaml",
						"**/*k8s*.yml",
						"**/*kube*.yaml",
						"**/*kube*.yml",
					}

				return schemas
			end)(),
		},
	},
}
