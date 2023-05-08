local ok, copilot = pcall(require, "copilot")
if not ok then
  return
end

-- require("copilot").setup(options)
copilot.setup {
  suggestion = {
    keymap = {
      accept = "<c-l>",
      next = "<c-j>",
      prev = "<c-k>",
      dismiss = "<c-h>",
    },
  },
}

local opts = { noremap = true, silent = false }
vim.api.nvim_set_keymap("n", "<c-t>", "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<CR>", opts)

-- explain vim.opt.backspace
-- [[
--
-- ]]

