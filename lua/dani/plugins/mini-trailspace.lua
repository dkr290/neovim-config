return {
	"echasnovski/mini.trailspace",
	event = { "BufReadPre", "BufNewFile" },
	version = "*",
	config = function()
		local trailspace = require("mini.trailspace")

		trailspace.setup({
			-- Highlight only in normal buffers (ones with empty 'buftype'). This is
			-- useful to not show trailing whitespace where it usually doesn't matter.
			only_in_normal_buffers = true,
		})
	end,
}
