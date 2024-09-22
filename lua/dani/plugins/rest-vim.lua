return {
	"rest-nvim/rest.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	ft = "http",
	config = function()
		vim.g.rest_nvim = {
			-- Example configuration
			result_split_horizontal = false,
			result_split_in_place = false,
			skip_ssl_verification = false,
			encode_url = true,
			highlight = {
				enabled = true,
				timeout = 150,
			},
			result = {
				show_url = true,
				show_http_info = true,
				show_headers = true,
				formatters = {
					json = "jq",
					html = function(body)
						return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
					end,
				},
			},
		}

		-- Set up keymaps
		vim.api.nvim_set_keymap(
			"n",
			"<leader>rl",
			":RestNvimLast<CR>",
			{ noremap = true, silent = true, desc = "Re-run last request" }
		)
		vim.api.nvim_set_keymap("n", "<Leader>rr", ":RestNvim<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<Leader>rp", ":RestNvimPreview<CR>", { noremap = true, silent = true })
	end,
}
