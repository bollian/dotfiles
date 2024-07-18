return {
  { 'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  'hoob3rt/lualine.nvim',
  { 'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      sources = {"filesystem", "buffers", "git_status", "document_symbols"},
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
            -- Change type
            added     = "+",
            deleted   = "~",
            modified  = "M",
            renamed   = "R",
            -- Status type
            untracked = "?",
            ignored   = "I",
            unstaged  = "U",
            staged    = "S",
            conflict  = "C",
          }
        },
        type = { enabled = false },
        symlink_target = {
          enabled = true,
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
      buffers = {
        show_unloaded = true,
        window = {
          mappings = {
            ["<leader>q"] = "buffer_delete",
          },
        },
      },
      document_symbols = {
        follow_cursor = true,
        kinds = {
          Struct = { icon = "O" },
          Class = { icon = "O" },
          Object = { icon = "O" },
          Enum = { icon = "E" },
          EnumMember = { icon = "e" },
          Constant = { icon = "C" },
          Module = { icon = "N" },
          Namespace = { icon = "N" },
          Property = { icon = "P" },
          Function = { icon = "f" },
          Method = { icon = "F" },
          Variable = { icon = "v" },
          Field = { icon = "V" },
          TypeParameter = { icon = "T" },
        }
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
    },
  },
  { 'akinsho/toggleterm.nvim',
    opts = {
      open_mapping = '<c-y>',
      insert_mappings = true,
      direction = 'horizontal',
      hide_numbers = false,
    },
  },
  { 'AckslD/nvim-neoclip.lua', opts = {} },
  'lotabout/skim',
  'lotabout/skim.vim',
  { 'nvim-treesitter/nvim-treesitter-context',
    opts = {
        mode = 'topline',
    }
  },
}
