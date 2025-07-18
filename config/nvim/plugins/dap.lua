local dap = require('dap')
require('telescope').load_extension('dap')

-- Enable DAP logging
dap.set_log_level('DEBUG')

-- Associate .theme files with PHP
vim.filetype.add({
    extension = {
        theme = "php"
    }
})

-- PHP Xdebug configuration
dap.adapters.php = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/Code/vscode-php-debug/out/phpDebug.js" }
}

dap.configurations.php = {
    {
        type = "php",
        request = "launch",
        name = "Listen for XDebug",
        port = 9003,
        pathMappings = {
            ["/var/www/html/"] = "${workspaceRoot}"
        }
    }
}

-- DAP UI setup
require("dapui").setup({
    layouts = {
        {
            elements = {
                "scopes",
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 40,
            position = "left",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 10,
            position = "bottom",
        },
    },
    floating = {
        border = "rounded",
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
})

-- DAP Virtual Text setup
require("nvim-dap-virtual-text").setup()

-- DAP event handlers
local dapui = require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- Keybindings for debugging
vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)
vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
vim.keymap.set('n', '<leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<leader>dl', function() dap.run_last() end)
vim.keymap.set('n', '<leader>dp', function() dap.run(dap.configurations.php[1]) end)
vim.keymap.set('n', '<leader>dt', function() require("dapui").toggle() end)
