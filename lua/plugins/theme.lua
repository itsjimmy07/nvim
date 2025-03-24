local M = {}

-- Plugin specification
M.plugin = {
    "catppuccin/nvim",
    config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            background = {
                light = "latte",
                dark = "mocha",
            },
            transparent_background = false,
            term_colors = true,
            dim_inactive = {
                enabled = true,
                shade = "dark",
                percentage = 0.15,
            },
            styles = {
                comments = { "italic" },
                conditionals = { "italic" },
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
            },
            integrations = {
                treesitter = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                },
                lsp_trouble = true,
                cmp = true,
                lsp_saga = true,
                gitgutter = false,
                gitsigns = true,
                telescope = true,
                nvimtree = {
                    enabled = true,
                    show_root = true,
                    transparent_panel = false,
                },
                neotest = true,
                which_key = true,
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false,
                },
                dashboard = true,
                neogit = true,
                vim_sneak = true,
                fern = false,
                barbar = true,
                bufferline = true,
                markdown = true,
                lightspeed = true,
                ts_rainbow = true,
                hop = true,
                notify = true,
                telekasten = true,
                symbols_outline = true,
                mini = true,
                aerial = true,
                vimwiki = true,
                beacon = true,
            },
        })
        vim.cmd.colorscheme "catppuccin"
    end,
}

return M 