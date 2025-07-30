local which_key = require("which-key")

-- Register keymaps with which-key
which_key.register({
  ["<leader>"] = {
    n = { name = "Navigation" },
    s = { name = "Split" },
    t = { name = "Tab" },
    r = { name = "Rename" },
    c = { name = "Code" },
    d = { name = "Diagnostic" },
  },
  ["["] = { name = "Previous" },
  ["]"] = { name = "Next" },
})

-- Setup which-key
which_key.setup({
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
  },
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "left",
  },
})
