return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        markdown = { "prettier", "markdownlint", "markdown-toc" },
        ["markdown.mdx"] = { "prettier", "markdownlint", "markdown-toc" },
      },
    },
  },
}