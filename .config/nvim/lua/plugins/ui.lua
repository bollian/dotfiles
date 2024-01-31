return {
  { 'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'TelescopePrompt',
        callback = function()
          require('cmp').setup.buffer {
            completion = { autocomplete = false }
          }
        end
      })

      require('telescope').setup {}
    end
  },
  'hoob3rt/lualine.nvim',
  { 'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require('neo-tree').setup {
        -- enable_diagnostics = false,
        default_component_configs = {
          icon = {
            folder_closed = '+',
            folder_open = '-',
            folder_empty = '>',
            default = '',
          },
          git_status = {
            symbols = {
              renamed = 'R',
              untracked = '?',
              ignored = 'I',
              unstaged = 'M',
              staged = 'S',
              conflict = 'C'
            }
          }
        },
        window = {
          position = 'current',
        },
        filesystem = {
          filtered_items = {
            visible = true,
          },
          commands = {
            grep_from = function(state)
              local telescopes = require('telescope.builtin')
              local node = state.tree:get_node()
              if node then
                local fpath = node:get_id()
                telescopes.live_grep {
                  search_dirs = {fpath}
                }
              end
            end,
            find_files_from = function(state)
              local telescopes = require('telescope.builtin')
              local node = state.tree:get_node()
              if node then
                local fpath = node:get_id()
                telescopes.find_files {
                  search_dirs = {fpath}
                }
              end
            end
          },
          window = {
            mappings = {
              ['<space>g'] = 'grep_from',
              ['<space>f'] = 'find_files_from',
              -- Use plain text search in the file tree. I have telescope for
              -- fuzzy finding.
              ['/'] = "none",
            },
          },
        },
        event_handlers = {
          {
            event = 'neo_tree_buffer_enter',
            handler = function()
              vim.opt.number = true
              vim.opt.relativenumber = true
            end,
            id = 'window_settings',
          }
        }
      }
    end,
  },
  'voldikss/vim-floaterm',
  { 'AckslD/nvim-neoclip.lua',
    config = function() require('neoclip').setup {} end,
  },
  'lotabout/skim',
  'lotabout/skim.vim',
  { 'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        mode = 'topline',
        patterns = {
          default = {
            'class',
            'function',
            'method'
          }
        }
      }
    end
  },
}
