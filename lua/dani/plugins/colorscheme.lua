return {
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			local bg = "#011628"
			local bg_dark = "#011423"
			local bg_highlight = "#143652"
			local bg_search = "#0A64AC"
			local bg_visual = "#275378"
			local fg = "#CBE0F0"
			local fg_dark = "#B4D0E9"
			local fg_gutter = "#627E97"
			local border = "#547998"

			require("tokyonight").setup({
				style = "night",
				on_colors = function(colors)
					colors.bg = bg
					colors.bg_dark = bg_dark
					colors.bg_float = bg_dark
					colors.bg_highlight = bg_highlight
					colors.bg_popup = bg_dark
					colors.bg_search = bg_search
					colors.bg_sidebar = bg_dark
					colors.bg_statusline = bg_dark
					colors.bg_visual = bg_visual
					colors.border = border
					colors.fg = fg
					colors.fg_dark = fg_dark
					colors.fg_float = fg
					colors.fg_gutter = fg_gutter
					colors.fg_sidebar = fg_dark
				end,
			})
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
}

-- 	-- Catppuccin
-- 	{
-- 		"catppuccin/nvim",
-- 		name = "catppuccin",
-- 		priority = 1000,
-- 		opts = {
-- 			flavour = "mocha", -- latte, frappe, macchiato, mocha
-- 			transparent_background = false,
-- 			integrations = {
-- 				cmp = true,
-- 				gitsigns = true,
-- 				treesitter = true,
-- 				telescope = { enabled = true },
-- 			},
-- 		},
-- 	},
--
-- 	-- Kanagawa
-- 	{
-- 		"rebelot/kanagawa.nvim",
-- 		priority = 1000,
-- 		opts = {
-- 			theme = "wave", -- wave, dragon, lotus
-- 			background = { dark = "wave", light = "lotus" },
-- 		},
-- 	},
--
-- 	-- Rose Pine
-- 	{
-- 		"rose-pine/neovim",
-- 		name = "rose-pine",
-- 		priority = 1000,
-- 		opts = {
-- 			variant = "moon", -- auto, main, moon, dawn
-- 			dark_variant = "moon",
-- 		},
-- 	},
--
-- 	-- Nightfox
-- 	{
-- 		"EdenEast/nightfox.nvim",
-- 		priority = 1000,
-- 		opts = {
-- 			options = {
-- 				transparent = false,
-- 				styles = {
-- 					comments = "italic",
-- 					keywords = "bold",
-- 				},
-- 			},
-- 		},
-- 	},
--
-- 	-- Everforest
-- 	{
-- 		"sainnhe/everforest",
-- 		priority = 1000,
-- 		config = function()
-- 			vim.g.everforest_background = "hard" -- soft, medium, hard
-- 			vim.g.everforest_better_performance = 1
-- 		end,
-- 	},
--
-- 	-- Gruvbox Material
-- 	{
-- 		"sainnhe/gruvbox-material",
-- 		priority = 1000,
-- 		config = function()
-- 			vim.g.gruvbox_material_background = "hard" -- soft, medium, hard
-- 			vim.g.gruvbox_material_better_performance = 1
-- 		end,
-- 	},
--
-- 	-- Gruvbox
-- 	{
-- 		"ellisonleao/gruvbox.nvim",
-- 		priority = 1000,
-- 		opts = {
-- 			contrast = "hard", -- soft, medium, hard
-- 		},
-- 	},
--
-- 	-- GitHub Theme
-- 	{
-- 		"projekt0n/github-nvim-theme",
-- 		priority = 1000,
-- 		config = function()
-- 			require("github-theme").setup({})
-- 		end,
-- 	},
--
-- 	-- Night Owl
-- 	{
-- 		"oxfist/night-owl.nvim",
-- 		priority = 1000,
-- 		opts = {
-- 			bold = true,
-- 			italics = true,
-- 			underline = true,
-- 		},
-- 	},
