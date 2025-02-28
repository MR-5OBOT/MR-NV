local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

-- Matplotlib Snippet
ls.add_snippets("python", {
	s("plt simple tpl", {
		t({ "import matplotlib.pyplot as plt", "" }),
		t({ "plt.figure(figsize=(" }),
		i(1, "6"),
		t({ ", " }),
		i(2, "6"),
		t({ "))", "" }),
		t({ 'plt.style.use("' }),
		i(3, "dark_background"),
		t({ '")', "" }),
		t({ "plt.plot(" }),
		i(4, "x"),
		t({ ", " }),
		i(5, "y"),
		t({ ")", "" }),
		t({ "# plt.tight_layout()", "" }),
		t({ "plt.show()", "" }),
	}, {
		description = "Matplotlib starter",
	}),
})

-- NumPy Random List Snippet
ls.add_snippets("python", {
	s("random list", {
		t({ "import numpy as np", "" }),
		t({ "" }),
		t({ "random_list = np.random.rand(" }),
		i(1, "10"),
		t({ ")", "" }),
		t({ "" }),
		t({ "print(random_list)", "" }),
	}, {
		description = "NumPy random list",
	}),
})

-- Pandas Read CSV Snippet
ls.add_snippets("python", {
	s("pdreadcsv", {
		t({ "import pandas as pd", "" }),
		t({ "" }),
		t({ "df = pd.read_csv(" }),
		i(1, "'file.csv'"),
		t({ ")", "" }),
		t({ "" }),
		t({ "print(df.head())", "" }),
	}, {
		description = "Pandas read CSV",
	}),
})
