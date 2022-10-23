local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup {}

vim.keymap.set("n", "<space>s", function()
  return require("nvim-tree").toggle(false, true)
  end, { silent = true, desc = "toggle nvim-tree" })
