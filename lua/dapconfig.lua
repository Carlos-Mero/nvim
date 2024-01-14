vim.fn.sign_define('DapBreakpoint', {
    text='断', texthl='Macro', linehl='dbkline', numhl='dbknum'})
vim.fn.sign_define('DapStopped', {
    text='行', texthl='String', linehl='dstline', numhl='dstnum'})

local dap = require('dap')
dap.defaults.fallback.focus_terminal = true
dap.adapters.lldb = {
    type = 'executable',
    command = '/opt/homebrew/opt/llvm/bin/lldb-vscode',
    name = 'lldb'
}
dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.adapters.python = function(cb, config)
    if config.request == 'attach' then
        local port = (config.connect or config).port
        local host = (config.connect or config).host or '127.0.0.1'
        cb({
            type = 'server',
            port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            host = host,
            options = {
                source_filetype = 'python',
            },
        })
    else
        cb({
            type = 'executable',
            command = '/opt/homebrew/bin/python3',
            args = { '-m', 'debugpy.adapter' },
            options = {
                source_filetype = 'python',
            },
        })
    end
end

dap.configurations.python = {
    {
        type = 'python';
        request = 'launch';
        name = "Launch file";

        program = "${file}";
        pythonPath = function()
            return '/opt/homebrew/Caskroom/miniconda/base/bin/python3'
        end;
    },
}

vim.keymap.set('n', '<M-r>', function() dap.continue() end)
vim.keymap.set('n', '<M-j>', function() dap.step_into() end)
vim.keymap.set('n', '<M-n>', function() dap.run_to_cursor() end)
vim.keymap.set('n', '<M-k>', function() dap.step_back() end)
vim.keymap.set('n', '<M-l>', function() dap.step_out() end)
vim.keymap.set('n', '<M-c>', function() dap.terminate() end)
vim.keymap.set('n', '<M-b>', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<M-B>', function() dap.clear_breakpoints() end)
vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<M-d>', function() dap.repl.toggle() end)
vim.keymap.set('n', '<Leader>r', function() dap.run_last() end)

local widgets = require('dap.ui.widgets')
local scope_bar = widgets.sidebar(widgets.scopes)
local frame_bar = widgets.sidebar(widgets.frames)
vim.keymap.set({'n', 'v'}, '<M-h>', function()
    widgets.hover()
end)
vim.keymap.set({'n', 'v'}, '<M-p>', function()
    widgets.preview()
end)
vim.keymap.set('n', '<M-f>', function()
    frame_bar.toggle()
end)
vim.keymap.set('n', '<M-s>', function()
    scope_bar.toggle()
end)
vim.keymap.set('n', 'm', function()
    require('dap.ui').trigger_actions({ mode = 'first' })
end)
vim.keymap.set('n', ',', function()
    require('dap.ui').trigger_actions({ mode = 'first' })
end)
