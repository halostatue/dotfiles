return {
  -- {
  --   'puremourning/vimspector', -- https://github.com/puremourning/vimspector
  --   -- Note: not fully compatibel with neovim
  --   setup = function() vim.g.vimspector_enable_mappings = 'HUMAN' end,
  --   event = 'VimEnter'
  -- }, --
  -- {
  --   'rcarriga/nvim-dap-ui',
  --   config = function() require('dapui').setup() end,
  --   dependencies = {
  --     {
  --       'mfussenegger/nvim-dap', -- https://github.com/mfussenegger/nvim-dap
  --       dependencies = {
  --         {'jbyuki/one-small-step-for-vimkind'} -- https://github.com/jbyuki/one-small-step-for-vimkind
  --       },
  --       init = function()
  --         local map = require('config.utils').map

  --         vim.api.neovim_command [[command! BreakpointToggle lua require('dap').toggle_breakpoint()]]
  --         vim.api.neovim_command [[command! Debug lua require('dap').continue()]]
  --         vim.api.neovim_command [[command! DapREPL lua require('dap').repl.open()]]

  --         vim.keymap.set('n', '<F5>', [[<cmd>lua require'dap'.continue()<CR>]])
  --         vim.keymap.set('n', '<F10>', [[<cmd>lua require'dap'.step_over()<CR>]])
  --         vim.keymap.set('n', '<F11>', [[<cmd>lua require'dap'.step_into()<CR>]])
  --         vim.keymap.set('n', '<F12>', [[<cmd>lua require'dap'.step_out()<CR>]])
  --       end,
  --       config = function()
  --         local dap = require('dap')

  --         -- Debugpy
  --         dap.adapters.python = {
  --           type = 'executable',
  --           command = 'python',
  --           args = {'-m', 'debugpy.adapter'}
  --         }

  --         dap.configurations.python = {
  --           {
  --             type = 'python',
  --             request = 'launch',
  --             name = 'Launch file',
  --             program = '${file}',
  --             pythonPath = function()
  --               local venv_path = vim.fn.getenv 'VIRTUAL_ENVIRONMENT'
  --               if venv_path ~= vim.NIL and venv_path ~= '' then
  --                 return venv_path .. '/bin/python'
  --               else
  --                 return '/usr/bin/python'
  --               end
  --             end
  --           }
  --         }

  --         -- Neovim Lua
  --         dap.adapters.nlua = function(callback, config)
  --           callback {type = 'server', host = config.host, port = config.port}
  --         end

  --         dap.configurations.lua = {
  --           {
  --             type = 'nlua',
  --             request = 'attach',
  --             name = 'Attach to running Neovim instance',
  --             host = function()
  --               local value = vim.fn.input 'Host [127.0.0.1]: '
  --               if value ~= '' then return value end
  --               return '127.0.0.1'
  --             end,
  --             port = function()
  --               local val = tonumber(vim.fn.input 'Port: ')
  --               assert(val, 'Please provide a port number')
  --               return val
  --             end
  --           }
  --         }

  --         -- lldb
  --         dap.adapters.lldb = {type = 'executable', command = '/usr/bin/lldb-vscode', name = 'lldb'}

  --         dap.configurations.cpp = {
  --           {
  --             name = 'Launch',
  --             type = 'lldb',
  --             request = 'launch',
  --             program = function()
  --               return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  --             end,
  --             cwd = '${workspaceFolder}',
  --             stopOnEntry = false,
  --             args = {},
  --             runInTerminal = false
  --           }
  --         }

  --         dap.configurations.c = dap.configurations.cpp
  --         dap.configurations.rust = dap.configurations.cpp

  --         vim.g.dap_virtual_text = true
  --       end
  --     }
  --   }
  -- }, --
  -- {'theHamsta/nvim-dap-virtual-text'} -- https://github.com/theHamsta/nvim-dap-virtual-text
}
