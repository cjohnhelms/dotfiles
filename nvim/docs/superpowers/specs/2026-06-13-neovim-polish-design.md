# Neovim Config Polish — Design Spec
Date: 2026-06-13

## Goal

Transform the existing Neovim config into a visually polished, enjoyable editor without bloat. The user wants an editor that feels good to be in — pretty, informative, and smooth — while keeping the plugin count reasonable and the config easy to reason about.

## Context

- Current theme: `vscode.nvim` (being replaced)
- Existing plugins: blink.cmp, nvim-lspconfig, mason, treesitter, telescope, which-key, lualine, nvim-tree
- Workflow: Neovim inside tmux, git via terminal — no need for git TUI inside Neovim
- Languages: C, Go, Rust, OCaml, Python

## Decisions Made

- **Theme**: Carbonfox (via `nightfox.nvim`) — IBM Carbon palette, pure black + neon violet/cyan/green
- **UI decoration**: Full polish — tabs, indent guides, git gutter, cursorline, richer statusline
- **Motion**: Smooth scrolling only — no dashboard, no noice.nvim floating cmdline
- **Workflow additions**: autopairs + mini.comment + mini.surround (approach B)

## Visual Layer

### Colorscheme
Replace `Mofiqul/vscode.nvim` with `EdenEast/nightfox.nvim`, loading the `carbonfox` variant. The existing inline colorscheme config in `lua/plugins/init.lua` moves to its own `lua/plugins/colorscheme.lua`.

### Buffer Tabs
`akinsho/bufferline.nvim` — tabs across the top showing open buffers with file icons. Requires `nvim-web-devicons`. Style matched to carbonfox.

### Indent Guides
`lukas-reineke/indent-blankline.nvim` (v3) — vertical scope lines for indentation. Treesitter-aware so guides reflect actual code structure, not just whitespace.

### Git Gutter
`lewis6991/gitsigns.nvim` — `+`/`~`/`-` signs in the sign column for added/changed/deleted lines. Also enables:
- `]c` / `[c` to jump between hunks
- `<leader>hs` to stage a hunk
- `<leader>hp` to preview a hunk inline

### Smooth Scroll
`karb94/neoscroll.nvim` — eased scrolling on `C-d`, `C-u`, `C-f`, `C-b`, `zt`, `zz`, `zb`. Subtle easing curve (not bouncy). Makes spatial navigation feel less jarring.

### Settings
Two additions to `lua/settings.lua`:
- `vim.opt.cursorline = true` — highlight the current line
- `vim.opt.relativenumber = true` — relative line numbers for easier motion counting

### Lualine
Replace the existing `lualine.lua` with a polished config: git branch (from gitsigns), LSP status, filetype with icon, and diff counts in the statusline. Carbonfox-compatible theme.

## Workflow Layer

### Auto-pairs
`windwp/nvim-autopairs` — auto-closes `(`, `[`, `{`, `"`, `'`. Integrated with blink.cmp so completion acceptance doesn't double-insert closing characters.

### Comments
`echasnovski/mini.comment` — Treesitter-aware comment toggling. Uses correct comment syntax per language (including embedded languages). Bindings: `gcc` for current line, `gc` + motion for a range.

### Surround
`echasnovski/mini.surround` — add/delete/replace surrounding pairs. Bindings: `sa` (add), `sd` (delete), `sr` (replace). Example: `saiw"` wraps the word under cursor in quotes.

## File Structure

### New files
```
lua/plugins/colorscheme.lua       — nightfox.nvim (carbonfox)
lua/plugins/bufferline.lua        — akinsho/bufferline.nvim
lua/plugins/indent-blankline.lua  — lukas-reineke/indent-blankline.nvim
lua/plugins/gitsigns.lua          — lewis6991/gitsigns.nvim
lua/plugins/neoscroll.lua         — karb94/neoscroll.nvim
lua/plugins/autopairs.lua         — windwp/nvim-autopairs
lua/plugins/mini-comment.lua      — echasnovski/mini.comment
lua/plugins/mini-surround.lua     — echasnovski/mini.surround
```

### Modified files
```
lua/plugins/init.lua     — remove inline vscode.nvim block, add 8 new imports
lua/plugins/lualine.lua  — replace with polished carbonfox-compatible config
lua/settings.lua         — add cursorline + relativenumber
```

## Conventions

- Each plugin in its own file under `lua/plugins/`
- Files return a single lazy.nvim spec table
- Prefer `opts = {}` over `config = function()` where the plugin supports it
- `lua/plugins/init.lua` is the sole aggregator — all new files imported there
