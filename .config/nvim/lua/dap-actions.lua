local dap = require('dap')
local M = {}

local function placeholder_msg(behavior_name)
  local msg = vim.bo.filetype .. ' has no "' .. behavior_name .. '" behavior set'
  return function() print(msg) end
end

local function conditional_breakpoint()
  dap.set_breakpoint(vim.fn.input('Condition: '))
end

local function logpoint()
  dap.set_breakpoint(nil, nil, vim.fn.input('Log message: '))
end

local default_debug_behaviors = {
  conditional_breakpoint = conditional_breakpoint,
  logpoint = logpoint,
  debug_test = placeholder_msg('debug unit test'),
  debug_fixture = placeholder_msg('debug test fixture'),
  debug_selection = placeholder_msg('debug selection'),
  test_selection = placeholder_msg('test selection'),
}

local ft_debug_behaviors = {}

M.register_ft_debug_behaviors = function(filetype, behaviors)
  ft_debug_behaviors[filetype] = vim.tbl_extend('keep', behaviors, default_debug_behaviors)
end

local function current_behaviors()
  return ft_debug_behaviors[vim.bo.filetype] or default_debug_behaviors
end

M.conditional_breakpoint = function() current_behaviors().conditional_breakpoint() end
M.logpoint = function() current_behaviors().logpoint() end
M.debug_test = function() current_behaviors().debug_test() end
M.debug_fixture = function() current_behaviors().debug_fixture() end
M.debug_selection = function() current_behaviors().debug_selection() end
M.test_selection = function() current_behaviors().test_selection() end

return M
