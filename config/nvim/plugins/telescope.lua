require('telescope').setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			".git",
			"vendor/bundle",
			"*.pyc",
			"__pycache__",
			".DS_Store",
			"*.swp",
			"*.swo",
			"*~",
		},
		git_status = false, -- Don't show git status in find_files
	},
	pickers = {
		find_files = {
			hidden = true,
			no_ignore = true,
			git_status = false,
		},
		live_grep = {
			additional_args = function()
				return {"--hidden", "--no-ignore"}
			end,
		},
	},
	extensions = {
    	fzf = {
      	fuzzy = true,                    -- false will only do exact matching
      	override_generic_sorter = true,  -- override the generic sorter
      	override_file_sorter = true,     -- override the file sorter
      	case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    	}
  	}
})

require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
