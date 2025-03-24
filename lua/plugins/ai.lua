local M = {}

-- Plugin specification
M.plugin = {
    "zbirenbaum/copilot.lua",
    build = ":Copilot auth",
    event = "VeryLazy",
    config = function()
        require("copilot").setup({
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = false,
                    next = "<C-j>",
                    prev = "<C-k>",
                    dismiss = "<C-e>",
                },
            },
            filetypes = {
                markdown = true,
                help = true,
            },
            panel = {
                enabled = true,
                auto_refresh = true,
                keymap = {
                    jump_prev = "[[",
                    jump_next = "]]",
                    accept = "<CR>",
                    refresh = "gr",
                    open = "<C-CR>",
                },
            },
        })
    end,
}

return M 