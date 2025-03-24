local M = {}

-- Plugin specifications
M.plugin = {
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    -- File explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = false, -- Ensure it's not lazy-loaded
        priority = 100, -- High priority to ensure it loads early
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        init = function()
            -- This runs before the plugin is loaded
            -- Create a global accessor function for Neo-tree that's always safe to call
            _G.safe_neo_tree = function(opts)
                opts = opts or {}
                local default_opts = {
                    action = "focus",
                    source = "filesystem",
                    position = "left",
                    reveal = true
                }
                
                for k, v in pairs(default_opts) do
                    if opts[k] == nil then
                        opts[k] = v
                    end
                end
                
                -- Directory handling
                if opts.dir then
                    -- Set directory to navigate to
                    opts.dir = vim.fn.expand(opts.dir)
                end
                
                -- Check if we're in Alpha dashboard buffer
                local current_buf = vim.api.nvim_get_current_buf()
                local buf_name = vim.api.nvim_buf_get_name(current_buf)
                if buf_name == "" and vim.bo[current_buf].filetype == "alpha" then
                    -- Don't reveal files when in Alpha dashboard to avoid buffer conflicts
                    opts.reveal = false
                end
                
                -- Safe require and execute
                local ok, neo_tree = pcall(require, "neo-tree.command")
                if ok then
                    -- Add protected call to avoid any errors during window resize events
                    pcall(neo_tree.execute, opts)
                else
                    vim.notify("Neo-tree not available", vim.log.levels.WARN)
                end
            end
        end,
        config = function()
            -- Create our user commands (keeping these)
            vim.api.nvim_create_user_command("NeoTreeRevealLeft", function()
                _G.safe_neo_tree({ action = "focus", reveal = true, position = "left" })
            end, {})
            
            vim.api.nvim_create_user_command("NeoTreeToggle", function()
                _G.safe_neo_tree({ toggle = true, action = "show" })
            end, {})
            
            -- Add command specifically for dashboard to avoid errors
            vim.api.nvim_create_user_command("NeoTreeFromDashboard", function()
                _G.safe_neo_tree({ action = "focus", position = "left", reveal = false })
            end, {})
            
            -- Add debug command
            vim.api.nvim_create_user_command("NeoTreeDebug", function()
                local neo_tree_loaded = package.loaded["neo-tree"] ~= nil
                local message = "Neo-tree loaded: " .. tostring(neo_tree_loaded)
                if neo_tree_loaded then
                    local state = require("neo-tree.sources.manager").get_state("filesystem")
                    message = message .. "\nCurrent state: " .. vim.inspect(state and state.name or "nil")
                end
                vim.notify(message, vim.log.levels.INFO)
            end, {})
            
            -- Add command to browse any directory
            vim.api.nvim_create_user_command("NeoTreeBrowse", function(opts)
                local path = opts.args
                if path == "" then
                    -- Use vim.ui.input to get a directory path if none was provided
                    vim.ui.input({ prompt = "Path to browse: ", default = vim.fn.getcwd() }, function(input)
                        if input then
                            -- Expand ~ to home directory if necessary
                            input = input:gsub("^~", os.getenv("HOME"))
                            _G.safe_neo_tree({ action = "focus", position = "left", dir = input })
                        end
                    end)
                else
                    -- Expand ~ to home directory if necessary
                    path = path:gsub("^~", os.getenv("HOME"))
                    _G.safe_neo_tree({ action = "focus", position = "left", dir = path })
                end
            end, { nargs = "?", complete = "dir" })
            
            require("neo-tree").setup({
                close_if_last_window = true,
                enable_git_status = true,
                enable_diagnostics = true,
                popup_border_style = "rounded",
                default_component_configs = {
                    icon = {
                        folder_closed = "󰉋",
                        folder_open = "󰉋",
                        folder_empty = "󰉖",
                    },
                    modified = {
                        symbol = "",
                    },
                    git_status = {
                        symbols = {
                            added = "✓",
                            modified = "✠",
                            deleted = "✗",
                            renamed = "➜",
                            untracked = "★",
                            ignored = "◌",
                            unstaged = "✹",
                            staged = "✓",
                            conflict = "❌",
                        },
                    },
                },
                window = {
                    position = "left",
                    width = 30,
                    mappings = {
                        ["<space>"] = "none",
                    },
                },
                filesystem = {
                    follow_current_file = {
                        enabled = true,
                    },
                    use_libuv_file_watcher = true,
                    
                    -- Enable directory navigation outside current directory
                    filtered_items = {
                        visible = false,
                        hide_dotfiles = false,
                        hide_gitignored = false,
                    },
                    
                    -- Add navigation buttons to move up directories
                    bind_to_cwd = false, -- Allow navigating outside current directory
                    cwd_target = {
                        sidebar = "tab",   -- Sidebar is a buffer local handle
                        current = "window" -- Current controls window target
                    },
                    
                    -- Setup common directory shortcuts
                    window = {
                        mappings = {
                            ["/"] = "set_root", -- Change directory to the selected directory
                            ["H"] = "navigate_up", -- Go up a directory
                            ["<bs>"] = "navigate_up", -- Backspace also goes up a directory
                            ["cd"] = "set_root", -- Another way to change directories
                            ["a"] = { "add", config = { show_path = "none" } }, -- Add new file/directory
                            ["A"] = "add_directory", -- Add directory
                            ["d"] = "delete", -- Delete file/directory
                            ["r"] = "rename", -- Rename file/directory
                            ["c"] = "copy", -- Copy file to clipboard
                            ["x"] = "cut_to_clipboard", -- Cut file to clipboard
                            ["p"] = "paste_from_clipboard", -- Paste from clipboard
                            ["~"] = function(state) -- Home directory
                                state.commands.set_root(state, os.getenv("HOME"))  
                            end,
                            ["<c-h>"] = function(state) -- Config directory
                                state.commands.set_root(state, vim.fn.stdpath("config"))
                            end,
                        }
                    },
                },
            })
        end,
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup()
        end,
    },

    -- Which key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup()
        end,
    },
}

return M 