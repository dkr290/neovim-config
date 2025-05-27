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
			copilot = { "gpt-4o", "gpt-4.1", "gemini-2.5-pro" },
			deepseek = { "deepseek-chat", "deepseek-reasoner" },
			gemini = { "gemini-2.0-flash" },
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
