# Neovim Polish Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Transform the Neovim config from vscode.nvim to a fully polished Carbonfox setup with buffer tabs, indent guides, git gutter, smooth scroll, and three workflow plugins.

**Architecture:** Each new plugin gets its own file under `lua/plugins/` returning a lazy.nvim spec table. `lua/plugins/init.lua` is the sole aggregator — it imports all plugin files and is the only file that needs updating for each new addition. Settings changes go in `lua/settings.lua`.

**Tech Stack:** Neovim + lazy.nvim plugin manager. No git repo — skip commit steps. "Testing" means launching Neovim and visually verifying behavior.

---

## File Map

| Action | Path | Purpose |
|--------|------|---------|
| Modify | `lua/settings.lua` | Add cursorline + relativenumber |
| Create | `lua/plugins/colorscheme.lua` | nightfox.nvim (carbonfox variant) |
| Modify | `lua/plugins/init.lua` | Remove inline vscode.nvim block, add all new imports |
| Create | `lua/plugins/bufferline.lua` | Buffer tabs at top |
| Create | `lua/plugins/indent-blankline.lua` | Indent scope guides |
| Create | `lua/plugins/gitsigns.lua` | Git gutter signs + hunk keymaps |
| Create | `lua/plugins/neoscroll.lua` | Smooth scroll on C-d/C-u etc |
| Replace | `lua/plugins/lualine.lua` | Carbonfox-colored statusline with diff + diagnostics |
| Create | `lua/plugins/autopairs.lua` | Auto-close brackets/quotes |
| Create | `lua/plugins/mini-comment.lua` | gcc / gc comment toggling |
| Create | `lua/plugins/mini-surround.lua` | sa/sd/sr surround operations |

---

## Task 1: Settings — cursorline and relative numbers

**Files:**
- Modify: `lua/settings.lua`

- [ ] **Step 1: Add two lines to the bottom of `lua/settings.lua`**

```lua
vim.opt.cursorline = true
vim.opt.relativenumber = true
```

- [ ] **Step 2: Verify**

Open Neovim: `nvim lua/settings.lua`

Expected: the current line is highlighted with a subtle background, and line numbers show relative distances (e.g., `3`, `2`, `1`, `0`, `1`, `2`) rather than absolute numbers.

---

## Task 2: Colorscheme — replace vscode.nvim with carbonfox

**Files:**
- Create: `lua/plugins/colorscheme.lua`
- Modify: `lua/plugins/init.lua`

- [ ] **Step 1: Create `lua/plugins/colorscheme.lua`**

```lua
return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("carbonfox")
  end,
}
```

- [ ] **Step 2: Update `lua/plugins/init.lua`**

Remove the entire inline vscode.nvim block (the `{ "Mofiqul/vscode.nvim", ... }` table including its `config` function and the two `vim.api.nvim_set_hl` calls), and replace with an import line. The file should look like:

```lua
return {
  { import = "plugins.colorscheme" },
  { import = "plugins.lspconfig" },
  { import = "plugins.blink" },
  { import = "plugins.nvim-tree" },
  { import = "plugins.treesitter" },
  { import = "plugins.telescope" },
  { import = "plugins.which-key" },
  { import = "plugins.lualine" },
  { import = "plugins.mason" },
  { import = "plugins.mason-lspconfig" },
}
```

- [ ] **Step 3: Verify**

Open Neovim: `nvim`

