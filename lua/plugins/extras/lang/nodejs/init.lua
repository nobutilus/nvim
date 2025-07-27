local M = {}

-- Recommended function for LazyVim extras
M.recommended = function()
  return LazyVim.extras.wants({
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    root = { "package.json", "tsconfig.json", "jsconfig.json", ".eslintrc.json", ".prettierrc" },
  })
end

-- Load all Node.js modules
local modules = {
  require("plugins.extras.lang.nodejs.treesitter"),
  require("plugins.extras.lang.nodejs.lsp"),
  require("plugins.extras.lang.nodejs.dap"),
  require("plugins.extras.lang.nodejs.mason"),
  require("plugins.extras.lang.nodejs.icons"),
  require("plugins.extras.lang.nodejs.conform"),
  require("plugins.extras.lang.nodejs.none-ls"),
  require("plugins.extras.lang.nodejs.tailwindcss"),
}

-- Combine recommended function with modules
return vim.list_extend({ recommended = M.recommended }, modules)

