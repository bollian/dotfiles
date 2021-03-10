local o = vim.o
local wo = vim.wo
local bo = vim.bo

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
