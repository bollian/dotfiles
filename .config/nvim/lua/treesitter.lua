local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- not using expr until I can get it to only fold functions
wo.foldmethod = 'manual'
vim.cmd 'set foldexpr=nvim_treesitter#foldexpr()'

require'nvim-treesitter.configs'.setup {
    ensure_installed = 'maintained',
    highlight = {
        enable = true,
        -- disable = {'rust', 'python'} -- list of languages to disable
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 's',
            node_incremental = 'sn',
            scope_incremental = 'ss',
            node_decremental = 'sd'
        },
        -- disable = {'rust'}
    },
    indent = {
        enable = true,
        disable = {'c', 'python', 'rust'}
    },
    playground = {
        enable = true,
        disable = {},
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
                --     python = "(function_definition) @function",
                --     cpp = "(function_definition) @function",
                --     c = "(function_definition) @function",
                --     java = "(method_declaration) @function",
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
}
