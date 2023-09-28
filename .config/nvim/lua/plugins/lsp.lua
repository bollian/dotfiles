return {
  'neovim/nvim-lspconfig',
  'nvim-lua/lsp_extensions.nvim',
  { 'kosayoda/nvim-lightbulb',
    config = function()
      local lightbulb = require('nvim-lightbulb')
      lightbulb.setup {
        autocmd = {
          enabled = true,
        },
        sign = {
          enabled = true,
          -- Priority of the gutter sign
          priority = 100,
          text = 'A'
        },
        float = {
          enabled = false,
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
      local cmp = require('cmp')
      cmp.setup {
        sources = cmp.config.sources({
          -- highest priority sources
          { name = 'nvim_lsp' },
        }, {
          -- next priority sources. not shown if higher priority is available
          { name = 'buffer' },
        }),
        view = {
          entries = 'custom',
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
      cmp.setup.cmdline('/\v', {
        sources = cmp.config.sources({
          { name = 'buffer' },
        })
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = { ignore_cmds = { '!' } }
          }
        })
      })
    end
  },
  'ray-x/lsp_signature.nvim',
}
