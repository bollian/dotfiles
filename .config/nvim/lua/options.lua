local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- support mouse selection, clicking, etc
o.mouse = 'a'

-- no automatic word-wrapping
bo.tw = 0

-- only redraw when necessary (makes macros run faster)
o.lazyredraw = true

-- show whitespace
wo.list = true
o.listchars = 'tab:→ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»'

-- show line numbers relative to the current position
wo.number = true
wo.relativenumber = true

-- Show when I'm in an open fold
wo.foldcolumn = '1'

-- Automatically close folds when leaving them
o.foldclose = 'all'

-- Keep the cursor 10 lines from the top/bottom of the screen
o.scrolloff = 10

-- Automatically hit enter for me
bo.textwidth=80

-- Required for operations modifying multiple buffers like rename.
o.hidden = true

-- Highlight the line your cursor is on
wo.cursorline = true

-- Prevent the window from resizing due to the gitgutter being added
wo.signcolumn = 'yes'

-- ignore casing when searching w/ all lower-case letters
o.ignorecase = true
o.smartcase = true

-- showmode hides the echodoc function signatures,
-- and airline already shows the mode
o.showmode = false

-- persist undo history between sessions
bo.undofile = true

require'nvim-lightbulb'.update_lightbulb {
    sign = {
        enabled = true,
        -- Priority of the gutter sign
        priority = 100,
        text = 'A'
    },
    float = {
        enabled = false,
        -- Text to show in the popup float
        text = "💡",
        -- Available keys for window options:
        -- - height     of floating window
        -- - width      of floating window
        -- - wrap_at    character to wrap at for computing height
        -- - max_width  maximal width of floating window
        -- - max_height maximal height of floating window
        -- - pad_left   number of columns to pad contents at left
        -- - pad_right  number of columns to pad contents at right
        -- - pad_top    number of lines to pad contents at top
        -- - pad_bottom number of lines to pad contents at bottom
        -- - offset_x   x-axis offset of the floating window
        -- - offset_y   y-axis offset of the floating window
        -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
        -- - winblend   transparency of the window (0-100)
        win_opts = {},
    },
    virtual_text = {
        enabled = false,
        -- Text to show at virtual text
        text = "💡",
    }
}
