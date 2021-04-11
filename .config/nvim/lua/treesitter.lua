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
        -- disable = {'rust', 'python'}
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false
    }
}
