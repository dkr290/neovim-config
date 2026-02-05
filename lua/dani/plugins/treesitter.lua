return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	version = false,
	build = function()
		local TS = require("nvim-treesitter")
		if TS.update then
			TS.update(nil, { summary = true })
		end
	end,
	event = { "BufReadPre", "BufNewFile", "VeryLazy" },
	cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	opts = {
		indent = { enable = true },
		highlight = { enable = true },
		folds = { enable = true },
		ensure_installed = {
			"bash",
			"c",
			"cmake",
			"diff",
			"dockerfile",
			"gitignore",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"hcl",
			"helm",
			"html",
			"javascript",
			"jsdoc",
			"json",
			"jsonc",
			"latex",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"printf",
			"python",
			"query",
			"regex",
			"templ",
			"terraform",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"xml",
			"yaml",
		},
	},
	config = function(_, opts)
		local TS = require("nvim-treesitter")

		-- Sanity check
		if not TS.get_installed then
			vim.notify("Please update nvim-treesitter to the main branch", vim.log.levels.ERROR)
			return
		end

		-- Setup treesitter
		TS.setup(opts)

		-- Get installed parsers
		local installed = TS.get_installed()
		local installed_set = {}
		for _, lang in ipairs(installed) do
			installed_set[lang] = true
		end

		-- Install missing parsers
		local to_install = vim.tbl_filter(function(lang)
			return not installed_set[lang]
		end, opts.ensure_installed or {})

		if #to_install > 0 then
			TS.install(to_install, { summary = true })
		end

		-- FileType autocmd for highlighting, indents, and folds
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter_config", { clear = true }),
			callback = function(ev)
				local ft = ev.match
				local lang = vim.treesitter.language.get_lang(ft)
				if not lang then
					return
				end

				-- Check if parser is available
				local ok = pcall(vim.treesitter.language.inspect, lang)
				if not ok then
					return
				end

				-- Highlighting
				if opts.highlight and opts.highlight.enable then
					pcall(vim.treesitter.start, ev.buf)
				end

				-- Indentation
				if opts.indent and opts.indent.enable then
					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end

				-- Folds
				if opts.folds and opts.folds.enable then
					vim.wo.foldmethod = "expr"
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				end
			end,
		})

		-- Setup autotag
		require("nvim-ts-autotag").setup()
	end,
}
