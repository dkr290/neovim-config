local persist_file = vim.fn.stdpath("data") .. "/colorscheme.txt"
local default = "tokyonight"

-- Save colorscheme when it changes
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local f = io.open(persist_file, "w")
		if f then
			f:write(vim.g.colors_name or default)
			f:close()
		end
	end,
})

-- Restore on startup after plugins are loaded
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		local f = io.open(persist_file, "r")
		if f then
			local scheme = f:read("*l")
			f:close()
			if scheme and scheme ~= "" then
				local ok = pcall(vim.cmd, "colorscheme " .. scheme)
				if not ok then
					-- saved scheme failed, reset to default
					vim.cmd("colorscheme " .. default)
					local fw = io.open(persist_file, "w")
					if fw then
						fw:write(default)
						fw:close()
					end
				end
			else
				vim.cmd("colorscheme " .. default)
			end
		else
			vim.cmd("colorscheme " .. default)
		end
	end,
})
