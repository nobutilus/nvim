return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle reveal=true<CR>", desc = "Explorer (neo-tree)" },
  },
  opts = {
    filesystem = {
      filtered_items = { visible = true },
    },
    window = {
      position = "right",
    },
  },
}
