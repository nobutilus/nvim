-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>sC", function()
  require("telescope").extensions.diff.diff_files({ hidden = true })
end, { desc = "Compare 2 files" })
vim.keymap.set("n", "<leader>sc", function()
  require("telescope").extensions.diff.diff_current({ hidden = true })
end, { desc = "Compare file with current" })

-- CopilotChat keymaps
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Copilot Chat
map("n", "<leader>cc", ":CopilotChat<CR>", { desc = "Copilot Chat" })
map("n", "<leader>cfd", ":CopilotChatFixDiagnostic<CR>", { desc = "Fix diagnostic" })
map("n", "<leader>cgm", ":CopilotChatCommit<CR>", { desc = "Generate commit" })
map("n", "<leader>cgs", ":CopilotChatCommitStaged<CR>", { desc = "Generate commit staged" })
map("v", "<leader>ce", ":CopilotChatExplain<CR>", { desc = "Explain code" })
map("v", "<leader>cf", ":CopilotChatFix<CR>", { desc = "Fix code" })
map("v", "<leader>co", ":CopilotChatOptimize<CR>", { desc = "Optimize code" })
map("v", "<leader>cd", ":CopilotChatDocs<CR>", { desc = "Add docs" })
map("v", "<leader>ct", ":CopilotChatTests<CR>", { desc = "Generate tests" })
map("v", "<leader>cc", ":CopilotChat<CR>", { desc = "Copilot Chat with selection" })
