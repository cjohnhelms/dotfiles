# Neovim Config

Personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

## Plugin Manager

- **[folke/lazy.nvim](https://github.com/folke/lazy.nvim)** — fast, modern plugin manager with lazy-loading support

## Plugins

### Colorscheme

| Plugin | Description |
|--------|-------------|
| [Mofiqul/vscode.nvim](https://github.com/Mofiqul/vscode.nvim) | VS Code-inspired dark/light theme |

### LSP

| Plugin | Description |
|--------|-------------|
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Quickstart configs for Neovim's built-in LSP client |
| [mason-org/mason.nvim](https://github.com/mason-org/mason.nvim) | Portable package manager for LSP servers, linters, and formatters |
| [mason-org/mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) | Bridges mason.nvim and nvim-lspconfig for automatic server setup |

**Configured LSP servers:** `lua_ls`, `gopls`, `ocamllsp`, `clangd`, `rust_analyzer`

### Completion

| Plugin | Description |
|--------|-------------|
| [saghen/blink.cmp](https://github.com/saghen/blink.cmp) | Fast, feature-rich completion engine with Rust fuzzy matching |
| [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Snippet collection for various languages (used as blink.cmp source) |

**Completion sources:** LSP, path, snippets, buffer  
**Keymap preset:** `super-tab` (Tab to accept)

### Syntax Highlighting

| Plugin | Description |
|--------|-------------|
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Treesitter-based syntax highlighting and code parsing |
| [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | Treesitter-powered text objects for motions and selections |

**Installed grammars:** `yaml`, `json`, `go`, `rust`, `ocaml`, `python`, `cpp`, `c`

### File Explorer

| Plugin | Description |
|--------|-------------|
| [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File tree explorer |
| [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File type icons (used by nvim-tree and lualine) |

### Fuzzy Finder

| Plugin | Description |
|--------|-------------|
| [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder for files, grep, buffers, and help tags |
| [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua utility library (required by telescope) |

### UI

| Plugin | Description |
|--------|-------------|
| [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Fast and configurable statusline (custom bubbles theme) |
| [folke/which-key.nvim](https://github.com/folke/which-key.nvim) | Displays keybinding hints in a popup |

## Key Bindings

Leader key is `,`.

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `<leader>o` | Focus file explorer |
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep (Telescope) |
| `<leader>fb` | Find buffers (Telescope) |
| `<leader>fh` | Help tags (Telescope) |

## Settings

- Line numbers enabled
- 4-space indentation
- Unix line endings
- `scrolloff = 7`
- Format on save for C/C++ files (via `clangd`)
- Rounded window borders
- Inline LSP diagnostics
