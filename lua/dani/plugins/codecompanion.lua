return {
	"olimorris/codecompanion.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"ravitemer/codecompanion-history.nvim", -- Save and load conversation history
		"j-hui/fidget.nvim",
		{
			"ravitemer/mcphub.nvim", -- Manage MCP servers
			cmd = "MCPHub",
			build = "npm install -g mcp-hub@latest",
			config = true,
		},
	},

	config = function()
		-- Add an autocmd to show a "Thinking..." message when CodeCompanion starts processing
		local progress = require("fidget.progress")
		local handles = {}
		local group = vim.api.nvim_create_augroup("CodeCompanionFidget", {})
		vim.api.nvim_create_autocmd("User", {
			pattern = "CodeCompanionRequestStarted",
			callback = function(e)
				handles[e.data.id] = progress.handle.create({
					title = "CodeCompanion",
					message = "Thinking...",
					lsp_client = { name = e.data.adapter.formatted_name },
				})
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "CodeCompanionRequestFinished",
			group = group,
			callback = function(e)
				local h = handles[e.data.id]
				if h then
					h.message = e.data.status == "success" and "Done" or "Failed"
					h:finish()
					handles[e.data.id] = nil
				end
			end,
		})
		require("codecompanion").setup({
			opts = {
				system_prompt = function()
					return "You are a senior expert in DevOps, golang , cloud , python neovim. Provide concise and correct code suggestions and completions. Focus on efficiency and best practices."
				end,
			},
			display = {
				chat = {
					render_headers = false,
					show_settings = false,
					provider = "snacks",
					prompt = "Prompt",
					opts = {
						show_default_actions = true, -- Show the default actions in the action palette?
						show_default_prompt_library = true, -- Show the default prompt library in the action palette?
						title = "CodeCompanion actions", -- The title of the action palette
					},
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
					keymaps = {
						send = {
							modes = { n = { "<C-s>", "<CR>" }, i = "<C-s>" },
							opts = {},
						},
						close = {
							modes = { n = "<C-c>", i = "<C-c>" },
							opts = {},
						},
					},
				},
				inline = {
					adapter = "copilot",
					keymaps = {
						accept_change = {
							modes = { n = "ga" },
							description = "Accept the suggested change",
						},
						reject_change = {
							modes = { n = "gr" },
							opts = { nowait = true },
							description = "Reject the suggested change",
						},
					},
				},
			},

			adapters = {
				http = {
					opts = {
						show_model_choices = true,
					},
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
									default = "gemini-2.5-flash",
								},
							},
						})
					end,
					openai = function()
						return require("codecompanion.adapters").extend("openai", {
							env = {
								api_key = os.getenv("OPENAI_API_KEY"), -- from env
							},
							schema = {
								model = {
									default = "gpt-4o",
								},
							},
						})
					end,
				},
			},
		})
	end,
}
