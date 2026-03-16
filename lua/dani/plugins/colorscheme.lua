return {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			style = "night",
			on_colors = function(colors)
				colors.bg = "#011628"
				colors.bg_dark = "#011423"
				colors.bg_float = "#011423"
				colors.bg_highlight = "#143652"
				colors.bg_popup = "#011423"
				colors.bg_search = "#0A64AC"
				colors.bg_sidebar = "#011423"
				colors.bg_statusline = "#011423"
				colors.bg_visual = "#275378"
				colors.border = "#547998"
				colors.fg = "#CBE0F0"
				colors.fg_dark = "#B4D0E9"
				colors.fg_float = "#CBE0F0"
				colors.fg_gutter = "#627E97"
				colors.fg_sidebar = "#B4D0E9"
			end,
		},
	},
	-- Catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			transparent_background = false,
			integrations = {
				cmp = true,
				gitsigns = true,
				treesitter = true,
				telescope = { enabled = true },
			},
		},
	},

	-- Kanagawa
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		opts = {
			theme = "wave", -- wave, dragon, lotus
			background = { dark = "wave", light = "lotus" },
		},
	},

	-- Rose Pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		opts = {
			variant = "moon", -- auto, main, moon, dawn
			dark_variant = "moon",
		},
	},

	-- Nightfox
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		opts = {
			options = {
				transparent = false,
				styles = {
					comments = "italic",
					keywords = "bold",
				},
			},
		},
	},

	-- Everforest
	{
		"sainnhe/everforest",
		priority = 1000,
		config = function()
			vim.g.everforest_background = "hard" -- soft, medium, hard
			vim.g.everforest_better_performance = 1
		end,
	},

	-- Gruvbox Material
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "hard" -- soft, medium, hard
			vim.g.gruvbox_material_better_performance = 1
		end,
	},

	-- Gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		opts = {
			contrast = "hard", -- soft, medium, hard
		},
	},

	-- GitHub Theme
	{
		"projekt0n/github-nvim-theme",
		priority = 1000,
		config = function()
			require("github-theme").setup({})
		end,
	},

	-- Night Owl
	{
		"oxfist/night-owl.nvim",
		priority = 1000,
		opts = {
			bold = true,
			italics = true,
			underline = true,
		},
	},
}
