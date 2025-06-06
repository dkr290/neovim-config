vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping
-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use item2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- disable some default providers
vim.g["loaded_python_provider"] = 0
vim.g["loaded_python3_provider"] = 0
vim.g["loaded_node_provider"] = 0
vim.g["loaded_perl_provider"] = 0
vim.g["loaded_ruby_provider"] = 0
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<leader>ds",
-- 	"<cmd>lua vim.diagnostic.open_float()<CR>",
-- 	{ noremap = true, silent = true }
-- )

vim.diagnostic.config({
	-- virtual_text = {
	-- 	source = "if_many",
	-- 	spacing = 4,
	-- 	prefix = "●",
	-- },
	virtual_text = true,
	-- virtual_lines = true,
	-- show signs in the sign column (gutter)

	-- underline problematic code
	underline = true,

	-- sort diagnostics by severity (so errors appear before warnings, etc.)
	severity_sort = true,

	-- control updates while typing
	update_in_insert = false,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "if_many",
		header = "",
		prefix = "",
	},

	-- configure floating window behavior when you call vim.diagnostic.open_float()
})
local signs = {
	Error = "",
	Warn = "",
	Info = "",
	Hint = "",
}
for type, icon in pairs(signs) do
	vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type })
end
