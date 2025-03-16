return {
	-- HTTP REST-Client Interface
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },
	opts = {
		-- cURL path
		-- if you have curl installed in a non-standard path,
		-- you can specify it here
		curl_path = "curl",

		-- split direction
		-- possible values: "vertical", "horizontal"
		split_direction = "vertical",

		-- default_view, body or headers or headers_body
		default_view = "headers_body",

		-- dev, test, prod, can be anything
		-- see: https://learn.microsoft.com/en-us/aspnet/core/test/http-files?view=aspnetcore-8.0#environment-files
		default_env = "dev",

		-- enable/disable debug mode
		debug = false,

		-- default formatters/pathresolver for different content types
		contenttypes = {
			["application/json"] = {
				ft = "json",
				formatter = vim.fn.executable("jq") == 1 and { "jq", "." },
				pathresolver = function(...)
					return require("kulala.parser.jsonpath").parse(...)
				end,
			},
			["application/xml"] = {
				ft = "xml",
				formatter = { "xmllint", "--format", "-" },
				pathresolver = { "xmllint", "--xpath", "{{path}}", "-" },
			},
			["text/html"] = {
				ft = "html",
				formatter = { "xmllint", "--format", "--html", "-" },
				pathresolver = {},
			},
		},

		-- can be used to show loading, done and error icons in inlay hints
		-- possible values: "on_request", "above_request", "below_request", or nil to disable
		-- If "above_request" or "below_request" is used, the icons will be shown above or below the request line
		-- Make sure to have a line above or below the request line to show the icons
		ui = {
			-- display mode: possible values: "split", "float"
			display_mode = "split",
			-- split direction: possible values: "vertical", "horizontal"
			split_direction = "vertical",
			-- default view: "body" or "headers" or "headers_body" or "verbose" or fun(response: Response)
			default_view = "body",
			-- enable winbar
			winbar = true,
			-- Specify the panes to be displayed by default
			-- Current available pane contains { "body", "headers", "headers_body", "script_output", "stats", "verbose", "report", "help" },
			default_winbar_panes = { "body", "headers", "headers_body", "verbose", "script_output", "report", "help" },
			-- enable/disable variable info text
			-- this will show the variable name and value as float
			-- possible values: false, "float"
			show_variable_info_text = false,
			-- icons position: "signcolumn"|"on_request"|"above_request"|"below_request" or nil to disable
			show_icons = "on_request",
			-- default icons
			icons = {
				inlay = {
					loading = "⏳",
					done = "✅",
					error = "❌",
				},
				lualine = "🐼",
				textHighlight = "WarningMsg", -- highlight group for request elapsed time
			},

			-- enable/disable request summary in the output window
			show_request_summary = true,
			-- disable notifications of script output
			disable_script_print_output = false,

			-- additional cURL options
			-- see: https://curl.se/docs/manpage.html
			additional_curl_options = {},

			-- scratchpad default contents
			scratchpad_default_contents = {
				"@MY_TOKEN_NAME=my_token_value",
				"",
				"# @name scratchpad",
				"POST https://httpbin.org/post HTTP/1.1",
				"accept: application/json",
				"content-type: application/json",
				"",
				"{",
				'  "foo": "bar"',
				"}",
			},

			-- enable winbar

			-- Specify the panes to be displayed by default
			-- Current avaliable pane contains { "body", "headers", "headers_body", "script_output" },

			-- enable reading vscode rest client environment variables
			vscode_rest_client_environmentvars = false,

			-- disable the vim.print output of the scripts
			-- they will be still written to disk, but not printed immediately
			-- set scope for environment and request variables
			-- possible values: b = buffer, g = global
			environment_scope = "b",
		},
	},
	-- Set up keybindings for Kulala commands
	config = function(_, opts)
		require("kulala").setup(opts)
		-- Keybinding to run the current request
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "http", "rest" }, -- Trigger only in these filetypes
			callback = function()
				-- Set buffer-local keymaps for Kulala commands
				vim.api.nvim_buf_set_keymap(
					0,
					"n",
					"<leader>kr",
					"<cmd>lua require('kulala').run()<CR>",
					{ noremap = true, silent = true }
				)
				vim.api.nvim_buf_set_keymap(
					0,
					"n",
					"<leader>kp",
					"<cmd>lua require('kulala').jump_prev()<CR>",
					{ noremap = true, silent = true }
				)
				vim.api.nvim_buf_set_keymap(
					0,
					"n",
					"<leader>kn",
					"<cmd>lua require('kulala').jump_next()<CR>",
					{ noremap = true, silent = true, desc = "Jump to the next request" }
				)
				vim.api.nvim_buf_set_keymap(
					0,
					"n",
					"<leader>ki",
					"<cmd>lua require('kulala').inspect()<CR>",
					{ noremap = true, silent = true, desc = "Inspect the current request" }
				)
			end,
		})
	end,
}
