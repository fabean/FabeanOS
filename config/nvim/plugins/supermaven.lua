require("supermaven-nvim").setup({
  keymaps = {
    accept_suggestion = "<Tab>",
    clear_suggestion = "<C-]>",
    accept_word = "<C-l>", -- Changed from <C-j> to avoid conflict with cmp
  },
  ignore_filetypes = {}, -- No filetypes to ignore by default
  color = {
    suggestion_color = "#6CC644", -- Supermaven green color
    cterm = 244,
  },
  log_level = "info",
  disable_inline_completion = false, -- Keep inline completion enabled
  disable_keymaps = false, -- Keep built-in keymaps
  condition = function()
    return false -- No special conditions to stop Supermaven
  end
}) 