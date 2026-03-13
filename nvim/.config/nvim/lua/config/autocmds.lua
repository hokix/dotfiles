-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

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
