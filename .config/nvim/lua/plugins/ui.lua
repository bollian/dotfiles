return {
  { 'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        defaults = {
          -- borderchars = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
          borderchars = {
            prompt = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
            results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          }
        },
      }

      vim.api.nvim_create_user_command("History", require('telescope.builtin').command_history, {
        desc = "Search your command history",
      })

      -- disable autocompletion in the telescope search field
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'TelescopePrompt',
        callback = function()
          require('cmp').setup.buffer {
            completion = { autocomplete = false }
          }
        end
      })
    end
  },
  { 'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
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
              ['g'] = 'grep_from',
              ['f'] = 'find_files_from',
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
    config = function()
      require('neoclip').setup {}
      require('telescope').load_extension('neoclip')
    end,
  },
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
