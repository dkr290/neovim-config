local curl = require("plenary.curl")

local M = {
	schemas_catalog = "datreeio/CRDs-catalog",
	schema_catalog_branch = "main",
	github_base_api_url = "https://api.github.com/repos",
	github_headers = {
		Accept = "application/vnd.github+json",
		["X-GitHub-Api-Version"] = "2022-11-28",
	},
}

M.schema_url = "https://raw.githubusercontent.com/" .. M.schemas_catalog .. "/" .. M.schema_catalog_branch

M.list_github_tree = function()
	local url = M.github_base_api_url .. "/" .. M.schemas_catalog .. "/git/trees/" .. M.schema_catalog_branch
	local response = curl.get(url, { headers = M.github_headers, query = { recursive = 1 } })

	if response.status ~= 200 then
		vim.notify("Failed to fetch CRD catalog: " .. response.status, vim.log.levels.ERROR)
		return {}
	end

	local body = vim.fn.json_decode(response.body)
	local trees = {}
	for _, tree in ipairs(body.tree) do
		if tree.type == "blob" and tree.path:match("%.json$") then
			table.insert(trees, tree.path)
		end
	end
	return trees
end

M.select_crd_schema = function()
	-- Check if we're in a YAML file
	local filetype = vim.bo.filetype
	if filetype ~= "yaml" and filetype ~= "yml" then
		vim.notify("CRD schema selector only works with YAML files", vim.log.levels.WARN)
		return
	end

	vim.notify("Fetching CRD schemas...", vim.log.levels.INFO)
	local all_crds = M.list_github_tree()

	if #all_crds == 0 then
		vim.notify("No CRD schemas found or failed to fetch", vim.log.levels.ERROR)
		return
	end

	vim.ui.select(all_crds, {
		prompt = "Select CRD Schema: ",
		format_item = function(item)
			-- Format the display to show just the CRD name nicely
			return item:gsub("%.json$", ""):gsub("/", " > ")
		end,
	}, function(selection)
		if not selection then
			vim.notify("Schema selection canceled", vim.log.levels.INFO)
			return
		end

		local schema_url = M.schema_url .. "/" .. selection
		local schema_modeline = "# yaml-language-server: $schema=" .. schema_url

		-- Add schema modeline at the top of the file
		vim.api.nvim_buf_set_lines(0, 0, 0, false, { schema_modeline })

		-- Move cursor to after the modeline
		vim.api.nvim_win_set_cursor(0, { 2, 0 })

		vim.notify("Added CRD schema: " .. selection:gsub("%.json$", ""), vim.log.levels.INFO)
	end)
end

return M
