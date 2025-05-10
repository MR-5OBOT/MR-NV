-- return {
--     "hrsh7th/nvim-cmp",
--     event = "InsertEnter",
--     dependencies = {
--         "hrsh7th/cmp-nvim-lsp",
--         "hrsh7th/cmp-buffer",
--         "hrsh7th/cmp-path",
--         "saadparwaiz1/cmp_luasnip",
--         "L3MON4D3/LuaSnip",
--     },
--     config = function()
--         local cmp = require("cmp")
--         local luasnip = require("luasnip")
--
--         cmp.setup({
--             snippet = {
--                 expand = function(args)
--                     luasnip.lsp_expand(args.body)
--                 end,
--             },
--             mapping = cmp.mapping.preset.insert({
--                 ["<C-u>"] = cmp.mapping.scroll_docs(-4),
--                 ["<C-d>"] = cmp.mapping.scroll_docs(4),
--                 ["<C-Space>"] = cmp.mapping.complete(),
--                 ["<C-e>"] = cmp.mapping.abort(),
--                 ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
--                 ["<Tab>"] = cmp.mapping(function(fallback)
--                     if cmp.visible() then
--                         cmp.select_next_item()
--                     elseif luasnip.expand_or_jumpable() then
--                         luasnip.expand_or_jump()
--                     else
--                         fallback()
--                     end
--                 end, { "i", "s" }),
--                 ["<S-Tab>"] = cmp.mapping(function(fallback)
--                     if cmp.visible() then
--                         cmp.select_prev_item()
--                     elseif luasnip.jumpable(-1) then
--                         luasnip.jump(-1)
--                     else
--                         fallback()
--                     end
--                 end, { "i", "s" }),
--             }),
--             sources = cmp.config.sources({
--                 { name = "nvim_lsp", max_item_count = 10 }, -- Reduced max_item_count
--                 { name = "luasnip", max_item_count = 8 },
--                 { name = "buffer", max_item_count = 5 },
--                 { name = "path", max_item_count = 5 },
--             }),
--             window = {
--                 completion = cmp.config.window.bordered(), -- Add borders to completion menu
--                 documentation = cmp.config.window.bordered(), -- Add borders to documentation window
--             },
--             performance = {
--                 debounce = 30, -- Reduced debounce time
--                 throttle = 10, -- Reduced throttle time
--                 fetching_timeout = 80, -- Added to limit fetching time
--                 max_view_entries = 10, -- Limit visible entries
--             },
--         })
--     end,
-- }

return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"saghen/blink.cmp",
		dependencies = { "L3MON4D3/LuaSnip" },
		version = "1.*",
		opts = {
			keymap = {
				preset = "default",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			signature = {
				enabled = true,
				window = {
					show_documentation = false,
				},
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 0,
				},
				menu = {
					scrollbar = false,
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "kind", gap = 1 },
							{ "label_description", gap = 1 },
							{ "source_name", gap = 1 },
						},
						components = {
							kind_icon = {
								ellipsis = false,
								width = { fill = true },
								text = function(ctx)
									local kind_icons = {
										Function = "λ",
										Method = "∂",
										Field = "󰀫",
										Variable = "󰀫",
										Property = "󰀫",
										Keyword = "k",
										Struct = "Π",
										Enum = "τ",
										EnumMember = "τ",
										Snippet = "⊂",
										Text = "τ",
										Module = "⌠",
										Constructor = "∑",
									}
									return kind_icons[ctx.kind] or ctx.kind_icon
								end,
							},
						},
					},
				},
			},
			snippets = {
				preset = "luasnip",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
