-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Auto-source .nvim.lua from project root (replaces exrc without trust prompt)
-- NOTE: autocmds.lua is loaded on VeryLazy (after VimEnter), so we call immediately
-- here to handle the initial open, and use DirChanged for subsequent cd events.
-- local function source_nvim_lua()
--   local nvim_lua = vim.fn.getcwd() .. "/.nvim.lua"
--   if vim.fn.filereadable(nvim_lua) == 1 then
--     dofile(nvim_lua)
--   end
-- end
--
-- source_nvim_lua()
--
-- vim.api.nvim_create_autocmd("DirChanged", {
--   callback = source_nvim_lua,
-- })

-- Disable autoformat for file types
vim.api.nvim_create_autocmd({ "FileType" }, {
  -- cpp / h / c are auto formatted by lsp-format-modifications
  pattern = { "proto", "cpp", "h", "c", "php", "java", "toml" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- autonmatic rename tmux after launching neovim
-- https://github.com/ofirgall/tmux-window-name
vim.api.nvim_create_autocmd({ "VimEnter", "VimLeave" }, {
  callback = function()
    if vim.env.TMUX_PLUGIN_MANAGER_PATH then
      vim.uv.spawn(vim.env.TMUX_PLUGIN_MANAGER_PATH .. "/tmux-window-name/scripts/rename_session_windows.py", {})
    end
  end,
})
