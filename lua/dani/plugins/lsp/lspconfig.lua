return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		"mason-org/mason-lspconfig.nvim",
		{ "folke/lazydev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")
		local blink_cmp = require("blink.cmp")
		-- used to enable autocompletion (assign to every lsp server config)
		--	local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local capabilities = blink_cmp.get_lsp_capabilities()

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")
		-- on_attach function for ruff (Python linter)
		-- Set up LSP capabilities

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
				keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
		mason_lspconfig.setup({
			ensure_installed = {}, -- Servers will be configured individually below
			automatic_enable = true,
		})
		vim.lsp.config("emmet_ls", {
			-- configure emmet language server
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
		vim.lsp.config("lua_ls", {
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
					hint = {
						enable = true,
					},
				},
			},
		})

		vim.lsp.config("html", {
			capabilities = capabilities,
			filetypes = { "html", "templ" },
		})

		vim.lsp.config("templ", {
			capabilities = capabilities,
			cmd = { "templ", "lsp" },
			filetypes = { "templ" },
			root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
		})

		vim.lsp.config("tailwindcss", {
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

		vim.lsp.config("helm_ls", {
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
								["https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/argoproj.io/appproject_v1alpha1.json"] = "argocd-*.{yml,yaml}",
								["https://json.schemastore.org/chart.json"] = "Chart.yaml",
							},
							completion = true,
							hover = true,
						},
					},
				},
			},
		})
		vim.lsp.config("yamlls", {
			capabilities = capabilities,
			settings = {
				redhat = { telemetry = { enabled = false } },
				yaml = {
					validate = true,
					schemaStore = {
						enable = false,
						url = "",
					},
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
		vim.lsp.config("gopls", {
			capabilities = capabilities,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			settings = {
				gopls = {
					gofumpt = true,
					codelenses = {
						gc_details = false,
						generate = true,
						regenerate_cgo = true,
						run_govulncheck = true,
						test = true,
						tidy = true,
						upgrade_dependency = true,
						vendor = true,
					},
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
					analyses = {
						nilness = true,
						unusedparams = true,
						unusedwrite = true,
						useany = true,
					},
					usePlaceholders = true,
					completeUnimported = true,
					staticcheck = true,
					directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
					semanticTokens = true,
				},
			},
		})

		vim.lsp.config("ruff", {
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				if client.name == "ruff" then
					client.server_capabilities.hoverProvider = false
				end
				-- You can add ruff-specific keymaps here if needed
			end,
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
		-- Handler for basedpyright (Python language server).
		vim.lsp.config("basedpyright", {
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
}
