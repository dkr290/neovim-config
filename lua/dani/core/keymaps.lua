--v set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Map leader + d to diff two files in a vertical split
-- Diff file management with leader key
keymap.set("n", "<Leader>dm", ":diffthis<CR>", { noremap = true, silent = true }) -- Open the vertical split

------------------------------- CodeCompanion mappings -----------------------------------
keymap.set(
	"n",
	"<leader>cA",
	"<cmd>CodeCompanionActions<CR>",
	{ desc = "Trigger Code Companion Actions", silent = true }
)
keymap.set(
	"v",
	"<leader>cA",
	"<cmd>CodeCompanionActions<CR>",
	{ desc = "Trigger Code Companion Actions in Visual Mode", silent = true }
)
keymap.set(
	"n",
	"<leader>cc",
	"<cmd>CodeCompanionChat Toggle<CR>",
	{ desc = "Toggle Code Companion Chat", silent = true }
)
keymap.set(
	"v",
	"<leader>cc",
	"<cmd>CodeCompanionChat Toggle<CR>",
	{ desc = "Toggle Code Companion Chat in Visual Mode", silent = true }
)
keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<CR>", { desc = "Add to Code Companion Chat", silent = true })

-- Keymap to trigger model and provider selection
vim.api.nvim_set_keymap("n", "<leader>pm", ":lua _G.select_provider()<CR>", { noremap = true, silent = true })

------------------------------ LSP Debug mappings -----------------------------------
keymap.set("n", "<leader>lS", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		print("No LSP clients attached to current buffer")
		return
	end

	for _, client in ipairs(clients) do
		print("LSP Client:", client.name)
		if client.config.settings then
			if client.config.settings.yaml then
				print("YAML schemas:", vim.inspect(client.config.settings.yaml.schemas or {}))
			end
			if client.config.settings.json then
				print("JSON schemas:", vim.inspect(client.config.settings.json.schemas or {}))
			end
		end
	end
end, { desc = "Show LSP schemas for current buffer" })

------------------------------ Schema Selector mappings -----------------------------------
keymap.set("n", "<leader>ys", function()
	require("dani.plugins.helpers.schema").select_crd_schema()
end, { desc = "Select YAML CRD Schema" })

keymap.set("n", "<Leader>mc", ":MCPHub<CR>", { noremap = true, silent = true })
