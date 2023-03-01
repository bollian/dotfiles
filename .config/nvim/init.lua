-- clone lazy.nvim package manager if it does not exist
local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazy_path
  })
end

-- make sure to load the package manager first
vim.opt.rtp:prepend(lazy_path)

-- lazy wants this to happen first for some reason
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('lazy').setup('plugins')
-- require 'plugins'
require 'options'
require 'lsp'
require 'mappings'
require 'treesitter'
require 'statusline'
require 'dap-config'
