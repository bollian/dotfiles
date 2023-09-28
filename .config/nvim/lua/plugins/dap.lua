-- This file manages all things related to debuging through the Debug Adapter
-- Protocol (DAP).

return {
  { 'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')

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
    end,
  },
  { 'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      local dapui = require('dapui')
      dapui.setup()

      local function close_dap()
        if Dap_tabpage ~= nil then
          vim.api.nvim_set_current_tabpage(Dap_tabpage)
          dapui.close()
          vim.cmd 'tabclose'
          Dap_tabpage = nil
        end
      end

      -- create a tab for the debug UI if it doesn't exist
      -- switch to that tab if it's not currently open
      -- close that tab if it is currently open
      ---@diagnostic disable-next-line: unused-local
      vim.api.nvim_create_user_command('DapUi', function(state)
        if Dap_tabpage == nil then
          vim.cmd 'tab split'
          vim.t.guitablabel = 'Debug'
          Dap_tabpage = vim.api.nvim_get_current_tabpage()
          dapui.open()
        elseif Dap_tabpage == vim.api.nvim_get_current_tabpage() then
          close_dap()
        else
          vim.api.nvim_set_current_tabpage(Dap_tabpage)
        end
      end, {desc = 'Toggle/Focus the Debug UI'})
    end,
  },
  { 'mfussenegger/nvim-dap-python',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      local dap_python = require('dap-python')
      local dap_actions = require('dap-actions')

      dap_python.test_runner = 'pytest'

      dap_actions.register_ft_debug_behaviors('python', {
        debug_test = dap_python.test_method,
        debug_fixture = dap_python.test_method,
        debug_selection = dap_python.debug_selection,
        test_selection = dap_python.test_selection
      })
    end
  },
}
