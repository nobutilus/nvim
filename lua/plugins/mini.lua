return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      -- mini モジュールを設定
      require("mini.basics").setup()
      require("mini.pairs").setup()
      require("mini.comment").setup()
      require("mini.trailspace").setup()
      require("mini.surround").setup()
      require("mini.diff").setup()

      local wk = require("which-key")
      wk.add({
        ["<leader>"] = {
          c = { "Toggle Comment (mini.comment)" },
          s = { "Surround (mini.surround)" },
          t = { "Trim trailing spaces (mini.trailspace)" },
        },
      })
    end,
  },
}
