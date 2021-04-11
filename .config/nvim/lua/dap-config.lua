local dap = require 'dap'
dap.adapters.python = {
    type = 'executable',
    command = 'python3',
    args = {'-m', 'debugpy.adapter'}
}
dap.adapters.cpp = {
    type = 'executable',
    name = 'lldb-cpp',
    command = 'lldb-vscode-11',
    args = {},
    attach = {
        pidProperty = "processId",
        pidSelect = "ask"
    },
    env = {
        LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
    }
}
