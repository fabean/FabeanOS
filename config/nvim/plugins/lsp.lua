local lspconfig = require("lspconfig")

-- Python
require'lspconfig'.pyright.setup{}

-- PHP
require'lspconfig'.intelephense.setup{}

-- Nix
require'lspconfig'.nil_ls.setup{}

-- Markdown
require'lspconfig'.marksman.setup{}

-- Rust
require'lspconfig'.rust_analyzer.setup{}

-- YAML
require'lspconfig'.yamlls.setup{}

-- Bash
require'lspconfig'.bashls.setup{}

-- CSS and SCSS
require'lspconfig'.cssls.setup{}

-- JavaScript/TypeScript
require'lspconfig'.ts_ls.setup{}

-- Lua
require'lspconfig'.lua_ls.setup{}
