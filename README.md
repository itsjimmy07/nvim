# Neovim Configuration

A modern Neovim configuration with a focus on development productivity, LSP integration, and a beautiful UI.

## Features

- Modern and clean UI with Catppuccin theme
- Extensive LSP (Language Server Protocol) integration
- Fuzzy finding with Telescope
- File tree with Neo-tree
- Syntax highlighting with Treesitter
- Git integration with Gitsigns
- Autocompletion with nvim-cmp
- GitHub Copilot integration
- Code formatting and linting with null-ls
- Beautiful start screen dashboard

## Plugins

### LSP & Diagnostics
- **nvim-lspconfig**: Configurations for Neovim LSP client
- **mason.nvim**: Package manager for LSP servers
- **mason-lspconfig.nvim**: Integration of mason with lspconfig
- **null-ls.nvim**: For code formatting and diagnostics

### Completion
- **nvim-cmp**: Autocompletion plugin
- **cmp-nvim-lsp**: LSP source for nvim-cmp
- **cmp-buffer**: Buffer source for nvim-cmp
- **cmp-path**: Path source for nvim-cmp
- **LuaSnip**: Snippet engine
- **cmp_luasnip**: Snippets source for nvim-cmp

### Editor Enhancement
- **nvim-treesitter**: Advanced syntax highlighting
- **neo-tree.nvim**: File explorer
- **nvim-lualine**: Status line
- **which-key.nvim**: Display key bindings
- **alpha-nvim**: Dashboard with custom header

### Search & Navigation
- **telescope.nvim**: Fuzzy finder
- **plenary.nvim**: Lua utility functions
- **nvim-web-devicons**: Icons for UI

### Git Integration
- **gitsigns.nvim**: Git decorations and hunks

### Theme
- **catppuccin/nvim**: A soothing pastel theme

### AI Assistance
- **copilot.lua**: GitHub Copilot integration

## Keymaps

