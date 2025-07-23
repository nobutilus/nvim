-- Markdown plugins loader
return {
  -- Load markdown-preview plugin
  require("plugins.lang.markdown.markdown-preview"),
  -- Load LSP config
  require("plugins.lang.markdown.lspconfig"),
  -- Load other markdown plugins
  require("plugins.lang.markdown.mason"),
  require("plugins.lang.markdown.conform"),
  require("plugins.lang.markdown.nvim-lint"),
  require("plugins.lang.markdown.none-ls"),
}

