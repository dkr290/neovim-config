local keymap = vim.keymap -- for conciseness
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf, silent = true }

		-- set keybinds
		-- Native LSP references (opens in quickfix list)
		opts.desc = "Show LSP references"
		keymap.set("n", "gR", vim.lsp.buf.references, opts)

		opts.desc = "Go to declaration"
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

		-- Native LSP definition (jumps directly)
		opts.desc = "Go to LSP definition"
		keymap.set("n", "gd", vim.lsp.buf.definition, opts)

		-- Native LSP implementation
		opts.desc = "Show LSP implementations"
		keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

		-- Native LSP type definition
		opts.desc = "Show LSP type definitions"
		keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

		opts.desc = "See available code actions"
		keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

		opts.desc = "Smart rename"
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		-- Native diagnostics for buffer (opens in quickfix)
		opts.desc = "Show buffer diagnostics"
		keymap.set("n", "<leader>D", function()
			vim.diagnostic.setqflist({ bufnr = 0 })
		end, opts)

		opts.desc = "Show line diagnostics"
		keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

		opts.desc = "Go to previous diagnostic"
		keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)

		opts.desc = "Go to next diagnostic"
		keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)

		opts.desc = "Show documentation for what is under cursor"
		keymap.set("n", "K", vim.lsp.buf.hover, opts)

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
	end,
})

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})
vim.filetype.add({
	pattern = {
		[".*%.dockerfile"] = "dockerfile",
	},
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.http",
	callback = function()
		vim.cmd("set filetype=http")
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.templ",
	command = "set filetype=templ",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.dockerfile",
	command = "set filetype=dockerfile",
})

vim.api.nvim_create_augroup("GoFormat", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	command = "silent! !golines --ignore-generated -w %",
	group = "GoFormat",
})
vim.api.nvim_create_user_command("FormatToggleBuffer", function(_)
	-- Get the current buffer number
	local bufnr = vim.api.nvim_get_current_buf()

	-- Toggle the buffer-local variable
	vim.b[bufnr].disable_autoformat = not vim.b[bufnr].disable_autoformat

	-- Display a notification
	local status = vim.b[bufnr].disable_autoformat and "DISABLED" or "ENABLED"
	vim.notify("Autoformat on Save " .. status .. " for current buffer.", vim.log.levels.INFO)
end, {
	desc = "Toggle autoformat on save for current buffer",
})

vim.keymap.set("n", "<leader>uf", ":FormatToggleBuffer<CR>", { desc = "Toggle Autoformat (Buffer)" })