Expected: pure black background (#161616), neon violet/blue/cyan syntax colors. No errors in the statusline or on startup. Run `:colorscheme` — should print `carbonfox`.

---

## Task 3: Bufferline — buffer tabs

**Files:**
- Create: `lua/plugins/bufferline.lua`
- Modify: `lua/plugins/init.lua`

- [ ] **Step 1: Create `lua/plugins/bufferline.lua`**

```lua
return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      offsets = {
        {
          filetype = "NvimTree",
          text = "Files",
          highlight = "Directory",
          separator = true,
        },
      },
    },
  },
}
```

- [ ] **Step 2: Add import to `lua/plugins/init.lua`**

Add `{ import = "plugins.bufferline" },` after the colorscheme import.

- [ ] **Step 3: Verify**

Open two files: `nvim lua/settings.lua lua/plugins/init.lua`

Expected: a tab bar appears at the top of the screen showing both filenames with icons. Switching buffers with `:bn` / `:bp` updates the active tab highlight.

---

## Task 4: Indent guides — indent-blankline

**Files:**
- Create: `lua/plugins/indent-blankline.lua`
- Modify: `lua/plugins/init.lua`

- [ ] **Step 1: Create `lua/plugins/indent-blankline.lua`**

```lua
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = { char = "│" },
    scope = { enabled = true },
  },
}
```

- [ ] **Step 2: Add import to `lua/plugins/init.lua`**

Add `{ import = "plugins.indent-blankline" },` after bufferline.

- [ ] **Step 3: Verify**

Open a file with nested indentation (e.g., `lua/plugins/lspconfig.lua`).

Expected: faint vertical `│` lines appear at each indent level. The scope of the current block (the innermost one the cursor is in) is highlighted slightly brighter.

---

## Task 5: Git gutter — gitsigns

**Files:**
- Create: `lua/plugins/gitsigns.lua`
- Modify: `lua/plugins/init.lua`

- [ ] **Step 1: Create `lua/plugins/gitsigns.lua`**

```lua
return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add          = { text = "│" },
      change       = { text = "│" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local opts = { buffer = bufnr, silent = true }
      vim.keymap.set("n", "]c", gs.next_hunk, vim.tbl_extend("force", opts, { desc = "Next hunk" }))
      vim.keymap.set("n", "[c", gs.prev_hunk, vim.tbl_extend("force", opts, { desc = "Previous hunk" }))
      vim.keymap.set("n", "<leader>hs", gs.stage_hunk, vim.tbl_extend("force", opts, { desc = "Stage hunk" }))
      vim.keymap.set("n", "<leader>hp", gs.preview_hunk, vim.tbl_extend("force", opts, { desc = "Preview hunk" }))
    end,
  },
}
```

- [ ] **Step 2: Add import to `lua/plugins/init.lua`**

Add `{ import = "plugins.gitsigns" },` after indent-blankline.

- [ ] **Step 3: Verify**

Open any file in a git-tracked directory, make a small edit (add a space), write the buffer.

Expected: a green `│` appears in the sign column next to changed lines. `]c` and `[c` jump between hunks. `,hp` shows an inline diff popup of the hunk.

---

## Task 6: Smooth scroll — neoscroll

**Files:**
- Create: `lua/plugins/neoscroll.lua`
- Modify: `lua/plugins/init.lua`

- [ ] **Step 1: Create `lua/plugins/neoscroll.lua`**

```lua
return {
  "karb94/neoscroll.nvim",
  opts = {
    easing = "sine",
    hide_cursor = false,
    duration_multiplier = 1.0,
  },
}
```

- [ ] **Step 2: Add import to `lua/plugins/init.lua`**

Add `{ import = "plugins.neoscroll" },` after gitsigns.

- [ ] **Step 3: Verify**

Open a long file (e.g., `lua/plugins/lspconfig.lua`) and press `C-d` then `C-u`.

Expected: scrolling animates smoothly with a sine easing curve instead of jumping instantly. `zt` and `zz` also animate.

---

## Task 7: Statusline — carbonfox lualine polish

This replaces the existing custom "bubbles" theme with an updated version using carbonfox colors and adding git diff counts and LSP diagnostics.

**Files:**
- Replace: `lua/plugins/lualine.lua`

- [ ] **Step 1: Replace the contents of `lua/plugins/lualine.lua`**

```lua
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local colors = {
      black  = "#161616",
      white  = "#f2f4f8",
      grey   = "#393939",
      blue   = "#78a9ff",
      violet = "#be95ff",
      cyan   = "#33b1ff",
      green  = "#42be65",
      pink   = "#ff7eb6",
    }

    local carbonfox_bubbles = {
      normal   = { a = { fg = colors.black, bg = colors.blue },   b = { fg = colors.white, bg = colors.grey }, c = { fg = colors.white } },
      insert   = { a = { fg = colors.black, bg = colors.green },  b = { fg = colors.white, bg = colors.grey }, c = { fg = colors.white } },
      visual   = { a = { fg = colors.black, bg = colors.violet }, b = { fg = colors.white, bg = colors.grey }, c = { fg = colors.white } },
      replace  = { a = { fg = colors.black, bg = colors.pink },   b = { fg = colors.white, bg = colors.grey }, c = { fg = colors.white } },
      inactive = { a = { fg = colors.white, bg = colors.black },  b = { fg = colors.white, bg = colors.black }, c = { fg = colors.white } },
    }

    require("lualine").setup({
      options = {
        theme = carbonfox_bubbles,
        component_separators = "",
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = {
          "branch",
          { "diff",        colored = true },
          { "diagnostics", sources = { "nvim_lsp" } },
        },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
    })
  end,
}
```

- [ ] **Step 2: Verify**

Open Neovim in a git repo directory.

Expected: the mode pill changes color per mode (blue=normal, green=insert, violet=visual, pink=replace). The statusline shows branch name, `+N ~N -N` diff counts, LSP error/warning counts, the relative file path, filetype, scroll percent, and line:col. No errors.

---

## Task 8: Auto-pairs — nvim-autopairs

**Files:**
- Create: `lua/plugins/autopairs.lua`
- Modify: `lua/plugins/init.lua`

- [ ] **Step 1: Create `lua/plugins/autopairs.lua`**

```lua
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {},
}
```

- [ ] **Step 2: Add import to `lua/plugins/init.lua`**

Add `{ import = "plugins.autopairs" },` after neoscroll.

- [ ] **Step 3: Verify**

Open a C file and enter insert mode. Type `(`, then `[`, then `{`, then `"`.

Expected: each opening character is immediately followed by its closing pair, with the cursor placed between them. Pressing `<CR>` inside `{}` creates an indented new line with the closing brace on the next line.

---

## Task 9: Comments — mini.comment

**Files:**
- Create: `lua/plugins/mini-comment.lua`
- Modify: `lua/plugins/init.lua`

- [ ] **Step 1: Create `lua/plugins/mini-comment.lua`**

```lua
return {
  "echasnovski/mini.comment",
  version = "*",
  opts = {},
}
```

- [ ] **Step 2: Add import to `lua/plugins/init.lua`**

Add `{ import = "plugins.mini-comment" },` after autopairs.

- [ ] **Step 3: Verify**

Open a C file (`nvim` any `.c` file), move the cursor to a line with code, and press `gcc` in normal mode.

Expected: the line is prefixed with `//` (C line comment). Press `gcc` again — the comment is removed. Press `gc` then `3j` — three lines are commented at once. In a Lua file, `gcc` should produce `--` instead.

---

## Task 10: Surround — mini.surround

**Files:**
- Create: `lua/plugins/mini-surround.lua`
- Modify: `lua/plugins/init.lua`

- [ ] **Step 1: Create `lua/plugins/mini-surround.lua`**

```lua
return {
  "echasnovski/mini.surround",
  version = "*",
  opts = {},
}
```

- [ ] **Step 2: Add import to `lua/plugins/init.lua`**

Add `{ import = "plugins.mini-surround" },` after mini-comment.

- [ ] **Step 3: Verify**

Open any file in normal mode. Place cursor on a word (e.g., `hello`).

- `saiw"` — wraps the word in double quotes: `"hello"`
- `sr"'` — replaces `"` with `'`: `'hello'`
- `sd'` — removes the surrounding quotes: `hello`

Expected: all three operations work without error. `:checkhealth mini.surround` shows no issues.

---

## Final State: `lua/plugins/init.lua`

After all tasks, the file should look exactly like this:

```lua
return {
  { import = "plugins.colorscheme" },
  { import = "plugins.lspconfig" },
  { import = "plugins.blink" },
  { import = "plugins.nvim-tree" },
  { import = "plugins.treesitter" },
  { import = "plugins.telescope" },
  { import = "plugins.which-key" },
  { import = "plugins.lualine" },
  { import = "plugins.mason" },
  { import = "plugins.mason-lspconfig" },
  { import = "plugins.bufferline" },
  { import = "plugins.indent-blankline" },
  { import = "plugins.gitsigns" },
  { import = "plugins.neoscroll" },
  { import = "plugins.autopairs" },
  { import = "plugins.mini-comment" },
  { import = "plugins.mini-surround" },
}
```
