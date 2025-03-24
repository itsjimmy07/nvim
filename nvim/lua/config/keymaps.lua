-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General keymaps
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear highlights" })

-- Neo-tree keybind - only keeping this single keybind as requested
vim.keymap.set("n", "<leader>e", function()
    if _G.safe_neo_tree then
        _G.safe_neo_tree({ action = "focus", reveal = true, position = "left" })
    else
        vim.cmd("NeoTreeRevealLeft")
    end
end, { desc = "Reveal file in Neo-tree" })

-- Add keybind for navigating to any directory with Neo-tree
vim.keymap.set("n", "<leader>eb", function()
    vim.cmd("NeoTreeBrowse")
end, { desc = "Browse any directory with Neo-tree" })

-- File creation and edit keybindings
vim.keymap.set("n", "<leader>nf", function()
    vim.ui.input({ prompt = "Create new file: ", default = vim.fn.getcwd() .. "/" }, function(input)
        if input and input ~= "" then
            -- Create any necessary directories
            local dir = vim.fn.fnamemodify(input, ":h")
            if vim.fn.isdirectory(dir) == 0 then
                vim.fn.mkdir(dir, "p")
            end
            -- Edit the new file
            vim.cmd("edit " .. input)
        end
    end)
end, { desc = "Create new file" })

-- Direct way to create a new empty buffer
vim.keymap.set("n", "<leader>nb", function()
    vim.cmd("enew")
end, { desc = "Create new buffer" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close current split" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bx", "<cmd>bdelete<cr>", { desc = "Close buffer" })

-- Telescope keymaps
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

-- Theme switching
vim.keymap.set("n", "<leader>tt", "<cmd>colorscheme catppuccin<cr>", { desc = "Set Catppuccin theme" }) 

-- Code execution shortcuts
vim.keymap.set("n", "<leader>rp", "<cmd>!python %<cr>", { desc = "Run Python file" })
vim.keymap.set("n", "<leader>rn", "<cmd>!node %<cr>", { desc = "Run Node.js file" })
vim.keymap.set("n", "<leader>rl", "<cmd>!lua %<cr>", { desc = "Run Lua file" })
vim.keymap.set("n", "<leader>rr", "<cmd>!ruby %<cr>", { desc = "Run Ruby file" })
vim.keymap.set("n", "<leader>rs", "<cmd>!sh %<cr>", { desc = "Run shell script" })
vim.keymap.set("n", "<leader>rc", "<cmd>!gcc % -o %:r && ./%:r<cr>", { desc = "Compile and run C file" })
vim.keymap.set("n", "<leader>rg", "<cmd>!go run %<cr>", { desc = "Run Go file" })
vim.keymap.set("n", "<leader>rx", function()
    local filetype = vim.bo.filetype
    local cmd = {
        python = "python",
        javascript = "node",
        typescript = "ts-node",
        lua = "lua",
        ruby = "ruby",
        sh = "sh",
        bash = "bash",
        zsh = "zsh",
        rust = "cargo run",
        go = "go run",
        java = "java",
    }
    
    if cmd[filetype] then
        -- Save the current file first to ensure latest changes are executed
        vim.cmd('write')
        
        -- Store current window and buffer info
        local current_win = vim.api.nvim_get_current_win()
        local file_path = vim.fn.expand("%:p")
        
        -- Find any existing terminal window
        local term_win, term_buf
        local term_found = false
        
        -- First check if we have a window with terminal buftype
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == 'terminal' then
                term_win = win
                term_buf = buf
                term_found = true
                break
            end
        end
        
        -- Format the command to run
        local exec_cmd = cmd[filetype] .. " " .. file_path
        
        -- If no terminal was found, create one
        if not term_found then
            -- Create a new terminal window
            vim.cmd("botright vsplit")
            vim.cmd("vertical resize 80")
            
            -- Open terminal with the command directly
            vim.cmd("terminal " .. exec_cmd)
            
            -- Switch back to the original window
            vim.api.nvim_set_current_win(current_win)
        else
            -- The terminal exists but job is closed, create a new one
            vim.api.nvim_set_current_win(term_win)
            vim.cmd("terminal " .. exec_cmd)
                
            -- Switch back to the original window
            vim.api.nvim_set_current_win(current_win)

        end
    else
        vim.notify("No run command defined for filetype: " .. filetype, vim.log.levels.WARN)
    end
end, { desc = "Execute current file in terminal" })

-- Available Neo-tree keybindings:
-- <leader>e   - Reveal current file in filesystem on left side
-- <leader>et  - Toggle Neo-tree
-- <leader>ef  - Focus Neo-tree
-- <leader>er  - Reveal current file in Neo-tree
-- <leader>erl - Reveal current file in filesystem on left side (same as <leader>e) 

-- Terminal keybindings
vim.keymap.set("n", "<leader>th", "<cmd>botright split | resize 15 | terminal<cr>", { desc = "Open terminal at bottom" })
vim.keymap.set("n", "<leader>tv", "<cmd>botright vsplit | vertical resize 80 | terminal<cr>", { desc = "Open terminal at rightmost" })
vim.keymap.set("n", "<leader>tt", "<cmd>terminal<cr>", { desc = "Open terminal in current buffer" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Tab keybindings for indent/dedent
vim.keymap.set("n", "<Tab>", ">>", { desc = "Indent line" })
vim.keymap.set("n", "<S-Tab>", "<<", { desc = "Dedent line" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selected lines" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Dedent selected lines" })

-- Smart Tab in insert mode for both Copilot and indentation
vim.keymap.set("i", "<Tab>", function()
    -- Check if Copilot suggestion is visible
    local has_copilot, copilot_suggestion = pcall(require, "copilot.suggestion")
    if has_copilot and copilot_suggestion.is_visible() then
        copilot_suggestion.accept()
        return
    end
    
    -- Check if nvim-cmp menu is visible
    if require("cmp").visible() then
        require("cmp").confirm({ select = true })
        return
    end
    
    
    -- Default indentation behavior
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
    else
        -- If we're in the middle of a word, trigger completion
        require("cmp").complete()
    end
end, { desc = "Smart Tab: Accept Copilot, Complete, or Indent" }) 