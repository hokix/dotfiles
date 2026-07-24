-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function copy_path(path, cmd)
  if cmd.range > 0 then
    if cmd.line1 == cmd.line2 then
      path = path .. " :L" .. cmd.line1
    else
      path = path .. " :L" .. cmd.line1 .. "-L" .. cmd.line2
    end
  end
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end

vim.api.nvim_create_user_command("CopyRelPath", function(cmd)
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    return
  end
  local cwd = vim.fn.getcwd(0)
  local ok, rel = pcall(vim.fs.relpath, cwd, name)
  copy_path((ok and rel and rel ~= "" and rel ~= ".") and rel or name, cmd)
end, { range = true })

vim.api.nvim_create_user_command("CopyAbsPath", function(cmd)
  local name = vim.api.nvim_buf_get_name(0)
  copy_path(name ~= "" and name or vim.fn.getcwd(0), cmd)
end, { range = true })

vim.api.nvim_create_user_command("MRDiffLink", function(cmd)
  require("gitlab_mr").run(cmd)
end, {
  bang = true,
  desc = "Copy a link to the current line in a GitLab MR diff; use ! to open it",
  nargs = "?",
  range = true,
})
