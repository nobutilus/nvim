return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      basedpyright = {},
      ruff = {},
    },
    setup = {
      ruff = function()
        LazyVim.lsp.on_attach(function(client, _)
          client.server_capabilities.hoverProvider = false
        end, "ruff")
      end,
    },
  },
}