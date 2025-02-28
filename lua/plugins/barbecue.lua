return {
	"utilyre/barbecue.nvim",
	-- name = "barbecue",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		theme = {
			-- (e.g. basename will look like this: { fg = "#c0caf5", bold = true })
			normal = { fg = "#c0caf5" },

			-- these highlights correspond to symbols table from config
			ellipsis = { fg = "#737aa2" },
			separator = { fg = "#737aa2" },
			modified = { fg = "#737aa2" },

			-- these highlights represent the _text_ of three main parts of barbecue
			dirname = { fg = "#737aa2" },
			basename = { bold = true },
			context = {},

			-- these highlights are used for context/navic icons
			context_file = { fg = "#B04D6E" },
			context_module = { fg = "#B04D6E" },
			context_namespace = { fg = "#B04D6E" },
			context_package = { fg = "#B04D6E" },
			context_class = { fg = "#B04D6E" },
			context_method = { fg = "#B04D6E" },
			context_property = { fg = "#B04D6E" },
			context_field = { fg = "#B04D6E" },
			context_constructor = { fg = "#B04D6E" },
			context_enum = { fg = "#B04D6E" },
			context_interface = { fg = "#B04D6E" },
			context_function = { fg = "#B04D6E" },
			context_variable = { fg = "#B04D6E" },
			context_constant = { fg = "#B04D6E" },
			context_string = { fg = "#B04D6E" },
			context_number = { fg = "#B04D6E" },
			context_boolean = { fg = "#B04D6E" },
			context_array = { fg = "#B04D6E" },
			context_object = { fg = "#B04D6E" },
			context_key = { fg = "#B04D6E" },
			context_null = { fg = "#B04D6E" },
			context_enum_member = { fg = "#B04D6E" },
			context_struct = { fg = "#B04D6E" },
			context_event = { fg = "#B04D6E" },
			context_operator = { fg = "#B04D6E" },
			context_type_parameter = { fg = "#B04D6E" },
		},
	},
}
