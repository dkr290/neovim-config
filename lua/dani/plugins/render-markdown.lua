return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- using the mini.nvim suite
	opts = {
		completions = {
			lsp = {
				enabled = true,
			},
		},
		enabled = true,
		-- Visual settings
		style = {
			-- Set to true to show icons for lists, tasks, etc. (requires a dependency like mini.nvim or nvim-web-devicons)
			show_icons = true,
			-- Color for the heading text (e.g., 'Comment', 'Statement', 'Special')
			heading_hl = "Statement",
			-- Color for the text in blockquotes
			blockquote_hl = "Comment",
			-- Color for link text
			link_hl = "Underline",
		},
		-- Options related to rendering, e.g., how to handle tables
		render = {
			-- Align table columns (true by default, good to keep)
			align_table_cols = true,
			-- Maximum width for code blocks. Set to 0 to disable wrapping.
			code_block_max_width = 80,
			-- Wrap text at the specified column width. Set to 0 to disable.
			wrap_width = 80,
		},
		-- Debugging
		debug = {
			-- Set to true to print debug information to the console (useful for troubleshooting)
			enabled = false,
		},
	},
	-- Optional: Automatically open the rendered view when opening a markdown file
	config = function(_, opts)
		require("render-markdown").setup(opts)
		-- Optional Autocmd to open the rendered view automatically
	end,
}
