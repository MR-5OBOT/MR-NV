local command = {
	"rg",
	"--files",
	"--hidden",
	"--glob",
	"!.git/**",
	"--glob",
	"!node_modules/**",
	"--glob",
	"!.cache/**",
	"--glob",
	"!dist/**",
	"--glob",
	"!build/**",
	"--glob",
	"!*.tmp",
	"--glob",
	"!*.log",
}

function _G.native_find(text, _)
	local result = vim.system(command, { text = true }):wait()
	if result.code ~= 0 then
		return {}
	end
	return vim.fn.matchfuzzy(vim.split(result.stdout, "\n", { trimempty = true }), text)
end
vim.opt.findfunc = "v:lua.native_find"

vim.keymap.set("n", "<leader>f", ":find ", { silent = false })
