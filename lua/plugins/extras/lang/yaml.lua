return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
      root = { "*.yaml", "*.yml", ".gitlab-ci.yml", "docker-compose.yml" },
    })
  end,

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "yaml" } },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend(
              "force",
              new_config.settings.yaml.schemas or {},
              require("schemastore").yaml.schemas()
            )
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              keyOrdering = false,
              format = {
                enable = true,
              },
              validate = true,
              schemaStore = {
                enable = false,
                url = "",
              },
            },
          },
        },
      },
    },
  },

  -- Schema store
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false,
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "yaml-language-server" } },
  },
}

