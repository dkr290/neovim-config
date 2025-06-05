local M = {}

--------------------------------------------------------------------------------
-- LSP Server Discovery and Enabling
--------------------------------------------------------------------------------

--- Gets a list of LSP server names based on .lua files in the lsp config directory.
-- @return table A list of server names (strings).
function M.get_servers_from_config_dir()
	local servers = {}
	local lsp_config_path = vim.fn.stdpath("config") .. "/lsp"

	local lsp_dir_iterator = vim.fs.dir(lsp_config_path)

	if not lsp_dir_iterator then
		vim.notify("LSP config directory not found or error accessing: " .. lsp_config_path, vim.log.levels.WARN)
		return servers
	end

	for filename, filetype in lsp_dir_iterator do
		if filetype == "file" and filename:match("%.lua$") then
			local server_name = filename:gsub("%.lua$", "")
			table.insert(servers, server_name)
		end
	end

	return servers
end

--- Enables LSP servers found in the lsp configuration directory.
-- Uses the new vim.lsp.enable() API from Neovim 0.11+
function M.enable_discovered_servers()
	local servers_to_enable = M.get_servers_from_config_dir()

	if #servers_to_enable > 0 then
		-- vim.notify("Found LSP server configs: " .. table.concat(servers_to_enable, ", "), vim.log.levels.INFO)
		vim.lsp.enable(servers_to_enable)
	else
		vim.notify("No LSP server configurations found in " .. vim.fn.stdpath("config") .. "/lsp/", vim.log.levels.INFO)
	end
end

return M
