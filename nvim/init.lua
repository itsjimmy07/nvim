-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

-- Load plugins (includes their configurations)
require("plugins")

-- Simple function to handle errors gracefully
local function safe_cmd(cmd)
    pcall(vim.cmd, cmd)
end

-- Auto start alpha on new tab or empty buffer
vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
        -- Make sure that Neo-tree is loaded first
        if _G.safe_neo_tree then
            -- Just initialize it, don't show it yet
            _G.safe_neo_tree({ action = "init", visible = false, reveal = false })
        end
        
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        
        if #vim.fn.argv() == 0 then
            -- Only show dashboard if no files were provided as arguments
            -- Add a longer delay to ensure all buffers are properly initialized
            vim.defer_fn(function()
                -- Check if we're not already in Alpha dashboard
                if vim.bo.filetype ~= "alpha" then
                    safe_cmd("Alpha")
                end
            end, 50) -- Increased delay to 50ms
        end
    end,
})

-- Load keymaps
require("config.keymaps") 