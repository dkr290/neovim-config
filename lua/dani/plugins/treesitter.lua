return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local ts = require("nvim-treesitter")

		-- Using .setup with ensure_installed is the "Quiet" way.
		-- It checks if the parser exists on disk first.
		ts.setup({
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"bash",
				"latex",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
				"helm",
				"go",
				"gomod",
				"gowork",
				"gosum",
				"terraform",
				"cmake",
				"hcl",
				"templ",
			},
			-- This is the key: set this to false to stop the automatic
			-- background compilation on every single startup.
			auto_install = false,
		})

		-- Manually enable the colors/indent via autocmd
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
				if lang then
					pcall(vim.treesitter.start)
				end
			end,
		})

		require("nvim-ts-autotag").setup()
	end,
}
