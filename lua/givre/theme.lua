local M = {}

-- TODO: Need to put that in the secretaire config refactor ASAP
vim.cmd [[
    set list
    set listchars+=trail:·
]]

---@param options GivreOptions
function M._load(options)
    local h = require("givre.util").highlight
    local p = require("givre.palette")

    M.defaults = {
        --- Editor
        ['ColorColumn']                = {},
        ['Conceal']                    = {},
        ['CurSearch']                  = { link = 'IncSearch' },
        ['Cursor']                     = {},
        ["CursorColumn"]               = {},
        ["CursorColumnSign"]           = {},
        ["CursorIM"]                   = {},
        ["CursorLine"]                 = { bg = p.cursor_line },
        ["CursorLineNr"]               = { fg = p.shade5, bg = p.cursor_line },
        ["CursorLineSign"]             = { bg = p.cursor_line },
        ['DiffAdd']                    = { fg = p.success },
        ['DiffChange']                 = { fg = p.warn },
        ['DiffDelete']                 = { fg = p.danger },
        ['DiffText']                   = {},
        ['diffAdded']                  = { link = "DiffAdd" },
        ['diffChanged']                = { link = 'DiffChange' },
        ['diffRemoved']                = { link = 'DiffDelete' },
        ['Directory']                  = {},
        ["EndOfBuffer"]                = { fg = p.bg },
        ['ErrorMsg']                   = { link = "Error" },
        ['FloatBorder']                = {},
        ['FloatTitle']                 = {},
        ['FoldColumn']                 = {},
        ['Folded']                     = {},
        ['IncSearch']                  = {},
        ["LineNr"]                     = { fg = p.inactive },
        ['MatchParen']                 = {},
        ['ModeMsg']                    = {},
        ['MoreMsg']                    = {},
        ['NonText']                    = {},
        ["Normal"]                     = { fg = p.fg, bg = p.bg },
        ["NormalFloat"]                = { bg = p.menu },
        ['NormalNC']                   = {},
        ['NvimInternalError']          = {},
        ['Pmenu']                      = { fg = p.fg4, bg = p.menu },
        ['PmenuSbar']                  = {},
        ['PmenuSel']                   = { fg = p.menu_sel, bg = p.accent },
        ['PmenuThumb']                 = {},
        ['Question']                   = {},
        ['RedrawDebugClear']           = {},
        ['RedrawDebugComposed']        = {},
        ['RedrawDebugRecompose']       = {},
        ['Search']                     = {},
        ['SpecialKey']                 = {},
        ['SpellBad']                   = {},
        ['SpellCap']                   = {},
        ['SpellLocal']                 = {},
        ['SpellRare']                  = {},
        ["SignColumn"]                 = {},
        ['Substitute']                 = {},
        ["StatusLine"]                 = { fg = p.bg, bg = p.accent },
        ['StatusLineNC']               = {},
        ['StatusLineTerm']             = { link = 'StatusLine' },
        ['StatusLineTermNC']           = { link = 'StatusLineNC' },
        ['TabLine']                    = {},
        ['TabLineFill']                = {},
        ['TabLineSel']                 = {},
        ['Title']                      = {},
        ['VertSplit']                  = { fg = p.separator },
        ['Visual']                     = { bg = p.visual },
        -- VisualNOS = {},
        ['WarningMsg']                 = {},
        ["Whitespace"]                 = { fg = p.whitespace },
        ['WildMenu']                   = { link = 'IncSearch' },
        ["WinSeparator"]               = { fg = p.inactive },
        --- Syntax
        ["Boolean"]                    = { link = "Number" },
        ["Character"]                  = {},
        ["Constant"]                   = { link = "Include" },
        ["Comment"]                    = { fg = p.shade1 },
        ["Conditional"]                = { link = "Keyword" },
        ["Delimiter"]                  = { fg = p.shade4 },
        ["Exception"]                  = { link = "Keyword" },
        ["Error"]                      = { fg = p.danger },
        ["Float"]                      = { link = "Number" },
        ["Function"]                   = { fg = p.shade3 },
        ["Identifier"]                 = { fg = p.shade5 },
        ["Include"]                    = { fg = p.shade5 },
        ["Keyword"]                    = { fg = p.shade2 },
        ["Label"]                      = { link = "Keyword" },
        ["Number"]                     = { fg = p.number },
        ["Operator"]                   = { fg = p.shade5 },
        ["PreProc"]                    = { link = "Keyword" },
        ["Repeat"]                     = { link = "Keyword" },
        ["Statement"]                  = { link = "Keyword" },
        ["String"]                     = { fg = p.accent },
        ["Special"]                    = {},
        ["SpecialChar"]                = {},
        ["Type"]                       = { fg = p.type },
        ["Tag"]                        = { fg = p.tag },
        ["Todo"]                       = {},
        ["Underlined"]                 = { fg = p.accent, underline = true },
        --- Go
        ["goPackage"]                  = { link = "Include" },
        ["goUnsignedInts"]             = { fg = p.builtin },
        --- Lua
        ["luaStatement"]               = { link = "Keyword" },
        ["luaConstant"]                = { link = "Boolean" },
        ["luaFunc"]                    = { link = "Function" },
        ["luaFunction"]                = { link = "Keyword" },
        ["luaFunctionBlock"]           = { link = "Function" },
        --- Treesitter
        ["@field"]                     = { link = "Identifier" },
        ["@punctuation.bracket"]       = { link = "Function" },
        ["@tag.attribute"]             = { link = "Include" },
        ["@tag.delimiter"]             = { link = "Delimiter" },
        --- LSP
        ["LspCodeLens"]                = { fg = p.shade1 },
        --- Diagnostic
        ["DiagnosticError"]            = { link = "Error" },
        ["DiagnosticVirtualTextError"] = { fg = p.bg, bg = p.danger },
        ["DiagnosticHint"]             = { fg = p.info },
        ["DiagnosticVirtualTextHint"]  = { fg = p.bg, bg = p.accent },
        ["DiagnosticWarn"]             = { fg = p.warn },
        ["DiagnosticVirtualTextWarn"]  = { fg = p.bg, bg = p.accent },
        ["DiagnosticInfo"]             = { fg = p.warn },
        ["DiagnosticVirtualTextInfo"]  = { fg = p.bg, bg = p.accent },
        -- GitSigns
        ["GitSignsAdd"]                = { link = "DiffAdd" },
        ["GitSignsChange"]             = { link = "DiffChange" }
    }


    for group, opts in pairs(options.highlight_groups) do
        local default_opts = M.defaults[group]

        if (opts.inherit == nil or opts.inherit) and default_opts ~= nil then
            opts.inherit = nil
            M.defaults[group] = vim.tbl_extend("force", default_opts, opts)
        else
            opts.inherit = nil -- Don't add this key to the highlight_group.
            M.defaults[group] = opts
        end
    end

    for group, color in pairs(M.defaults) do
        h(group, color)
    end
end

return M
