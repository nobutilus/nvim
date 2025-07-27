local M = {}

-- Recommended function for LazyVim extras
M.recommended = function()
  return LazyVim.extras.wants({
    ft = { "go" },
    root = { "go.mod", "go.sum", "go.work", ".git" },
  })
end

-- Load all Go modules
local modules = {
  require("plugins.extras.lang.go.conform"),
  require("plugins.extras.lang.go.mini-icons"),
  require("plugins.extras.lang.go.none-ls"),
  require("plugins.extras.lang.go.lsp"),
  require("plugins.extras.lang.go.treesitter"),
  require("plugins.extras.lang.go.neotest"),
  require("plugins.extras.lang.go.mason"),
  require("plugins.extras.lang.go.nvim-dap"),
}

-- Combine recommended function with modules
return vim.list_extend({ recommended = M.recommended }, modules)
