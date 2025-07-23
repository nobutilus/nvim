return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
      root = { "package.json", "tsconfig.json", "jsconfig.json", ".eslintrc.json", ".prettierrc" },
    })
  end,

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "javascript", "typescript", "tsx", "json", "json5", "jsonc" } },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
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
      {
        "mason-org/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "js-debug-adapter")
        end,
      },
    },
    opts = function()
      local dap = require("dap")
      if not dap.adapters["pwa-node"] then
        dap.adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              LazyVim.get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
              "${port}",
            },
          },
        }
      end
      if not dap.adapters["node"] then
        dap.adapters["node"] = function(cb, config)
          if config.type == "node" then
            config.type = "pwa-node"
          end
          local nativeAdapter = dap.adapters["pwa-node"]
          if type(nativeAdapter) == "function" then
            nativeAdapter(cb, config)
          else
            cb(nativeAdapter)
          end
        end
      end

      local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

      local vscode = require("dap.ext.vscode")
      vscode.type_to_filetypes["node"] = js_filetypes
      vscode.type_to_filetypes["pwa-node"] = js_filetypes

      for _, language in ipairs(js_filetypes) do
        if not dap.configurations[language] then
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end
    end,
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "typescript-language-server", "vtsls", "eslint-lsp", "prettier" } },
  },

  -- Mini icons
  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".prettierrc.json"] = { glyph = "", hl = "MiniIconsPurple" },
        [".prettierrc.yml"] = { glyph = "", hl = "MiniIconsPurple" },
        [".prettierrc.yaml"] = { glyph = "", hl = "MiniIconsPurple" },
        ["biome.json"] = { glyph = "󰋙", hl = "MiniIconsGrey" },
        ["biome.jsonc"] = { glyph = "󰋙", hl = "MiniIconsGrey" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["eslint.config.mjs"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["eslint.config.cjs"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["eslint.config.ts"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["eslint.config.mts"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["eslint.config.cts"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
      },
    },
  },
}

