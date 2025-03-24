return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        -- Check for copilot.lua suggestion visibility
                        local has_copilot, copilot_suggestion = pcall(require, "copilot.suggestion")
                        local is_copilot_visible = has_copilot and copilot_suggestion.is_visible()
                        
                        if is_copilot_visible then
                            -- Accept Copilot suggestion
                            copilot_suggestion.accept()
                        elseif cmp.visible() then
                            -- Accept nvim-cmp suggestion
                            cmp.confirm({ select = true })
                        elseif luasnip.expand_or_jumpable() then
                            -- Expand or jump in snippet
                            luasnip.expand_or_jump()
                        else
                            -- Normal tab behavior
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
                completion = {
                    autocomplete = {
                        'InsertEnter', 'TextChanged',
                    },
                },
            })
            
            -- Set up cmdline completion with explicit mapping
            cmp.setup.cmdline(':', {

                mapping = cmp.mapping.preset.cmdline(),
                -- mapping = cmp.mapping.preset.cmdline({
                --     ['<Tab>'] = cmp.mapping(function(fallback)
                --         if cmp.visible() then
                --             cmp.select_next_item()
                --         else
                --             fallback()
                --         end
                --     end, {'c'}),
                --     ['<S-Tab>'] = cmp.mapping(function(fallback)
                --         if cmp.visible() then
                --             cmp.select_prev_item()
                --         else
                --             fallback()
                --         end
                --     end, {'c'}),
                -- }),
                sources = cmp.config.sources({
                    { name = 'cmdline' }
                }, {
                    { name = 'path' }
                }),
            })
            
            -- Set up search completion
            cmp.setup.cmdline('/', {
                completion = { autocomplete = true },
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer', max_item_count = 20 }
                }
            })
            
            -- Set up ? search completion
            cmp.setup.cmdline('?', {
                completion = { autocomplete = true },
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer', max_item_count = 20 }
                }
            })
        end,
    },
} 