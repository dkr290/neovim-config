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
		-- Function to select model dynamically
		_G.select_model = function()
			local models = {
				"gemini-2.5-pro",
				"gemini-2.0-flash",
				"claude-sonnet-4-0",
				"gpt-4o",
				"gpt-4.1",
				"deepseek-chat",
				"deepseek-reasoner",
			}

			vim.ui.select(models, { prompt = "Select a model" }, function(choice)
				if choice then
					require("codecompanion").setup({
						adapters = {
							copilot = function()
								return require("codecompanion.adapters").extend("copilot", {
									schema = {
										model = {
											default = choice,
										},
									},
								})
							end,
						},
					})
				end
			end)
		end
		-- Call select_model during setup

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
			strategies = {
				chat = {
					adapter = "copilot",
					slash_commands = {
						["file"] = {
							opts = {
								provider = "snacks",
							},
						},
						["buffer"] = {
							opts = {
								provider = "snacks",
							},
						},
					},
				},
				inline = {
					adapter = "copilot",
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
