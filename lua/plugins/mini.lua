return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
      -- mini モジュールを設定
      require("mini.basics").setup()
      require("mini.pairs").setup()
      require("mini.comment").setup()
      require("mini.trailspace").setup()
      require("mini.diff").setup()

      -- mini.surround を vim-surround 互換のキーバインドで設定
      require("mini.surround").setup({
        mappings = {
          add = "ys", -- Add surrounding in Normal and Visual modes
          delete = "ds", -- Delete surrounding
          find = "gzf", -- Find surrounding (to the right)
          find_left = "gzF", -- Find surrounding (to the left)
          highlight = "gzh", -- Highlight surrounding
          replace = "cs", -- Replace surrounding
          update_n_lines = "gzn", -- Update `n_lines`
        },
      })
    end,
  },
}
