-- Ensure the plugin is installed
return {
	"mg979/vim-visual-multi",
	event = "VeryLazy",
	branch = "master",
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
