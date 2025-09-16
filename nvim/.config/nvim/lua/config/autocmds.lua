-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable autoformat for file types
vim.api.nvim_create_autocmd({ "FileType" }, {
  -- cpp / h / c are auto formatted by lsp-format-modifications
  pattern = { "proto", "cpp", "h", "c", "php", "java" },
  callback = function()
    vim.b.autoformat = false
  end,
})
