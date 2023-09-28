return {
  { 'eddyekofo94/gruvbox-flat.nvim',
    priority = 100,
    config = function()
      vim.g.gruvbox_flat_style = 'hard'
      vim.cmd 'colorscheme gruvbox-flat'
    end
  },
  { 'nvim-treesitter/nvim-treesitter',
    main = 'nvim-treesitter.configs',
    opts = {
      -- ensure_installed = "all",
      ignore_installed = {'tree-sitter-smali'}, -- this isn't working?
      highlight = {
        enable = true,
        -- disable = {'cmake'},
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 's',
          node_incremental = 'sn',
          scope_incremental = 'ss',
          node_decremental = 'sd'
        },
        -- disable = {'cmake'}
      },
      indent = {
        enable = true,
        disable = {'c', 'cpp', 'python', 'rust'}
      },
      playground = {
        enable = true,
        -- disable = {'cmake'},
        updatetime = 25,
        persist_queries = false
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",

            -- Or you can define your own textobjects like this
            -- ["iF"] = {
            --   python = "(function_definition) @function",
            --   cpp = "(function_definition) @function",
            --   c = "(function_definition) @function",
            --   java = "(method_declaration) @function",
            -- },
          }
        },
        swap = {
          enable = true,
          swap_next = {
            ["<c-.>"] = "@parameter.inner",
          },
          swap_previous = {
            ["<c-,>"] = "@parameter.inner",
          }
        },
        move = {
          enable = true,
          set_jumps = false, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]]"] = "@function.outer",
            ["]m"] = "@class.outer",
          },
          goto_next_end = {
            ["]["] = "@function.outer",
            ["]M"] = "@class.outer",
          },
          goto_previous_start = {
            ["[["] = "@function.outer",
            ["[m"] = "@class.outer",
          },
          goto_previous_end = {
            ["[]"] = "@function.outer",
            ["[M"] = "@class.outer",
          },
        },
      },
    },
  },
  'nvim-treesitter/playground',

  -- Language-specific plugins
  'arm9/arm-syntax-vim',
  'lervag/vimtex',
}
