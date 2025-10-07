return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		preset = "helix", -- Show the menu as a vertical bar on the left side

		-- Optional: Other good defaults
		delay = 100, -- Shorter delay (ms) after pressing a prefix key
		show_keys = true, -- Show the key itself in the group title  },
	},
}
