local persist_file = vim.fn.stdpath("data") .. "/colorscheme.txt"
local default = "tokyonight"

local function apply_colorscheme(scheme)
	local ok = pcall(vim.cmd, "colorscheme " .. scheme)
	if not ok then
		vim.cmd("colorscheme " .. default)
		local fw = io.open(persist_file, "w")
		if fw then
			fw:write(default)
			fw:close()
		end
		return
	end
	-- refresh devicons with a small delay to ensure highlights are set
	vim.defer_fn(function()
		local ok_icons, devicons = pcall(require, "nvim-web-devicons")
		if ok_icons then
			devicons.setup({ default = true })
			-- force re-highlight all icons
			devicons.set_default_icon("", "#6d8086")
		end
		-- if using mini.icons
		local ok_mini, mini = pcall(require, "mini.icons")
		if ok_mini then
			mini.setup()
			mini.mock_nvim_web_devicons()
		end
		-- refresh bufferline highlights
		local ok_bl, bufferline = pcall(require, "bufferline")
		if ok_bl then
			bufferline.setup()
		end
		vim.cmd("redrawtabline")
		vim.cmd("redraw!")
	end, 200)
end

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
				apply_colorscheme(scheme)
			else
				apply_colorscheme(default)
			end
		else
			apply_colorscheme(default)
		end
	end,
})
