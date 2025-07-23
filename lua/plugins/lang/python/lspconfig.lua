return {
  "neovim/nvim-lspconfig",
  opts = {
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
    },
    setup = {
      ruff = function()
        LazyVim.lsp.on_attach(function(client, _)
          -- Disable hover in favor of basedpyright
          client.server_capabilities.hoverProvider = false
        end, "ruff")
      end,
    },
  },
}