return {
  "nvim-neotest/neotest",
  optional = true,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-python",
  },
  opts = {
    adapters = {
      ["neotest-python"] = {
        dap = {
          justMyCode = false,
        },
        python = function(root)
          -- 仮想環境の検出
          local venv_path = vim.fn.findfile("pyvenv.cfg", root .. ";")
          if venv_path ~= "" then
            local venv_dir = vim.fn.fnamemodify(venv_path, ":h")
            if vim.fn.has("win32") == 1 then
              return venv_dir .. "/Scripts/python.exe"
            else
              return venv_dir .. "/bin/python"
            end
          end
          -- デフォルトのPythonを使用
          return "python"
        end,
      },
    },
  },
}
