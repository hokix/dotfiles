-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- cmake compile
vim.keymap.set("n", "<leader>cb", '<cmd>call BuildCmakeProj("build")<cr>', { desc = "[c]make [b]uild" })
vim.keymap.set("n", "<leader>ci", '<cmd>call BuildCmakeProj("install")<cr>', { desc = "[c]make [i]nstall" })
vim.keymap.set("n", "<leader>cn", '<cmd>call BuildCmakeProj("clean")<cr>', { desc = "[c]make clea[n]" })
vim.keymap.set("n", "<leader>crb", '<cmd>call BuildCmakeProj("rebuild")<cr>', { desc = "[c]make [re]build" })
vim.keymap.set(
  "n",
  "<leader>ce",
  '<cmd>call BuildCmakeProj("export_compile_commands")<cr>',
  { desc = "[c]make [e]xport compile commands" }
)

-- copy and paste
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "[P]aste" })
