-- ███╗   ███╗██████╗ ███████╗ ██████╗ ██████╗  ██████╗ ████████╗
-- ████╗ ████║██╔══██╗██╔════╝██╔═══██╗██╔══██╗██╔═══██╗╚══██╔══╝
-- ██╔████╔██║██████╔╝███████╗██║   ██║██████╔╝██║   ██║   ██║
-- ██║╚██╔╝██║██╔══██╗╚════██║██║   ██║██╔══██╗██║   ██║   ██║
-- ██║ ╚═╝ ██║██║  ██║███████║╚██████╔╝██████╔╝╚██████╔╝   ██║
-- ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝  ╚═════╝    ╚═╝
--
-- mr5obot-theme : standalone, single-file. A faithful 1:1 port of the old
-- custom-theme.lua color mappings (monochrome "amplified" + pink strings),
-- with the palette inlined (NO plugin) and modern @-capture / Diagnostic
-- groups ADDED on top using the SAME colors. Colors unchanged; features added.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "mr5obot-theme"

-- Palette (resolved hexes of the monochrome "amplified" style) ---------------
local c = {
	bg = "#000000",
	bg_alt = "#111111",
	fg = "#ffffff",

	gray1 = "#1b1b1b",
	gray2 = "#303030",
	gray3 = "#474747",
	gray4 = "#5e5e5e",
	gray5 = "#777777",
	gray6 = "#919191",
	gray7 = "#ababab",
	gray8 = "#c6c6c6",
	gray9 = "#e2e2e2",

	pink = "#d75f87", -- your signature string/number accent

	faded_red = "#ec8989",
	faded_yellow = "#ceb581",
	faded_blue = "#8abae1",

	neutral_red = "#eca8a8",
	neutral_green = "#ccd389",
	neutral_yellow = "#efd5a0",
	neutral_blue = "#a5c6e1",
	neutral_orange = "#efb6a0",

	bright_blue = "#c9e6fd",

	orange = "#cb4b16",
	green = "#719e07",
}

-- Terminal colors (unchanged from custom-theme) -----------------------------
vim.g.terminal_color_0 = c.bg
vim.g.terminal_color_1 = c.faded_red
vim.g.terminal_color_2 = "#c9d36a" -- faded_green
vim.g.terminal_color_3 = c.faded_yellow
vim.g.terminal_color_4 = c.faded_blue
vim.g.terminal_color_5 = "#db9fe9" -- faded_purple
vim.g.terminal_color_6 = "#abebe2" -- faded_aqua
vim.g.terminal_color_7 = c.fg
vim.g.terminal_color_8 = c.gray1
vim.g.terminal_color_9 = "#ffc4c4" -- bright_red
vim.g.terminal_color_10 = "#eff6ab" -- bright_green
vim.g.terminal_color_11 = "#ffe6b5" -- bright_yellow
vim.g.terminal_color_12 = c.bright_blue
vim.g.terminal_color_13 = "#f7d7ff" -- bright_purple
vim.g.terminal_color_14 = "#ddfcf8" -- bright_aqua
vim.g.terminal_color_15 = c.gray9

