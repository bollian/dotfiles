return {
  'neovim/nvim-lspconfig',
  'nvim-lua/lsp_extensions.nvim',
  { 'nvim-lua/lsp-status.nvim',
    config = function()
      local lsp_status = require('lsp-status')
      lsp_status.config {
        diagnostics = false,
      }
      lsp_status.register_progress()
    end
  },
  { 'kosayoda/nvim-lightbulb',
    config = function()
      require('nvim-lightbulb').update_lightbulb {
        sign = {
          enabled = true,
          -- Priority of the gutter sign
          priority = 100,
          text = 'A'
        },
        float = {
          enabled = true,
          -- Text to show in the popup float
          text = "A",
          win_opts = {},
        },
        virtual_text = {
          enabled = false,
          -- Text to show at virtual text
          text = "A",
        }
      }
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        pattern = '*',
        callback = function()
          require('nvim-lightbulb').update_lightbulb()
        end
      })
    end
  },
  { 'hrsh7th/nvim-cmp',
    dependencies = {
      'quangnguyen30192/cmp-nvim-tags',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      local cmp = require 'cmp'
      cmp.setup {
        sources = cmp.config.sources({
          -- highest priority sources
          { name = 'nvim_lsp' },
        }, {
          -- next priority sources. not shown if higher priority is available
          { name = 'buffer' },
        }),
        view = {
          entries = 'native',
        },
        preselect = cmp.PreselectMode.None,
        mapping = {
          ['<Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
          ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
        },
      }

      -- enable buffer source for / search
      cmp.setup.cmdline('/', {
        sources = cmp.config.sources({
          { name = 'buffer' },
        })
      })
    end
  },
  { 'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup({
        -- not necessary so long as the rest of the signature is visible
        hint_enable = false,
        toggle_key = '<C-s>',
      })
    end
  },
}
