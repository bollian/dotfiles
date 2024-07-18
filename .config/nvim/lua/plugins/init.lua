return {
  -- Editing functionality
  'moll/vim-bbye',
  { 'numToStr/Comment.nvim', opts = {}, },
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'nvim-treesitter/nvim-treesitter-textobjects',
  { 'windwp/nvim-autopairs', opts = {}, },

  -- Extra editor functionality
  { 'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        -- the dap ui doesn't save well, so just close it
        pre_save_cmds = { require('dap-config').close_dap },
      }
    end
  },
  { 'ojroques/nvim-osc52',
    enabled = function()
      return vim.fn.has('win32') == 1
    end,
    config = function()
      -- use nvim-osc52 as a clipboard provider
      local function copy(lines, _)
        require('osc52').copy(table.concat(lines, '\n'))
      end

      local function paste()
        return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
      end

      vim.g.clipboard = {
        name = 'osc52',
        copy = { ['+'] = copy, ['*'] = copy },
        paste = { ['+'] = paste, ['*'] = paste },
      }
    end
  },
  'anuvyklack/hydra.nvim',
  { 'pocco81/auto-save.nvim',
    opts = {
      execution_message = {
        message = function()
          return ''
        end
      },
      condition = function(buf)
        return vim.bo[buf].filetype == 'typst'
      end
    },
  },

  -- Debugging support
  { 'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    opts = {},
  },
  { 'mfussenegger/nvim-dap-python', dependencies = { 'mfussenegger/nvim-dap' } },
}
