local M = {}

-- Plugin specification
M.plugin = {
    "goolord/alpha-nvim",
    priority = 90, -- High priority to load early, but after Neo-tree
    lazy = false, -- Not lazy-loaded, load during startup
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-neo-tree/neo-tree.nvim",
    },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Custom header
        dashboard.section.header.val = {
            [[                                  __                ]],
            [[     ___     ___    ___   __  __ /\_\    ___ ___    ]],
            [[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
            [[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
            [[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
            [[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
            [[                                                    ]],
            [[                                                    ]],
            [[                ⚡ Supercharged Neovim ⚡              ]],
        }

        -- Custom file explorer button
        local file_explorer_button = dashboard.button("e", "  File Explorer", function()
            -- Use our safe global function if available
            if _G.safe_neo_tree then
                _G.safe_neo_tree({ action = "focus", position = "left", reveal = false })
            else
                -- Fallback
                pcall(vim.cmd, "NeoTreeFromDashboard")
            end
        end)

        -- Menu
        dashboard.section.buttons.val = {
            dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
            file_explorer_button,
            dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
            dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
            dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
            dashboard.button("p", "  Plugins", ":e ~/.config/nvim/lua/plugins.lua <CR>"),
            dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
        }

        -- Footer
        local function footer()
            local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
            local version = vim.version()
            local nvim_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
            return " " .. datetime .. "   Neovim " .. nvim_version
        end

        dashboard.section.footer.val = footer()

        -- Layout
        dashboard.config.layout = {
            { type = "padding", val = 2 },
            dashboard.section.header,
            { type = "padding", val = 2 },
            dashboard.section.buttons,
            { type = "padding", val = 1 },
            dashboard.section.footer,
        }

        -- Set theme
        dashboard.config.opts.noautocmd = true
        alpha.setup(dashboard.config)

        -- Auto commands
        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
        
        -- Register a direct autocommand to show Alpha on start when no arguments are provided
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                if vim.fn.argc() == 0 and not vim.fn.exists('$VIMRUNTIME/debian.vim') then
                    vim.cmd('Alpha')
                end
            end,
            desc = "Start Alpha when vim is opened with no arguments",
        })
        
        -- Add buffer protection to prevent errors during WinResized events
        vim.api.nvim_create_autocmd("WinResized", {
            callback = function()
                -- Check if alpha buffer is valid before operating on it
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    if vim.bo[buf].filetype == "alpha" and not vim.api.nvim_buf_is_valid(buf) then
                        return -- Skip event processing for invalid alpha buffers
                    end
                end
            end,
        })
    end,
}

return M 