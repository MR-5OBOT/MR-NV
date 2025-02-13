return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false, -- set this if you want to always pull the latest change
	opts = {
		provider = "openai", -- Use OpenAI as the primary provider
		auto_suggestions_provider = "openai", -- Use OpenAI for auto-suggestions
		openai = {
			api_key = "sk-ijklmnop5678efghijklmnop5678efghijklmnop",
			model = "gpt-3.5-turbo", -- Use the free-tier model
			-- temperature = 0.7, -- Adjust for creativity
			-- max_tokens = 2048, -- Adjust for response length
		},
		-- Optional: Add a fallback provider for auto-suggestions
		copilot = {
			enabled = true, -- Use Copilot for auto-suggestions if OpenAI is unavailable
		},
	},
	build = "make",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					use_absolute_path = true,
				},
			},
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