-- =====================================================================
-- 1:1 PORT of custom-theme.lua (exact same colors) --------------------
-- =====================================================================
local groups = {
	Normal = { fg = c.fg, bg = c.bg },
	Terminal = { fg = c.fg, bg = c.bg },
	Visual = { fg = c.bg, bg = c.fg },
	VisualNOS = { fg = c.bg, bg = c.fg },

	SpecialComment = { fg = c.gray6, bold = true, italic = true },
	Todo = { bold = true }, -- (original used colors.purple, which was nil)

	LineNr = { fg = c.gray3 },
	CursorLineNr = { fg = c.gray8, bg = c.bg_alt },

	Cursor = { fg = c.bg, bg = c.fg },
	lCursor = { fg = c.bg, bg = c.fg },
	CursorIM = { fg = c.bg, bg = c.fg },
	CursorColumn = { fg = c.fg },
	CursorLine = { bg = c.bg_alt },

	ColorColumn = { bg = c.bg_alt },
	Conceal = { fg = c.gray2 },

	IncSearch = { fg = c.bg, bg = c.bright_blue, bold = true },
	Search = { fg = c.bg, bg = c.faded_blue },

	Pmenu = { fg = c.fg, bg = c.gray1 },
	PmenuSel = { fg = c.gray1, bg = c.fg },
	PmenuSbar = { fg = c.fg, bg = c.gray1 },
	PmenuThumb = { fg = c.bg, bg = c.gray8 },

	SpellBad = { fg = c.orange, underline = true },
	SpellCap = {},
	SpellLocal = {},
	SpellRare = {},

	ModeMsg = {},
	MoreMsg = {},
	StatusLine = {},
	StatusLineNC = {},

	MatchParen = { bold = true },

	VertSplit = { fg = c.bg, bg = c.bg },

	-- Treesitter legacy (TS*) groups — kept verbatim as the source of truth.
	TSAnnotation = {},
	TSAttribute = {},
	TSBoolean = { fg = c.fg, bold = true },
	TSCharacter = { fg = c.fg },
	TSComment = { fg = c.gray3, italic = true },
	TSConditional = { fg = c.gray4 },
	TSConstant = { fg = c.fg },
	TSConstBuiltin = { fg = c.gray3 },
	TSConstMacro = {},
	TSConstructor = { fg = c.fg },
	TSError = { underline = true, italic = true },
	TSException = { underline = true, bold = true },
	TSField = { fg = c.gray5 },
	TSFloat = { fg = c.pink, bold = true },
	TSFunction = { fg = c.gray6 },
	TSFuncBuiltin = { fg = c.gray4 },
	TSFuncMacro = { fg = c.gray6 },
	TSInclude = { fg = c.gray7 },
	TSKeyword = { fg = c.gray4 },
	TSKeywordFunction = { fg = c.gray4 },
	TSKeywordOperator = { fg = c.gray4 },
	TSKeywordReturn = { fg = c.gray4 },
	TSLabel = { fg = c.fg },
	TSMethod = { fg = c.gray6 },
	TSNamespace = { fg = c.gray4 },
	TSNone = { fg = c.gray3 },
	TSNumber = { fg = c.pink, bold = true },
	TSOperator = { fg = c.fg },
	TSParameter = { fg = c.gray7 },
	TSParameterReference = { fg = c.gray7 },
	TSProperty = { fg = c.gray5 },
	TSPunctDelimiter = { fg = c.fg },
	TSPunctBracket = { fg = c.fg },
	TSPunctSpecial = { fg = c.fg },
	TSRepeat = { fg = c.gray4 },
	TSString = { fg = c.pink },
	TSStringRegex = { fg = c.gray9 },
	TSStringEscape = { fg = c.gray9 },
	TSSymbol = { fg = c.fg },
	TSTag = { fg = c.fg },
	TSTagDelimiter = {},
	TSText = { fg = c.fg },
	TSStrong = { bold = true },
	TSEmphasis = { italic = true },
	TSUnderline = { underline = true },
	TSStrike = { strikethrough = true },
	TSTitle = {},
	TSLiteral = { fg = c.fg },
	TSURI = {},
	TSMath = {},
	TSTextReference = {},
	TSEnvironment = {},
	TSEnvironmentName = {},
	TSNote = { bold = true },
	TSWarning = { bold = true },
	TSDanger = { bold = true },
	TSType = { fg = c.gray4 },
	TSTypeBuiltin = { fg = c.gray4 },
	TSVariable = { fg = c.gray8 },
	TSVariableBuiltin = { fg = c.gray8 },

	-- Classic syntax links (verbatim) ---------------------------------------
	Bold = { link = "TSStrong" },
	Boolean = { link = "TSBoolean" },
	Character = { link = "TSCharacter" },
	Comment = { link = "TSComment" },
	Conditional = { link = "TSConditional" },
	Constant = { link = "TSConstant" },
	Define = { link = "TSConstBuiltin" },
	Delimiter = { link = "TSPunctDelimiter" },
	Error = { link = "TSError" },
	Exception = { link = "TSException" },
	Float = { link = "TSFloat" },
	Function = { link = "TSFunction" },
	Identifier = { link = "TSVariable" },
	Include = { link = "TSInclude" },
	Italic = { link = "TSEmphasis" },
	Keyword = { link = "TSKeyword" },
	Label = { link = "TSLabel" },
	Macro = { link = "TSFuncMacro" },
	Number = { link = "TSNumber" },
	Operator = { link = "TSOperator" },
	Repeat = { link = "TSRepeat" },
	SpecialChar = { link = "TSStringEscape" },
	String = { link = "TSString" },
	Structure = { link = "TSAnnotation" },
	Field = { link = "TSProperty" },
	Tag = { link = "TSTag" },
	Title = { link = "TSTitle" },
	Type = { link = "TSType" },
	Underlined = { link = "TSUnderline" },
	asciidocAttributeEntry = { link = "TSAttribute" },
	cIncluded = { link = "TSConstructor" },
	healthError = { link = "TSDanger" },
	healthWarning = { link = "TSWarning" },
	rubySymbol = { link = "TSSymbol" },
	xmlNamespace = { link = "TSNamespace" },

	Directory = {},
	EndOfBuffer = {},
	ErrorMsg = { reverse = true },
	FoldColumn = {},
	Folded = {},
	NonText = { fg = c.green },
	Question = {},
	SignColumn = {},
	SpecialKey = {},
	Substitute = { fg = c.orange, bold = true, reverse = true },
	TabLine = {},
	TabLineFill = {},
	TabLineSel = { reverse = true },
	WarningMsg = {},
	WildMenu = { reverse = true },
	Ignore = {},
	PreProc = {},
	Special = {},
	ToolbarLine = { bg = c.bg },
	ToolbarButton = { bold = true },
	qfLineNr = {},
	Whitespace = { fg = c.gray2 },
	PmenuSelBold = {},
	NormalFloat = {},
	QuickFixLine = {},
	Debug = {},
	debugBreakpoint = {},
	PreCondit = {},
	Statement = { link = "Function" },
	Typedef = { fg = c.gray7 },

	-- Plugin groups (verbatim) ----------------------------------------------
	DiffAdd = { fg = c.neutral_green },
	DiffChange = { fg = c.neutral_blue },
	DiffDelete = { fg = c.neutral_red },
	DiffText = { fg = c.neutral_blue },

	GitSignsAdd = { fg = c.neutral_green },
	GitSignsDelete = { fg = c.neutral_red },
	GitSignsChange = { fg = c.neutral_blue },
	GitSignsChangeNr = { fg = c.neutral_yellow },
	GitSignsChangeLn = { fg = c.neutral_yellow },
	GitSignsChangeDelete = { fg = c.neutral_orange },

	-- Legacy LSP diagnostic groups (verbatim)
	LspDiagnosticsVirtualTextError = { fg = c.faded_red },
	LspDiagnosticsSignError = { fg = c.faded_red },
	LspDiagnosticsFloatingError = { fg = c.faded_red },
	LspDiagnosticsVirtualTextWarning = { fg = c.faded_yellow },
	LspDiagnosticsSignWarning = { fg = c.faded_yellow },
	LspDiagnosticsFloatingWarning = { fg = c.faded_yellow },
	LspDiagnosticsVirtualTextInformation = { fg = c.faded_blue },
	LspDiagnosticsSignInformation = { fg = c.faded_blue },
	LspDiagnosticsFloatingInformation = { fg = c.faded_blue },
	LspDiagnosticsVirtualTextHint = { fg = c.fg },
	LspDiagnosticsSignHint = { fg = c.fg },
	LspDiagnosticsFloatingHint = { fg = c.fg },
	LspDiagnosticsUnderlineError = { bg = c.bg, undercurl = true, sp = c.faded_red },
	LspDiagnosticsUnderlineWarning = { bg = c.bg, undercurl = true, sp = c.faded_yellow },
	LspDiagnosticsUnderlineInformation = { bg = c.bg, undercurl = true, sp = c.faded_blue },
	LspDiagnosticsUnderlineHint = { bg = c.bg, undercurl = true, sp = c.fg },

	markdownBold = { bold = true },
	markdownCode = {},
	markdownCodeDelimiter = {},
	markdownError = {},
	markdownH1 = { bold = true },
	markdownUrl = { fg = c.bright_blue },
	markdownFootnote = { link = "TSNote" },
	markdownLinkText = { link = "TSURI" },
	markdownLinkTextDelimiter = { fg = c.gray4 },
	markdownLinkDelimiter = { fg = c.gray4 },

	mkdDelimiter = {},
	mkdLineBreak = {},
	mkdListItem = {},
	mkdCodeStart = { fg = c.gray4 },
	mkdCodeEnd = { fg = c.gray4 },
	mkdURL = { fg = c.bright_blue },

	TelescopeBorder = { fg = c.gray5 },
	TelescopePromptBorder = { fg = c.fg },
	TelescopeMatching = {},
	TelescopeSelection = { bold = true },
	TelescopeSelectionCaret = { fg = c.fg },
	TelescopeMultiSelection = { italic = true },
}

