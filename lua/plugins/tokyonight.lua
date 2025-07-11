return {
  "folke/tokyonight.nvim",
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(hl, c)
      hl.LineNr = { fg = c.purple, bold = true }
      hl.CursorLineNr = { fg = c.orange, bold = true }
    end,
  },
}
