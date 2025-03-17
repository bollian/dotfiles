local dap = require 'dap'
local dapui = require 'dapui'
local hydra = require 'hydra'
local dap_python = require 'dap-python'
local M = {}

dap.adapters.python = {
  id = 'debugpy',
  type = 'executable',
  command = 'python3',
  args = {'-m', 'debugpy.adapter'}
}

dap.adapters.c = {
  id = 'cppdbg',
  type = 'executable',
  command = os.getenv('HOME') .. '/opt/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}
dap.adapters.cpp = dap.adapters.c

dap.configurations.c = {
  {
    name = 'dockerized core dump',
    MIMode = 'gdb',
    args = function()
      local container_name = vim.fn.input('Container name: ', 'fulldev')
      local core_path = vim.fn.input('Core dump path: ', '', 'file')
      return {
        core_path = core_path,
      }
    end,
    type = 'cppdbg',
    request = 'launch', -- launch a new process inside a debugger
    program = function()
      local path = vim.fn.input('Executable path: ', '', 'file')
      return (path and path ~= '') and path or dap.ABORT
    end,
  }
}
dap.configurations.cpp = dap.configurations.c

-- dap.adapters.cpp = {
--     type = 'executable',
--     name = 'lldb-cpp',
--     command = 'lldb-vscode-11',
--     args = {},
--     attach = {
--         pidProperty = "processId",
--         pidSelect = "ask"
--     },
--     env = {
--         LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
--     }
-- }

-- create a tab for the debug UI if it doesn't exist
-- switch to that tab if it's not currently open
-- close that tab if it is currently open
---@diagnostic disable-next-line: unused-local
vim.api.nvim_create_user_command('DapUi', function(state)
  if DapTabpage == nil then
    vim.cmd 'tab split'
    vim.t.guitablabel = 'Debug'
    DapTabpage = vim.api.nvim_get_current_tabpage()
    dapui.open()
  elseif DapTabpage == vim.api.nvim_get_current_tabpage() then
    M.close_dap()
  else
    vim.api.nvim_set_current_tabpage(DapTabpage)
  end
end, {})

M.close_dap = function()
  if DapTabpage ~= nil then
    vim.api.nvim_set_current_tabpage(DapTabpage)
    dapui.close()
    vim.cmd 'tabclose'
    DapTabpage = nil
  end
end

dap_python.test_runner = 'pytest'


-- debug mode with dedicated keymaps
local function conditional_bp()
  dap.set_breakpoint(vim.fn.input('Condition: '))
end

local function logpoint()
  dap.set_breakpoint(nil, nil, vim.fn.input('Log message: '))
end

local function debug_test()
  if vim.bo.filetype == 'python' then
    dap_python.test_method()
  else
    print(vim.bo.filetype .. ' has no "debug unit test" keymap set')
  end
end

local function debug_fixture()
  if vim.bo.filetype == 'python' then
    dap_python.test_method()
  else
    print(vim.bo.filetype .. ' has no "debug test fixture" keymap set')
  end
end

local function debug_selection()
  if vim.bo.filetype == 'python' then
    dap_python.debug_selection()
  else
    print(vim.bo.filetype .. ' has no "debug test fixture" keymap set')
  end
end

local hint = [[

 _c_: Continue/start      _t_: Debug test
 _n_: Next                _F_: Debug fixture
 _s_: Step                _v_: Debug selection 
 _f_: Finish function     _r_: Rerun previous
 _b_: Toggle break        _R_: Open REPL
 _B_: Conditional break   _q_: Quit session
 _l_: Logpoint
                    _<esc>_

]]
hydra({
  name = 'Debug',
  mode = 'n',
  body = '<leader>d',
  hint = hint,
  config = {
    color = 'pink',
    invoke_on_body = true,
    hint = {
      type = 'window',
      position = 'middle-right',
    },
  },
  heads = {
    { 'c', dap.continue, { desc = 'Continue or start until next breakpoint' } },
    { 'n', dap.step_over, { desc = 'Step over, not entering functions' } },
    { 's', dap.step_into, { desc = 'Step into, entering any functions' } },
    { 'f', dap.step_out, { desc = 'Step out, finishing current function' } },
    { 'b', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' } },
    { 'B', conditional_bp, { desc = 'Set conditional breakpoint' } },
    { 'l', logpoint, { desc = 'Set logpoint' } },
    { 't', debug_test, { desc = 'Debug the hovered test function' } },
    { 'F', debug_fixture, { desc = 'Debug the hovered test fixture' } },
    { 'v', debug_selection, { desc = 'Debug the highlighted code', } },
    { 'r', dap.run_last, { desc = 'Rerun previous configuration' } },
    { 'R', dap.repl.open, { desc = 'Open REPL' } },
    { 'q', dap.terminate, { desc = 'Kill current session', exit = true } },
    { '<esc>', nil, { exit = true } },
  },
})

return M
