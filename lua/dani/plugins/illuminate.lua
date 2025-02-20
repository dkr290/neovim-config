return {
	"RRethy/vim-illuminate",
	config = function()
		require("illuminate").configure({
			delay = 200, -- Delay before highlighting
			under_cursor = true, -- Highlight word under cursor
		})

		-- Global Toggle Variable
		vim.g.illuminate_enabled = false
		vim.cmd("IlluminatePause")
		-- Toggle Function
		vim.keymap.set("n", "<leader>mm", function()
			vim.g.illuminate_enabled = not vim.g.illuminate_enabled
			if vim.g.illuminate_enabled then
				vim.cmd("IlluminateResume") -- Enable highlighting
			else
				vim.cmd("IlluminatePause") -- Disable highlighting
			end
			print("Illuminate: " .. (vim.g.illuminate_enabled and "ON" or "OFF"))
		end, { noremap = true, silent = true })
	end,
}
