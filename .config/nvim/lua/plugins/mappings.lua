return {
  { 'anuvyklack/hydra.nvim',
    config = function()
      local hydra = require('hydra')
      local dap = require('dap')
      local dap_actions = require('dap-actions')
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
          { 'B', dap_actions.conditional_bp, { desc = 'Set conditional breakpoint' } },
          { 'l', dap_actions.logpoint, { desc = 'Set logpoint' } },
          { 't', dap_actions.debug_test, { desc = 'Debug the hovered test function' } },
          { 'F', dap_actions.debug_fixture, { desc = 'Debug the hovered test fixture' } },
          { 'v', dap_actions.debug_selection, { desc = 'Debug the highlighted code', } },
          { 'r', dap.run_last, { desc = 'Rerun previous configuration' } },
          { 'R', dap.repl.open, { desc = 'Open REPL' } },
          { 'q', dap.terminate, { desc = 'Kill current session', exit = true } },
          { '<esc>', nil, { exit = true } },
        },
      })
    end
  }
}
