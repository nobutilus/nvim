-- Terraform plugins loader
return {
  require("plugins.lang.terraform.lspconfig"),
  require("plugins.lang.terraform.mason"),
  require("plugins.lang.terraform.telescope-terraform-doc"),
  require("plugins.lang.terraform.telescope-terraform"),
  require("plugins.lang.terraform.treesitter"),
}