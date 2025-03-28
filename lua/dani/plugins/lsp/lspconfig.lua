return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		-- on_attach function for ruff (Python linter)
		local ruff_on_attach = function(client, bufnr)
			if client.name == "ruff" then
				-- Disable hover in favor of Pyright
				client.server_capabilities.hoverProvider = false
			end
		end

		local keymap = vim.keymap -- for conciseness
		vim.filetype.add({ extension = { templ = "templ" } })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["emmet_ls"] = function()
				-- configure emmet language server
				lspconfig["emmet_ls"].setup({
					capabilities = capabilities,
					filetypes = {
						"html",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
					},
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
			["html"] = function()
				-- configure lua server (with special settings)
				lspconfig["html"].setup({
					capabilities = capabilities,
					filetypes = { "html", "templ" },
				})
			end,
			["templ"] = function()
				lspconfig["templ"].setup({
					capabilities = capabilities,
					cmd = { "templ", "lsp" },
					filetypes = { "templ" },
					root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
				})
			end,
			["tailwindcss"] = function()
				-- configure lua server (with special settings)
				lspconfig["tailwindcss"].setup({
					capabilities = capabilities,
					filetypes = { "templ", "astro", "javascript", "typescript", "react" },
					settings = {
						tailwindCSS = {
							includeLanguages = {
								templ = "html",
							},
						},
					},
				})
			end,

			["helm_ls"] = function()
				lspconfig["helm_ls"].setup({
					capabilities = capabilities,
					settings = {
						["helm-ls"] = {
							logLevel = "info",
							valuesFiles = {
								mainValuesFile = "values.yaml",
								lintOverlayValuesFile = "values.lint.yaml",
								additionalValuesFilesGlobPattern = "values*.yaml",
							},
							yamlls = {
								enabled = true,
								diagnosticsLimit = 50,
								showDiagnosticsDirectly = false,
								path = "yaml-language-server",
								config = {
									schemas = {
										kubernetes = { "k8s**.yaml", "kube*/*.yaml" },
										["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"] = "argocd-*.{yml,yaml}",
										["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj/appproject_v1alpha1.json"] = "argocd-*.{yml,yaml}",
										["https://json.schemastore.org/chart.json"] = "Chart.yaml",
									},
									completion = true,
									hover = true,
								},
							},
						},
					},
				})
			end,
			["yamlls"] = function()
				lspconfig["yamlls"].setup({
					capabilities = capabilities,
					settings = {
						redhat = { telemetry = { enabled = false } },
						yaml = {
							validate = true,
							-- disable the schema store
							schemaStore = {
								enable = false,
								url = "",
							},
							-- manually select schemas
							schemas = {
								kubernetes = { "k8s**.yaml", "kube*/*.yaml" },
								["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
								["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"] = "argocd-*.{yml,yaml}",
								["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj/appproject_v1alpha1.json"] = "argocd-*.{yml,yaml}",
								["https://json.schemastore.org/chart.json"] = "Chart.yaml",
								["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
								["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/bitnami.com/sealedsecret_v1alpha1.json"] = "sealed*.{yml,yaml}",
								["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/keda.sh/scaledobject_v1alpha1.json"] = "scaled*.{yml,yaml}",
							},
						},
					},
				})
			end,
			["gopls"] = function()
				lspconfig["gopls"].setup({
					capabilities = capabilities,
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					settings = {
						gopls = {
							completeUnimported = true, -- Key setting for unimported completions
							usePlaceholders = true,
							analyses = {
								unusedparams = true,
							},
							staticcheck = true,
							gofumpt = true,
						},
					},
				})
			end,
			["ruff"] = function()
				lspconfig.ruff.setup({
					capabilities = capabilities,
					on_attach = ruff_on_attach,
					init_options = {
						settings = {
							format = { preview = true },
							lint = {
								enable = true,
								preview = true,
								select = { "E", "F", "N" },
								extendSelect = {
									"W",
									"I",
									"UP007",
									"UP015",
									"FAST001",
									"FAST002",
									"FAST003",
									"RUF100",
									"RUF101",
								},
								ignore = {},
								extendIgnore = {},
							},
							codeAction = {
								disableRuleComment = { enable = true },
								fixViolation = { enable = true },
							},
							showSyntaxErrors = true,
							organizeImports = true,
							fixAll = true,
							lineLength = 120,
							exclude = {
								".git",
								".ipynb_checkpoints",
								".mypy_cache",
								".pyenv",
								".pytest_cache",
								".pytype",
								".ruff_cache",
								".venv",
								".vscode",
								"__pypackages__",
								"_build",
								"build",
								"dist",
								"site-packages",
								"venv",
							},
						},
					},
				})
			end,
			-- Handler for basedpyright (Python language server).
			["basedpyright"] = function()
				lspconfig.basedpyright.setup({
					capabilities = capabilities,
					settings = {
						disableOrganizeImports = true,
						basedpyright = { typeCheckingMode = "standard" },
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				})
			end,
		})
	end,
}
