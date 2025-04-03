return {
	"github/copilot.vim",
	-- disable copilot by default
	lazy = true,
	keys = { "<leader>cp" },
	config = function()
		vim.cmd("Copilot setup")
		print("Copilot setup 🤖")
		vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
			expr = true,
			replace_keycodes = false,
		})
		vim.keymap.set("n", "<leader>cd", function()
			vim.cmd(":Copilot disable")
			print("Copilot deactivated 🔥")
		end, {
			desc = "Disable Copilot",
		})
		vim.keymap.set("n", "<leader>cp", function()
			vim.cmd(":Copilot enable")
			print("Copilot enabled 🤖")
		end, {
			desc = "Enable Copilot",
		})
	end,
}
