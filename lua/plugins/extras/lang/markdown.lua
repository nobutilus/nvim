return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "markdown", "markdown.mdx" },
      root = { "README.md", "*.md", "docs/", "*.mdx" },
    })
  end,

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "markdown", "markdown_inline" } },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>mp",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },

  -- Formatter
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

  -- Linter
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint" },
      },
    },
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "marksman", "markdownlint", "prettier" } },
  },
}

