return {
	"echasnovski/mini.bufremove",

	keys = {
		{
			"<leader>bd",
			function()
				local bd = require("mini.bufremove").delete
				if vim.bo.modified then
					local choice =
						vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
					if choice == 1 then -- Yes
						vim.cmd.write()
						bd(0)
					elseif choice == 2 then -- No
						bd(0, true)
					end
				else
					bd(0)
				end
			end,
			desc = "Delete Buffer",
		},
    -- stylua: ignore
    { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
		-- Map <leader>bF to remove all buffers
		{
			"<leader>bF",
			function()
				-- Close all buffers using a loop
				local bufremove = require("mini.bufremove")
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
						bufremove.delete(buf, false) -- Remove buffer without confirmation
					end
				end
			end,
			desc = "Delete All Buffers",
		},
		-- New mappings for switching buffers
		{
			"<leader>bN",
			function()
				vim.cmd("bnext")
			end,
			desc = "Next Buffer",
		},
		{
			"<leader>bp",
			function()
				vim.cmd("bprev")
			end,
			desc = "Previous Buffer",
		},
	},
}
