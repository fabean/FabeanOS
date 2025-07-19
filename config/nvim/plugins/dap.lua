local dap = require('dap')
require('telescope').load_extension('dap')

-- Enable DAP logging
-- dap.set_log_level('DEBUG')

-- Associate .theme files with PHP
vim.filetype.add({
    extension = {
        theme = "php",
        install = "php",
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
vim.keymap.set('n', '<leader>dR', function() dap.repl.open() end)
vim.keymap.set('n', '<leader>dl', function() dap.run_last() end)
vim.keymap.set('n', '<leader>dp', function() dap.run(dap.configurations.php[1]) end)
vim.keymap.set('n', '<leader>dt', function() require("dapui").toggle() end)

-- Additional debugging helpers
vim.keymap.set('n', '<leader>dc', function() dap.clear_breakpoints() end)
vim.keymap.set('n', '<leader>ds', function() dap.session() end)
vim.keymap.set('n', '<leader>di', function() dap.list_breakpoints() end)

-- Variable inspection helpers
vim.keymap.set('n', '<leader>dv', function() 
    local dapui = require("dapui")
    dapui.float_element("scopes", { enter = true })
end, { desc = "Open scopes in float" })

vim.keymap.set('n', '<leader>dw', function() 
    local dapui = require("dapui")
    dapui.float_element("watches", { enter = true })
end, { desc = "Open watches in float" })

vim.keymap.set('n', '<leader>dr', function() 
    local dapui = require("dapui")
    dapui.float_element("repl", { enter = true })
end, { desc = "Open REPL in float" })

-- Quick watch variable under cursor
vim.keymap.set('n', '<leader>dW', function()
    local word = vim.fn.expand('<cword>')
    if word and word ~= "" then
        dap.set_breakpoint(nil, nil, word)
        print('Added watch for: ' .. word)
    end
end, { desc = "Watch variable under cursor" })

-- Inject current scope variables into REPL
vim.keymap.set('n', '<leader>di', function()
    local session = dap.session()
    if not session then
        print("No active debug session")
        return
    end
    
    -- Get the current frame to access variables
    local frame = session.current_frame
    if not frame then
        print("No current frame available")
        return
    end
    
    -- This is a simplified approach - in practice, you'd need to
    -- use the DAP protocol to get variables from the current scope
    print("=== Injecting current scope variables into REPL ===")
    print("Note: This feature requires the DAP adapter to support")
    print("variable evaluation in the current scope.")
    print("")
    print("For now, use these approaches:")
    print("1. Use <leader>dv to see variables in scopes pane")
    print("2. Use watches to monitor specific variables")
    print("3. Use PHP expressions directly in REPL:")
    print("   - var_dump($GLOBALS)")
    print("   - print_r($_SESSION)")
    print("   - json_encode($object, JSON_PRETTY_PRINT)")
end, { desc = "Inject variables into REPL" })

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

-- Enhanced REPL functionality for PHP debugging
local function setup_php_repl()
    local repl = dap.repl
    
    -- Add PHP-specific helper functions to REPL
    local function add_php_helpers()
        -- Get current scope variables as a PHP array
        local function get_vars()
            local session = dap.session()
            if not session then return "No active debug session" end
            
            -- This would need to be implemented based on the specific DAP adapter
            -- For now, we'll provide a template for manual exploration
            return [[
// Current scope variables (use these in your expressions):
// $GLOBALS - Global variables
// $_GET, $_POST, $_REQUEST - Request variables  
// $_SESSION - Session variables
// $_COOKIE - Cookie variables
// $_SERVER - Server variables
// $_FILES - File upload variables
// $_ENV - Environment variables

// To explore objects:
// get_class_methods($object)
// get_class_vars($object) 
// get_object_vars($object)
// var_dump($object)
// print_r($object)
// json_encode($object, JSON_PRETTY_PRINT)
            ]]
        end
        
        -- Helper to explore object methods
        local function explore_object()
            return [[
// Object exploration helpers:
// Replace 'object' with your actual variable name

// Get all methods:
get_class_methods($object)

// Get all properties:
get_class_vars(get_class($object))

// Get current object properties:
get_object_vars($object)

// Get parent class:
get_parent_class($object)

// Check if method exists:
method_exists($object, 'method_name')

// Check if property exists:
property_exists($object, 'property_name')

// Get class name:
get_class($object)

// Get interfaces:
class_implements($object)

// Get traits:
class_uses($object)
            ]]
        end
        
        -- Helper for array/collection exploration
        local function explore_array()
            return [[
// Array/Collection exploration:
// Replace 'array' with your actual variable name

// Count elements:
count($array)

// Get keys:
array_keys($array)

// Get values:
array_values($array)

// Check if key exists:
array_key_exists('key', $array)

// Get first element:
reset($array)

// Get last element:
end($array)

// Filter array:
array_filter($array, function($item) { return /* condition */; })

// Map array:
array_map(function($item) { return /* transformation */; }, $array)

// For collections (Laravel, etc.):
// $collection->count()
// $collection->keys()
// $collection->values()
// $collection->first()
// $collection->last()
// $collection->filter(function($item) { return /* condition */; })
// $collection->map(function($item) { return /* transformation */; })
            ]]
        end
        
        return {
            vars = get_vars,
            explore = explore_object,
            array = explore_array
        }
    end
    
    -- Override the default REPL open to add PHP helpers
    local original_open = repl.open
    repl.open = function()
        original_open()
        
        -- Wait a bit for the REPL to initialize, then add helpers
        vim.defer_fn(function()
            local helpers = add_php_helpers()
            
            -- Add helper commands to the REPL
            repl.commands = repl.commands or {}
            repl.commands.vars = function()
                print(helpers.vars())
            end
            repl.commands.explore = function()
                print(helpers.explore())
            end
            repl.commands.array = function()
                print(helpers.array())
            end
            
            print("=== PHP Debug REPL Ready ===")
            print("Available commands:")
            print("  :vars    - Show current scope variables")
            print("  :explore - Show object exploration helpers")
            print("  :array   - Show array/collection helpers")
            print("")
            print("Tip: Use PHP expressions directly in the REPL")
            print("Example: $my_var, get_class($object), var_dump($array)")
        end, 100)
    end
end

-- Initialize enhanced REPL when DAP is loaded
setup_php_repl()

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

-- Add a help command for debugging
vim.api.nvim_create_user_command('DapHelp', function()
    print('=== PHP Xdebug Debugging Help ===')
    print('')
    print('Keybindings:')
    print('  <F5>          - Continue')
    print('  <F10>         - Step over')
    print('  <F11>         - Step into')
    print('  <F12>         - Step out')
    print('  <leader>b     - Toggle breakpoint')
    print('  <leader>B     - Set conditional breakpoint')
    print('  <leader>lp    - Set log point')
    print('  <leader>dr    - Open REPL')
    print('  <leader>dl    - Run last configuration')
    print('  <leader>dp    - Start listening for Xdebug')
    print('  <leader>dt    - Toggle DAP UI')
    print('')
    print('Variable Inspection:')
    print('  <leader>dv    - Open scopes in float window')
    print('  <leader>dw    - Open watches in float window')
    print('  <leader>dW    - Watch variable under cursor')
    print('')
    print('Commands:')
    print('  :DapPaths     - Show current path mappings')
    print('  :DapDebugPath - Debug path mapping issues')
    print('  :DapRefresh   - Refresh buffer for debugging')
    print('')
    print('IMPORTANT: Variables in REPL vs Scopes:')
    print('  - REPL console shows "null" for variables because it runs in a different context')
    print('  - Use <leader>dv to open scopes pane to see actual variable values')
    print('  - Use <leader>dw to manage watches for specific variables')
    print('  - Use <leader>dW to quickly add a watch for the variable under cursor')
end, {})