### General
- `<Space>` - Leader key
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>h` - Clear highlights
- `<leader>e` - Toggle file explorer

### Window Navigation
- `<C-h>` - Move to left window
- `<C-j>` - Move to bottom window
- `<C-k>` - Move to top window
- `<C-l>` - Move to right window

### Window Management
- `<leader>sv` - Split window vertically
- `<leader>sh` - Split window horizontally
- `<leader>se` - Make splits equal size
- `<leader>sx` - Close current split

### Buffer Navigation
- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer
- `<leader>bx` - Close buffer

### Theme Switching
- `<leader>tt` - Set Tokyo Night theme

### GitHub Copilot
- `<Tab>` - Accept suggestion (also acts as indent/completion when no suggestion is visible)
- `<C-j>` - Next suggestion
- `<C-k>` - Previous suggestion
- `<C-e>` - Dismiss suggestion

### Tab Key Behavior
- In insert mode: 
  - Accept Copilot suggestion if visible
  - Confirm completion if menu is visible
  - Regular tab indentation at beginning of line
  - Trigger completion in middle of words
- In normal mode: Indent line (`>>`)
- In visual mode: Indent selected lines (`>gv`)
- `<S-Tab>` - Unindent (in all modes)

### Code Execution
- `<leader>rp` - Run Python file
- `<leader>rn` - Run Node.js file
- `<leader>rl` - Run Lua file
- `<leader>rr` - Run Ruby file
- `<leader>rs` - Run shell script
- `<leader>rc` - Compile and run C file
- `<leader>rg` - Run Go file
- `<leader>rx` - Smart execution based on filetype

### Terminal Integration
- `<leader>th` - Open terminal at bottom (horizontal split)
- `<leader>tv` - Open terminal at rightmost (vertical split)
- `<leader>tt` - Open terminal in current buffer
- `<Esc>` - Exit terminal mode (back to normal mode)

### File Creation
- `<leader>nf` - Create new file (with directory creation)
- `<leader>nb` - Create new buffer

### LSP (Language Server Protocol)
- `gd` - Go to definition
- `K` - Hover information
- `<leader>vws` - View workspace symbols
- `<leader>vd` - Open float diagnostic
- `[d` - Go to next diagnostic
- `]d` - Go to previous diagnostic
- `<leader>ca` - Code action
- `<leader>rr` - Show references
- `<leader>rn` - Rename symbol
- `<C-h>` - Signature help (in insert mode)
- `<leader>cm` - Open Mason package manager

### Dashboard
- `f` - Find file
- `e` - New file
- `r` - Recently used files
- `t` - Find text
- `c` - Edit configuration
- `p` - Edit plugins
- `q` - Quit Neovim

### Telescope
- Various mappings for navigating in Telescope pickers

## File Navigation

### File Explorer (Neo-tree)
- `<leader>e` - Toggle file explorer
- Within Neo-tree:
  - `o` or `<Enter>` - Open file/directory
  - `a` - Add a new file or directory
  - `d` - Delete a file or directory
  - `r` - Rename a file or directory
  - `c` - Copy file to clipboard
  - `x` - Cut file to clipboard
  - `p` - Paste file from clipboard
  - `y` - Copy file name to clipboard
  - `Y` - Copy relative path to clipboard
  - `<C-y>` - Copy absolute path to clipboard
  - `f` - Filter files by name
  - `H` - Toggle hidden files
  - `R` - Refresh file list
  - `?` - Show help

### Fuzzy Finding (Telescope)
- `<leader>ff` - Find files in current working directory
- `<leader>fg` - Live grep in current working directory
- `<leader>fb` - Find open buffers
- `<leader>fh` - Find help tags
- `<leader>fm` - Find marks
- `<leader>fo` - Find recently opened files
- `<leader>fr` - Find registers
- `<leader>ft` - Find current buffer TODOs
- Inside Telescope:
  - `<C-n>/<C-p>` - Next/previous item in history
  - `<C-j>/<C-k>` - Next/previous result
  - `<CR>` - Select the item
  - `<C-x>` - Select and open in horizontal split
  - `<C-v>` - Select and open in vertical split
  - `<C-t>` - Select and open in new tab
  - `<Esc>` - Close Telescope (in normal mode)
  - `<C-c>` - Close Telescope (in insert mode)

### Native Navigation
- `gd` - Go to definition
- `gr` - Go to references
- `gD` - Go to declaration
- `gi` - Go to implementation
- `<C-o>` - Jump back to previous location
- `<C-i>` - Jump forward to next location
- `%` - Jump between matching pairs (brackets, parentheses, etc.)
- `{` / `}` - Jump to previous/next paragraph
- `[[` / `]]` - Jump to previous/next section
- `gg` / `G` - Jump to beginning/end of file
- `:n` - Jump to file n (where n is a number)
- `nG` - Jump to line n

### Buffer Management
- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer
- `<leader>bx` - Close current buffer
- `:b name` - Switch to buffer containing "name"
- `:ls` - List all buffers

### Advanced Movement
- `w` / `b` - Move to next/previous word
- `e` - Move to end of word
- `f{char}` - Move to next occurrence of character
- `F{char}` - Move to previous occurrence of character
- `t{char}` - Move to before next occurrence of character
- `T{char}` - Move to after previous occurrence of character
- `;` / `,` - Repeat last f, F, t, or T movement
- `zz` - Center current line on screen
- `zt` - Move current line to top of screen
- `zb` - Move current line to bottom of screen

### Command Mode Completion
- `<Tab>` / `<S-Tab>` - Navigate through command suggestions
- `<C-n>` / `<C-p>` - Next/previous suggestion
- `<C-y>` - Accept current suggestion
- `<C-e>` - Cancel completion
- Command-line (`:`) autocompletion for commands and paths
- Search (`/` and `?`) autocompletion from buffer text

## Installation

1. Ensure you have Neovim 0.8+ installed
2. Clone this repository to your Neovim config directory:
   ```bash
   git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim
   ```
3. Start Neovim and let the plugins install:
   ```bash
   nvim
   ```

## External Requirements

Some formatters and linters require external tools. Install them as needed:

```bash
# Python tools
pip install black isort flake8 pylint mypy ruff

# Node.js tools
npm install -g prettier eslint stylelint

# Lua
cargo install stylua

# Shell
npm install -g shellcheck

# Markdown
npm install -g markdownlint-cli
```

For GitHub Copilot, you'll need to authenticate:
```
:Copilot auth
```

## Customization

The configuration is modular, with each plugin and its settings in a separate file under `lua/plugins/`.

To customize:
1. Edit the respective plugin file in `lua/plugins/`
2. Adjust keybindings in `lua/config/keymaps.lua`
3. Change editor settings in `init.lua` 