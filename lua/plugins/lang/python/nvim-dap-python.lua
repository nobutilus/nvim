return {
  "mfussenegger/nvim-dap-python",
  -- stylua: ignore
  keys = {
    { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
    { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
  },
  config = function()
    -- 仮想環境の検出
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
    
    -- デフォルトのdebugpyパスを使用
    if not python_path or vim.fn.filereadable(python_path) == 0 then
      if vim.fn.has("win32") == 1 then
        python_path = LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe")
      else
        python_path = LazyVim.get_pkg_path("debugpy", "/venv/bin/python")
      end
    end
    
    require("dap-python").setup(python_path)
  end,
}
