return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "terraform", "hcl", "terraform-vars" },
      root = { "*.tf", "*.tfvars", ".terraform", "terraform.tfstate" },
    })
  end,

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "terraform", "hcl" } },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terraformls = {},
      },
    },
  },

  -- Mason
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "terraform-ls", "tflint" } },
  },

  -- Telescope extensions
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    dependencies = {
      "ANGkeith/telescope-terraform-doc.nvim",
      "cappyzawa/telescope-terraform.nvim",
    },
    config = function()
      require("telescope").load_extension("terraform_doc")
      require("telescope").load_extension("terraform")
    end,
  },
}

