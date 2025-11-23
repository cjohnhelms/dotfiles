require'nvim-treesitter.configs'.setup {
    ensure_installed = { "yaml", "json", "go", "rust", "ocaml", "python" },
	highlight = { enable = true },
	incremental_selection = { enable = true },
	textobjects = { enable = true },
}
