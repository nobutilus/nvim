return {
  "mfussenegger/nvim-dap",
  optional = true,
  dependencies = {
    {
      "leoluz/nvim-dap-go",
      config = function()
        require("dap-go").setup()
      end,
    },
    {
      "mason-org/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "delve")
      end,
    },
  },
}
