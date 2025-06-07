return {
	"olimorris/codecompanion.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"ravitemer/codecompanion-history.nvim", -- Save and load conversation history
		{
			"ravitemer/mcphub.nvim", -- Manage MCP servers
			cmd = "MCPHub",
			build = "npm install -g mcp-hub@latest",
			config = true,
		},
	},

	config = function()
		-- Define available providers and their models
		local providers = {
			copilot = {
				"gpt-4o", -- OpenAI
				"gpt-4.1", -- OpenAI
				"o3-mini", -- OpenAI
				"o4-mini", -- OpenAI
				"claude-3.5-sonnet", -- Anthropic
				"claude-3.7-sonnet", -- Anthropic
				"claude-sonnet-4", -- Anthropic
				"claude-opus-4", -- Anthropic
				"gemini-2.0-flash", -- Google
				"gemini-2.5-pro", -- Google
				"o1", -- OpenAI preview
				"o3", -- OpenAI preview
				"gpt-4.5", -- OpenAI preview
			},
			deepseek = { "deepseek-chat", "deepseek-reasoner" },
			gemini = { "gemini-2.0-flash", "gemini-2.5-pro", "gemini-2.5-flash-preview-05-20" },
		}

		-- Function to select provider dynamically
		_G.select_provider = function()
			local provider_names = vim.tbl_keys(providers)
			vim.ui.select(provider_names, { prompt = "Select a provider" }, function(provider_choice)
				if provider_choice then
					_G.selected_provider = provider_choice
					_G.select_model(provider_choice)
				end
			end)
		end

		-- Function to select model dynamically based on provider
		_G.select_model = function(provider_choice)
			local models = providers[provider_choice]
			vim.ui.select(models, { prompt = "Select a model" }, function(model_choice)
				if model_choice then
					_G.selected_model = model_choice
					require("codecompanion").setup({
						strategies = {
							chat = {
								adapter = _G.selected_provider,
								tools = {
									["mcp"] = {
										callback = function()
											return require("mcphub.extensions.codecompanion")
										end,
										opts = {
											requires_approval = true,
											temperature = 0.7,
										},
									},
								},
								slash_commands = {
									["file"] = {
										opts = {
											provider = _G.selected_provider,
										},
									},
									["buffer"] = {
										opts = {
											provider = _G.selected_provider,
										},
									},
								},
							},
							inline = {
								adapter = _G.selected_provider,
							},
						},
						adapters = {
							[_G.selected_provider] = function()
								return require("codecompanion.adapters").extend(_G.selected_provider, {
									schema = {
										model = { default = _G.selected_model },
									},
								})
							end,
						},
					})
				end
			end)
		end
		require("codecompanion").setup({
			display = {
				chat = {
					render_headers = false,
					show_settings = true,
				},
			},
			extensions = {
				history = {
					enabled = true,
					opts = {
						keymap = "gh",
						auto_generate_title = true,
						continue_last_chat = false,
						delete_on_clearing_chat = false,
						picker = "snacks",
						enable_logging = false,
						dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
					},
				},
				mcphub = {
					callback = "mcphub.extensions.codecompanion",
					opts = {
						make_vars = true,
						make_slash_commands = true,
						show_result_in_chat = true,
					},
				},
			},

			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "gemini-2.5-pro",
							},
						},
					})
				end,
				deepseek = function()
					return require("codecompanion.adapters").extend("deepseek", {
						env = {
							api_key = os.getenv("DEEPSEEK_API_KEY"),
						},
						schema = {
							model = {
								default = "deepseek-chat",
							},
						},
					})
				end,
				gemini = function()
					return require("codecompanion.adapters").extend("gemini", {
						env = {
							api_key = os.getenv("GEMINI_API_KEY"), -- from env
						},
						schema = {
							model = {
								default = "gemini-2.0-flash",
							},
						},
					})
				end,
			},
		})
	end,
}
