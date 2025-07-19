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
        name = "Listen for XDebug (Docker)",
        port = 9003,
        pathMappings = {
            -- Map container paths to local paths
            -- Adjust these mappings based on your Docker setup
            ["/var/www/html"] = vim.fn.getcwd(),
            ["/app"] = vim.fn.getcwd(),
            ["/var/www"] = vim.fn.getcwd(),
        },
        ignore = {
            "**/vendor/**/*.php",
            "**/node_modules/**/*.php"
        },
        xdebugSettings = {
            max_children = 128,
            max_data = 512,
            max_depth = 3
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
    element_mappings = {
        scopes = {
            edit = "e",
            repl = "r",
            toggle = "t",
        },
        console = {
            toggle = "t",
        },
        repl = {
            toggle = "t",
        },
    },
})

-- DAP Virtual Text setup
require("nvim-dap-virtual-text").setup({
    enabled = true,
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = false,
    show_stop_reason = true,
    commented = false,
    virt_text_pos = 'eol',
    all_frames = true,
    virt_lines = false,
    virt_text_win_col = nil
})

-- DAP event handlers
local dapui = require("dapui")

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

-- Additional debugging helpers
vim.keymap.set('n', '<leader>dc', function() dap.clear_breakpoints() end)
vim.keymap.set('n', '<leader>ds', function() dap.session() end)
vim.keymap.set('n', '<leader>di', function() dap.list_breakpoints() end)

-- Function to check if we're in a debugging session
local function is_debugging()
    return dap.session() ~= nil
end

-- Auto-open DAP UI when debugging starts
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
    -- Force refresh the current buffer to ensure proper cursor positioning
    vim.cmd('checktime')
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- Add a command to manually refresh the current buffer
vim.api.nvim_create_user_command('DapRefresh', function()
    vim.cmd('checktime')
    print('Buffer refreshed for debugging')
end, {})

-- Add a command to show current path mappings
vim.api.nvim_create_user_command('DapPaths', function()
    local config = dap.configurations.php[1]
    print('Docker Xdebug Configuration:')
    print('Port:', config.port)
    print('Path mappings (Container -> Local):')
    for container_path, local_path in pairs(config.pathMappings) do
        print('  ' .. container_path .. ' -> ' .. local_path)
    end
end, {})

-- Add a command to help debug path mapping issues
vim.api.nvim_create_user_command('DapDebugPath', function()
    local current_file = vim.fn.expand('%:p')
    local cwd = vim.fn.getcwd()
    print('Current file:', current_file)
    print('Working directory:', cwd)
    print('Relative path from cwd:', vim.fn.fnamemodify(current_file, ':.'))
    
    local config = dap.configurations.php[1]
    print('\nAvailable container mappings:')
    for container_path, local_path in pairs(config.pathMappings) do
        print('  ' .. container_path .. ' -> ' .. local_path)
        if vim.fn.isdirectory(local_path) == 1 then
            print('    ✓ Local path exists')
        else
            print('    ✗ Local path does not exist')
        end
    end
end, {})
