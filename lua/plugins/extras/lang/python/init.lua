local M = {}

-- Recommended function for LazyVim extras
M.recommended = function()
  return LazyVim.extras.wants({
    ft = "python",
    root = { "pyproject.toml", "setup.py", "requirements.txt", "Pipfile", "tox.ini" },
  })
end

-- Load all Python modules
local modules = {
  require("plugins.extras.lang.python.treesitter"),
  require("plugins.extras.lang.python.lsp"),
  require("plugins.extras.lang.python.dap"),
  require("plugins.extras.lang.python.format"),
  require("plugins.extras.lang.python.test"),
  require("plugins.extras.lang.python.cmp"),
  require("plugins.extras.lang.python.mason"),
}

-- Combine recommended function with modules
return vim.list_extend({ recommended = M.recommended }, modules)