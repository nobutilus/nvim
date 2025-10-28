local M = {}

-- Recommended function for LazyVim extras
M.recommended = function()
  return LazyVim.extras.wants({
    ft = { "markdown", "markdown.mdx" },
    root = { "README.md", "*.md", "docs/", "*.mdx" },
  })
end

-- Load all Markdown modules
local modules = {
  require("plugins.extras.lang.markdown.treesitter"),
  require("plugins.extras.lang.markdown.lsp"),
  require("plugins.extras.lang.markdown.conform"),
  require("plugins.extras.lang.markdown.lint"),
  require("plugins.extras.lang.markdown.mason"),
}

-- Combine recommended function with modules
return vim.list_extend({ recommended = M.recommended }, modules)

