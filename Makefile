.PHONY: check health

# Parse every Lua file in the configuration without loading plugins.
check:
	NVIM_LOG_FILE="$${TMPDIR:-/tmp}/nvim-config-check.log" nvim --headless -u NONE -i NONE \
		'+lua local files = { "init.lua", "colors/mr5obot-theme.lua" }; vim.list_extend(files, vim.fn.glob("lua/**/*.lua", true, true)); table.sort(files); for _, file in ipairs(files) do local chunk, err = loadfile(file); if not chunk then error(file .. ": " .. err) end end' \
		'+qa!'

# Report which external programs this configuration is missing.
health:
	@nvim --headless '+checkhealth config' '+%print' '+qa!'
