return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      python = { "ruff_organize_imports", "ruff_format" },
    },
    formatters = {
      ruff_organize_imports = {
        args = {
          "check",
          "--select",
          "I",
          "--fix",
          "--exit-zero",
          "--stdin-filename",
          "$FILENAME",
          "-",
        },
      },
    },
  },
}