-- =====================================================================
-- ADDED FEATURES (same colors, just modern group names) ---------------
-- =====================================================================

-- Modern treesitter @-captures -> link to the matching legacy TS* group,
-- so treesitter highlighting uses the EXACT colors defined above.
local ts = {
	["@comment"] = "TSComment",
	["@error"] = "TSError",
	["@none"] = "TSNone",
	["@constant"] = "TSConstant",
	["@constant.builtin"] = "TSConstBuiltin",
	["@constant.macro"] = "TSConstMacro",
	["@string"] = "TSString",
	["@string.regexp"] = "TSStringRegex",
	["@string.escape"] = "TSStringEscape",
	["@string.special"] = "TSStringEscape",
	["@character"] = "TSCharacter",
	["@character.special"] = "TSStringEscape",
	["@number"] = "TSNumber",
	["@number.float"] = "TSFloat",
	["@boolean"] = "TSBoolean",
	["@float"] = "TSFloat",
	["@function"] = "TSFunction",
	["@function.builtin"] = "TSFuncBuiltin",
	["@function.call"] = "TSFunction",
	["@function.macro"] = "TSFuncMacro",
	["@function.method"] = "TSMethod",
	["@function.method.call"] = "TSMethod",
	["@constructor"] = "TSConstructor",
	["@keyword"] = "TSKeyword",
	["@keyword.function"] = "TSKeywordFunction",
	["@keyword.operator"] = "TSKeywordOperator",
	["@keyword.return"] = "TSKeywordReturn",
	["@keyword.conditional"] = "TSConditional",
	["@keyword.repeat"] = "TSRepeat",
	["@keyword.import"] = "TSInclude",
	["@keyword.exception"] = "TSException",
	["@conditional"] = "TSConditional",
	["@repeat"] = "TSRepeat",
	["@include"] = "TSInclude",
	["@exception"] = "TSException",
	["@label"] = "TSLabel",
	["@operator"] = "TSOperator",
	["@variable"] = "TSVariable",
	["@variable.builtin"] = "TSVariableBuiltin",
	["@variable.parameter"] = "TSParameter",
	["@variable.member"] = "TSField",
	["@parameter"] = "TSParameter",
	["@field"] = "TSField",
	["@property"] = "TSProperty",
	["@type"] = "TSType",
	["@type.builtin"] = "TSTypeBuiltin",
	["@type.definition"] = "Typedef",
	["@type.qualifier"] = "TSKeyword",
	["@attribute"] = "TSAttribute",
	["@annotation"] = "TSAnnotation",
	["@module"] = "TSNamespace",
	["@namespace"] = "TSNamespace",
	["@symbol"] = "TSSymbol",
	["@punctuation.delimiter"] = "TSPunctDelimiter",
	["@punctuation.bracket"] = "TSPunctBracket",
	["@punctuation.special"] = "TSPunctSpecial",
	["@tag"] = "TSTag",
	["@tag.attribute"] = "TSProperty",
	["@tag.delimiter"] = "TSTagDelimiter",
	["@markup"] = "TSText",
	["@markup.strong"] = "TSStrong",
	["@markup.italic"] = "TSEmphasis",
	["@markup.underline"] = "TSUnderline",
	["@markup.strikethrough"] = "TSStrike",
	["@markup.heading"] = "TSTitle",
	["@markup.raw"] = "TSLiteral",
	["@markup.link"] = "TSURI",
	["@markup.link.url"] = "TSURI",
	["@markup.math"] = "TSMath",
	["@comment.note"] = "TSNote",
	["@comment.warning"] = "TSWarning",
	["@comment.error"] = "TSDanger",
	-- LSP semantic tokens
	["@lsp.type.class"] = "TSType",
	["@lsp.type.decorator"] = "TSFunction",
	["@lsp.type.enum"] = "TSType",
	["@lsp.type.enumMember"] = "TSConstant",
	["@lsp.type.function"] = "TSFunction",
	["@lsp.type.interface"] = "TSType",
	["@lsp.type.macro"] = "TSFuncMacro",
	["@lsp.type.method"] = "TSMethod",
	["@lsp.type.namespace"] = "TSNamespace",
	["@lsp.type.parameter"] = "TSParameter",
	["@lsp.type.property"] = "TSProperty",
	["@lsp.type.struct"] = "TSType",
	["@lsp.type.type"] = "TSType",
	["@lsp.type.variable"] = "TSVariable",
}
for new, old in pairs(ts) do
	groups[new] = { link = old }
