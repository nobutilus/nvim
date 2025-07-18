return {
  "neovim/nvim-lspconfig",
  opts = {
    -- make sure mason installs the server
    servers = {
      basedpyright = {
        on_new_config = function(config, new_root_dir)
          -- 仮想環境の検出
          local venv_path = vim.fn.findfile("pyvenv.cfg", new_root_dir .. ";")
          if venv_path ~= "" then
            local venv_dir = vim.fn.fnamemodify(venv_path, ":h")
            config.settings.python = config.settings.python or {}
            config.settings.python.venvPath = venv_dir
          end

          -- pyproject.tomlの検出
          local pyproject_path = vim.fn.findfile("pyproject.toml", new_root_dir .. ";")
          if pyproject_path ~= "" then
            config.settings.basedpyright = config.settings.basedpyright or {}
            config.settings.basedpyright.analysis = config.settings.basedpyright.analysis or {}
            config.settings.basedpyright.analysis.extraPaths = { new_root_dir }
          end
        end,
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              autoImportCompletions = true,
            },
          },
        },
      },
      ruff = {
        on_new_config = function(config, new_root_dir)
          -- pyproject.tomlの検出
          local pyproject_path = vim.fn.findfile("pyproject.toml", new_root_dir .. ";")
          if pyproject_path ~= "" then
            config.init_options = config.init_options or {}
            config.init_options.settings = config.init_options.settings or {}
            config.init_options.settings.configuration = pyproject_path
          end
        end,
        cmd_env = { RUFF_TRACE = "messages" },
        init_options = {
          settings = {
            logLevel = "error",
          },
        },
        keys = {
          {
            "<leader>co",
            LazyVim.lsp.action["source.organizeImports"],
            desc = "Organize Imports",
          },
        },
      },
      marksman = {},
      terraformls = {},
      yamlls = {
        -- Have to add this for yamlls to understand that we support line folding
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
        -- lazy-load schemastore when needed
        on_new_config = function(new_config)
          new_config.settings.yaml.schemas =
            vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
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
              -- Must disable built-in schemaStore support to use
              -- schemas from SchemaStore.nvim plugin
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
          },
        },
      },
    },
    setup = {
      ruff = function()
        LazyVim.lsp.on_attach(function(client, _)
          -- Disable hover in favor of basedpyright
          client.server_capabilities.hoverProvider = false
        end, "ruff")
      end,
      yamlls = function()
        -- Neovim < 0.10 does not have dynamic registration for formatting
        if vim.fn.has("nvim-0.10") == 0 then
          LazyVim.lsp.on_attach(function(client, _)
            client.server_capabilities.documentFormattingProvider = true
          end, "yamlls")
        end
      end,
    },
  },
}
