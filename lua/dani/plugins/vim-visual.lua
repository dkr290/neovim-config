-- Ensure the plugin is installed
return {
	"mg979/vim-visual-multi",
	event = "VeryLazy",
	branch = "master",
	keys = {
		{
			"<leader>mc",
			function()
				vim.cmd("call vm#commands#add_cursor_down(0, 0)")
			end,
			desc = "Add cursor down",
		},
		{
			"<leader>mC",
			function()
				vim.cmd("call vm#commands#add_cursor_up(0, 0)")
			end,
			desc = "Add cursor up",
		},
		{
			"<leader>mn",
			function()
				vim.cmd("call vm#commands#find_next(0, 0)")
			end,
			desc = "Find next occurrence",
		},
		{
			"<leader>mN",
			function()
				vim.cmd("call vm#commands#find_prev(0, 0)")
			end,
			desc = "Find previous occurrence",
		},
		{
			"<leader>ms",
			function()
				vim.cmd("call vm#commands#select_all(0)")
			end,
			desc = "Select all occurrences",
		},
		{
			"<leader>mq",
			function()
				vim.cmd("call vm#commands#remove_cursor(0, 0)")
			end,
			desc = "Remove last cursor",
		},
	},
	config = function()
		vim.g.VM_maps = {
			["Find Under"] = "<C-n>",
			["Find Subword Under"] = "<C-n>",
			["Select All"] = "<C-c>",
			["Select h"] = "<C-Left>",
			["Select l"] = "<C-Right>",
			["Add Cursor Down"] = "<C-Down>",
			["Add Cursor Up"] = "<C-Up>",
			["Add Cursor At Pos"] = "<C-x>",
			["Visual Cursors"] = "<Leader>c",
		}

		vim.g.VM_theme = "ocean"
		vim.g.VM_highlight_matches = "underline"
	end,
}