end

-- Modern vim.diagnostic groups (same colors as the legacy LspDiagnostics*).
local diag = {
	DiagnosticError = { fg = c.faded_red },
	DiagnosticWarn = { fg = c.faded_yellow },
	DiagnosticInfo = { fg = c.faded_blue },
	DiagnosticHint = { fg = c.fg },
	DiagnosticVirtualTextError = { fg = c.faded_red },
	DiagnosticVirtualTextWarn = { fg = c.faded_yellow },
	DiagnosticVirtualTextInfo = { fg = c.faded_blue },
	DiagnosticVirtualTextHint = { fg = c.fg },
	DiagnosticUnderlineError = { undercurl = true, sp = c.faded_red },
	DiagnosticUnderlineWarn = { undercurl = true, sp = c.faded_yellow },
	DiagnosticUnderlineInfo = { undercurl = true, sp = c.faded_blue },
	DiagnosticUnderlineHint = { undercurl = true, sp = c.fg },
	DiagnosticSignError = { fg = c.faded_red },
	DiagnosticSignWarn = { fg = c.faded_yellow },
	DiagnosticSignInfo = { fg = c.faded_blue },
	DiagnosticSignHint = { fg = c.fg },
	DiagnosticFloatingError = { fg = c.faded_red },
	DiagnosticFloatingWarn = { fg = c.faded_yellow },
	DiagnosticFloatingInfo = { fg = c.faded_blue },
	DiagnosticFloatingHint = { fg = c.fg },
}
for name, spec in pairs(diag) do
	groups[name] = spec
end

-- Apply -------------------------------------------------------------------
local hl = vim.api.nvim_set_hl
for group, spec in pairs(groups) do
	hl(0, group, spec)
end
