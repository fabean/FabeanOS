local nvimtree = require("nvim-tree")

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup({
  view = {
    width = 35,
    relativenumber = true,
  },
  -- change folder arrow icons
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "", -- arrow when folder is closed
          arrow_open = "", -- arrow when folder is open
        },
      },
    },
  },
  -- disable window_picker for
  -- explorer to work well with
  -- window splits
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
  filters = {
    custom = { ".DS_Store" },
  },
  git = {
    ignore = false,
  },
})

-- set keymaps
local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>fe", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer

-- File tree keybindings (when nvim-tree is focused)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    local opts = { buffer = 0, silent = true, noremap = true }
    
    -- File operations
    vim.keymap.set("n", "a", "<cmd>NvimTreeCreate<CR>", opts) -- Create file/directory
    vim.keymap.set("n", "d", "<cmd>NvimTreeRemove<CR>", opts) -- Delete file/directory
    vim.keymap.set("n", "r", "<cmd>NvimTreeRename<CR>", opts) -- Rename file/directory
    vim.keymap.set("n", "x", "<cmd>NvimTreeCut<CR>", opts) -- Cut file/directory
    vim.keymap.set("n", "c", "<cmd>NvimTreeCopy<CR>", opts) -- Copy file/directory
    vim.keymap.set("n", "p", "<cmd>NvimTreePaste<CR>", opts) -- Paste file/directory
    
    -- Navigation
    vim.keymap.set("n", "o", "<cmd>NvimTreeOpen<CR>", opts) -- Open file/directory
    vim.keymap.set("n", "<CR>", "<cmd>NvimTreeOpen<CR>", opts) -- Open file/directory
    vim.keymap.set("n", "<2-LeftMouse>", "<cmd>NvimTreeOpen<CR>", opts) -- Open file/directory
    
    -- Tree operations
    vim.keymap.set("n", "s", "<cmd>NvimTreeToggle<CR>", opts) -- Toggle node
    vim.keymap.set("n", "S", "<cmd>NvimTreeToggleRecursive<CR>", opts) -- Toggle node recursively
    vim.keymap.set("n", "R", "<cmd>NvimTreeRefresh<CR>", opts) -- Refresh tree
    
    -- Help
    vim.keymap.set("n", "?", "<cmd>NvimTreeToggleHelp<CR>", opts) -- Toggle help
  end,
})
