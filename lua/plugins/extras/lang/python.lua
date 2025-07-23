return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "python",
      root = { "pyproject.toml", "setup.py", "requirements.txt", "Pipfile", "tox.ini" },
    })
  end,

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "python", "rst", "toml" } },
  },

  -- LSP
  {
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
  },

  -- Conform
  {
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
  },

  -- DAP
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mfussenegger/nvim-dap-python",
      keys = {
        {
          "<leader>dPt",
          function()
            require("dap-python").test_method()
          end,
          desc = "Debug Method",
          ft = "python",
        },
        {
          "<leader>dPc",
          function()
            require("dap-python").test_class()
          end,
          desc = "Debug Class",
          ft = "python",
        },
      },
      config = function()
        local venv_path = vim.fn.findfile("pyvenv.cfg", vim.fn.getcwd() .. ";")
        local python_path = nil

        if venv_path ~= "" then
          local venv_dir = vim.fn.fnamemodify(venv_path, ":h")
          if vim.fn.has("win32") == 1 then
            python_path = venv_dir .. "/Scripts/python.exe"
          else
            python_path = venv_dir .. "/bin/python"
          end
        end

        if not python_path or vim.fn.filereadable(python_path) == 0 then
          if vim.fn.has("win32") == 1 then
            python_path = LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe")
          else
            python_path = LazyVim.get_pkg_path("debugpy", "/venv/bin/python")
          end
        end

        require("dap-python").setup(python_path)
      end,
    },
  },

  -- Testing
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {},
      },
    },
  },

  -- CMP
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      opts.auto_brackets = opts.auto_brackets or {}
      table.insert(opts.auto_brackets, "python")
    end,
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "basedpyright", "ruff", "ruff-lsp", "debugpy" } },
  },
}

