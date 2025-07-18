local which_key = require("which-key")

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
    win = {
        border = "rounded",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
    },
    layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
    },
    mappings = {
        ["<leader>"] = {
            f = {
                name = "Files",
                f = "Find files",
                b = "Find buffers",
                h = "Help tags",
                t = "Find todos",
            },
            l = {
                name = "LSP",
                g = "Live grep",
            },
            d = {
                name = "Debug",
                p = "Start PHP debug",
                t = "Toggle debug UI",
                r = "Open debug REPL",
                l = "Run last debug",
            },
            b = "Toggle breakpoint",
            B = "Set conditional breakpoint",
            s = {
                name = "Splits",
                v = "Split window vertically",
                h = "Split window horizontally",
                e = "Make splits equal size",
                x = "Close current split",
            },
            t = {
                name = "Tabs",
                o = "Open new tab",
                x = "Close current tab",
                n = "Go to next tab",
                p = "Go to previous tab",
                f = "Open current buffer in new tab",
            },
            n = {
                name = "Navigation",
                h = "Clear search highlights",
            },
        },
        ["<F5>"] = "Continue debug",
        ["<F10>"] = "Step over",
        ["<F11>"] = "Step into",
        ["<F12>"] = "Step out",
    },
})

-- Add keybinding to show which-key popup
vim.keymap.set("n", "<leader><leader>", "<cmd>WhichKey<CR>", { desc = "Show which-key" })