return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.2.1",
	lazy = true,
	cmd = "Telescope",
	keys = {
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files({
					follow = false,
					find_command = {
						"rg",
						"--files",
						"--glob",
						"!.git/**",
						"--iglob",
						"!*.{png,jpg,jpeg,gif,bmp,webp,avif,heic,ico,tif,tiff,svg,mp3,wav,flac,ogg,opus,m4a,aac,wma,mid,midi,mp4,m4v,mkv,avi,mov,webm,wmv,flv,mpeg,mpg,3gp,pdf,zip,rar,7z,tar,gz,bz2,xz,zst,tgz,iso,ttf,otf,woff,woff2,eot,exe,dll,so,dylib,bin,o,obj,a,lib,class,jar,war,pyc,pyo,wasm,db,sqlite,sqlite3,doc,docx,xls,xlsx,ppt,pptx,odt,ods,odp,apk,aab,ipa,deb,rpm,dmg,glb,fbx,blend,stl,npy,npz,pkl,parquet}",
					},
				})
			end,
			desc = "Find Editable Files",
		},
		{ "<leader>,", "<cmd>Telescope buffers<cr>", desc = "List Buffers" },
		{ "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
		{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
		{ "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
		{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local actions = require("telescope.actions")
		local telescope = require("telescope")

		telescope.setup({
			defaults = {

				file_ignore_patterns = {
					"^.git/",
					"^node_modules/",
					"^.DS_Store",
					"%.lock",
					"^env/",
					"^.env/",
				},
				layout_config = {
					horizontal = {
						prompt_position = "bottom",
						width = 0.5,
						height = 0.8,
						preview_width = 0.5,
					},
				},
				prompt_prefix = "   ",
				selection_caret = " ",
				entry_prefix = "  ",
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				-- borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
				border = true,
				results_title = false,
				preview_title = false,
				preview = {
					treesitter = false,
				},
				winblend = 0,
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<esc>"] = actions.close,
						["<C-c>"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					-- theme = "dropdown",
					hidden = true,
					previewer = true,
					follow = true, -- <--- This line is important

					layout_config = {
						width = 0.7,
						height = 0.6,
					},
				},
				buffers = {
					theme = "ivy",
					previewer = false,
					sort_lastused = true,
					layout_config = {
						width = 0.4,
						height = 0.4,
					},
				},
				help_tags = {
					theme = "ivy",
					previewer = true,
					layout_config = {
						width = 0.85,
						height = 0.6,
						prompt_position = "top",
					},
				},
				keymaps = {
					theme = "ivy",
					previewer = false,
				},
				commands = {
					theme = "ivy",
					previewer = false,
				},
				live_grep = {
					theme = "ivy",
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob",
						"!{.git,node_modules,dist,build,.venv}/*",
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		-- Load extensions
		telescope.load_extension("fzf")

		-- Clean UI colors for Monochrome
		local border_color = "#444444" -- Dark grey for a subtle look
		local text_dim = "#666666"

		local highlights = {
			TelescopeNormal = { bg = "NONE" },
			TelescopeBorder = { fg = border_color, bg = "NONE" },
			TelescopePromptNormal = { bg = "NONE" },
			TelescopePromptBorder = { fg = border_color, bg = "NONE" },
			TelescopePromptTitle = { fg = "#999999", bold = true },
			TelescopeResultsBorder = { fg = border_color, bg = "NONE" },
			TelescopeResultsTitle = { fg = text_dim },
			TelescopePreviewBorder = { fg = border_color, bg = "NONE" },
			TelescopePreviewTitle = { fg = border_color },
		}

		for group, hl in pairs(highlights) do
			vim.api.nvim_set_hl(0, group, hl)
		end
	end,
}
