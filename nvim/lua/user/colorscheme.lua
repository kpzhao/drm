--local colorscheme = "tokyonight"
--local colorscheme = "gruvbox"
--local colorscheme = "nord"

--local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
--if not status_ok then
--  return
--end
--
local status, bufferline = pcall(require, "catppuccin")
if not status then
	vim.notify("没有找到 catppuccin")
	return
end

require("catppuccin").setup {
  flavour = "macchiato" -- mocha, macchiato, frappe, latte
}
vim.api.nvim_command "colorscheme catppuccin"
