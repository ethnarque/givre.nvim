local options = require("givre.config").options

local variants = {
    dark = {
        --- Main
        bg          = "#101010",
        fg          = "#B8B8B8",
        accent      = "#7F8B99",
        --- UI
        cursor_line = "#191919",
        inactive    = "#383838",
        menu        = "#000000",
        menu_sel    = "#191919",
        separator   = "#1E1E1E",
        visual      = "#242424",
        whitespace  = "#303030",

        shade1      = "#636363",
        shade2      = "#797979",
        shade3      = "#868686",
        shade4      = "#989898",
        shade5      = "#AAAAAA",
        --- Syntax and shades
        identifier  = "#929292",
        number      = "#AF9A8A",
        tag         = "#336275",
        type        = "#BBA08B",
        --- Misc
        danger      = "#E56E6B",
        warn        = "#BB906E",
        success     = "#659A68",
    },

    light = {
        -- --- Main
        -- bg          = "#FFFFFF",
        -- fg          = "#000000",
        -- accent      = "#6776B2",
        -- --- UI
        -- cursor_line = "#F9F9F9",
        -- inactive    = "#BFBFBF",
        -- menu        = "#F0F0F0",
        -- menu_sel    = "#E4E4E4",
        -- separator   = "#EBEBEB",
        -- visual      = "#F0F0F0",
        -- whitespace  = "#E0E0E0",
        -- --- Syntax
        -- identifier  = "#4C4C4C",
        -- number      = "#00A4A6",
        -- string      = "#6776B2",
        -- tag         = "#3455DB",
        -- type        = "#BD7D5E",
        -- --- Shades
        -- shade1      = "#797979",
        -- shade2      = "#717171",
        -- shade3      = "#666666",
        -- shade4      = "#4E4E4E",
        -- shade5      = "#343434",
        -- --- Misc
        -- danger      = "#BD5E5E",
        -- warn        = "#BD945E",
        -- success     = "#78BD5E",
    },
}


if options.variant ~= nil and options.variant ~= "auto" then
    return variants[options.variant]
end

if vim.o.background == "light" then
    vim.notify("light mode is still in beta")
    return variants.light
end
return variants.dark
