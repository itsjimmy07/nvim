-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugin modules
local plugins = {}

-- Helper function to safely require and get plugins
local function safe_require(module)
    local ok, result = pcall(require, module)
    if not ok then
        vim.notify("Failed to load plugin module: " .. module, vim.log.levels.ERROR)
        return {}
    end
    return result
end

-- Load plugin modules
local plugin_modules = {
    "plugins.lsp",
    "plugins.completion",
    "plugins.editor",
    "plugins.git",
    "plugins.theme",
    "plugins.search",
    "plugins.ai",
    "plugins.dashboard",
}

for _, module in ipairs(plugin_modules) do
    local result = safe_require(module)
    if result.plugins then
        for _, plugin in ipairs(result.plugins) do
            table.insert(plugins, plugin)
        end
    elseif result.plugin then
        table.insert(plugins, result.plugin)
    end
end

-- Setup lazy.nvim with all plugins
require("lazy").setup(plugins) 