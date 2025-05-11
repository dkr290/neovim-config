return {
	{
		"folke/noice.nvim",
		-- Trigger on the VeryLazy event so that startup isn’t blocked
		event = "VeryLazy",
		-- Plugin options passed directly to require("noice").setup()
		opts = {
			-- Override LSP markdown rendering to use Treesitter (example)
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- Enable some of Noice’s built-in presets (optional)
			presets = {
				bottom_search = true, -- classic bottom cmdline for search
				command_palette = true, -- position cmdline & popupmenu together
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
		},
		dependencies = {
			-- Required for UI rendering
			"MunifTanjim/nui.nvim",
			-- Optional: if you want fancy notification view
			"rcarriga/nvim-notify",
		},
		-- Clear Lazy messages before Noice takes over (optional hack)
		config = function(_, opts)
			if vim.o.filetype == "lazy" then
				vim.cmd("messages clear")
			end
			require("noice").setup(opts)
		end,
	},
}
