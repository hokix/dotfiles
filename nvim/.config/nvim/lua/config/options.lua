-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","

local opts = {
  shiftwidth = 4,
  tabstop = 4,
  softtabstop = 4,
  expandtab = true,
  wrap = true,
  splitbelow = true,
  splitright = false,
  backupext = "-" .. vim.fn.strftime("%Y%m%d%H%M"),
  backupdir = vim.fs.normalize("~/.cache/nvim/tmp/"),
  backup = true,
  undodir = vim.fs.normalize("~/.cache/nvim/undo/"),
  undofile = true,
  fileencodings = "utf8,gbk",
  virtualedit = "block",
  inccommand = "split",
  pumblend = 0, -- override lazyvim menu background for transparency
  winblend = 0, -- override lazyvim menu background for transparency
  clipboard = "unnamedplus",
}

-- Set options from table
for opt, val in pairs(opts) do
  vim.o[opt] = val
end

if vim.fn.has("gui_running") then
  vim.opt.guifont = "Roboto Nerd Font Mono"
end

vim.api.nvim_create_user_command("CopyRelPath", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
