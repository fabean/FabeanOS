require("neowiki").setup({
  -- Configure wiki directories - you can customize these paths
  wiki_dirs = {
    { name = "Personal", path = "~/wiki" },
    -- { name = "Work", path = "~/work/wiki" }, -- Uncomment and customize if needed
  },

  -- The filename for a wiki's index page
  index_file = "index.md",

  -- Automatically discover and register nested wiki roots
  discover_nested_roots = false,

  -- Keymaps configuration
  keymaps = {
    -- Link actions
    action_link = "<CR>",           -- Follow/create link
    action_link_vsplit = "<S-CR>",  -- Follow/create link in vertical split
    action_link_split = "<C-CR>",   -- Follow/create link in horizontal split

    -- Navigation
    next_link = "<Tab>",            -- Jump to next link
    prev_link = "<S-Tab>",          -- Jump to previous link
    navigate_back = "[[",           -- Navigate back in history
    navigate_forward = "]]",        -- Navigate forward in history
    jump_to_index = "<BS>",         -- Jump to index page

    -- Page management
    rename_page = "<leader>wr",     -- Rename page and update backlinks
    delete_page = "<leader>wd",     -- Delete page and update backlinks
    insert_link = "<leader>wi",     -- Insert link to another wiki page
    cleanup_links = "<leader>wc",   -- Remove broken links

    -- Task management
    toggle_task = "<leader>wt",     -- Toggle task status

    -- Floating window
    close_float = "q",              -- Close floating wiki window
  },

  -- GTD (Getting Things Done) configuration
  gtd = {
    show_gtd_progress = true,       -- Show progress percentage
    gtd_progress_hl_group = "Comment",
  },

  -- Floating window configuration
  floating_wiki = {
    open = {
      relative = "editor",
      width = 0.9,
      height = 0.9,
      border = "rounded",
    },
    style = {},
  },
})

-- Set up keymaps for opening wikis
vim.keymap.set("n", "<leader>ww", "<cmd>lua require('neowiki').open_wiki()<cr>", { desc = "Open Wiki" })
vim.keymap.set("n", "<leader>wW", "<cmd>lua require('neowiki').open_wiki_floating()<cr>", { desc = "Open Wiki in Floating Window" })
vim.keymap.set("n", "<leader>wT", "<cmd>lua require('neowiki').open_wiki_new_tab()<cr>", { desc = "Open Wiki in New Tab" })
