return {
	"echasnovski/mini.indentscope",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- symbol = "│",
		options = { try_as_border = true },
	},
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"alpha",
				"dashboard",
				"fzf",
				"help",
				"lazy",
				"lazyterm",
				"mason",
				"neo-tree",
				"notify",
				"toggleterm",
				"Trouble",
				"trouble",
				"mini-starter",
				"NvimTree",
				"snacks_terminal",
				"snacks_dashboard",
				"snacks_notif",
				"snacks_terminal",
				"snacks_win",
			},
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end,
	config = function(_, opts)
		require("mini.indentscope").setup(opts)
	end,
}
