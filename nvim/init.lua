local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- theme
Plug('Mofiqul/vscode.nvim')

-- tree
Plug('kyazdani42/nvim-tree.lua')
Plug('kyazdani42/nvim-web-devicons')

-- tree sitter
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

-- lsp
Plug('neovim/nvim-lspconfig')

vim.call('plug#end')

home=os.getenv("HOME")
package.path = home .. "/.config/nvim/?.lua;" .. package.path


require "common"
require "tree"
require "lsp"
require "treesitter"
