-- lsp
vim.lsp.enable({ "lua_ls", "tsgo", "basedpyright" })
vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "single", winhighlight = "FloatBorder:Whitespace", anchor_bias = "below" })
		end, { buffer = ev.buf, silent = true, desc = "Hover documentation" })
		if client ~= nil and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
		if client ~= nil and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
		end
	end,
})

vim.cmd("set completeopt+=noselect")
