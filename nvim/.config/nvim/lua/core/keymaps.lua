local map = require("helpers.keys").map

-- Blazingly fast way out of insert mode
map("i", "jk", "<esc>")

-- Quick access to some common actions
map("n", "<leader>fw", "<cmd>w<cr>", "[F]ile [W]rite")
map("n", "<leader>fa", "<cmd>wa<cr>", "[F]ile Write [A]ll")
map("n", "<leader>qq", "<cmd>q<cr>", "[Q]uit")
map("n", "<leader>qa", "<cmd>qa!<cr>", "[Q]uit [A]ll")
map("n", "<leader>dw", "<cmd>close<cr>", "[D]elete [W]indow")

-- Diagnostic keymaps
map('n', 'gx', vim.diagnostic.open_float, "Show diagnostics under cursor")

-- Easier access to beginning and end of lines
map("n", "<M-h>", "^", "Go to beginning of line")
map("n", "<M-l>", "$", "Go to end of line")

-- Better window navigation
-- map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
-- map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
-- map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
-- map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

-- Move with shift-arrows
map("n", "<S-Left>", "<C-w><S-h>", "Move window to the left")
map("n", "<S-Down>", "<C-w><S-j>", "Move window down")
map("n", "<S-Up>", "<C-w><S-k>", "Move window up")
map("n", "<S-Right>", "<C-w><S-l>", "Move window to the right")

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize +2<CR>")
map("n", "<C-Right>", ":vertical resize -2<CR>")

-- Deleting buffers
local buffers = require("helpers.buffers")
map("n", "<leader>do", buffers.delete_others, "[D]elete [O]ther buffers")
map("n", "<leader>da", buffers.delete_all, "[D]elete [A]ll buffers")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Clear after search
map("n", "<leader>ur", "<cmd>nohl<cr>", "Clear highlights")

-- quickfix window
map("n", "<leader>qo", "<cmd>copen<cr>", "[Q]uickfix [o]pen")
map("n", "<leader>qc", "<cmd>cclose<cr>", "[Q]uickfix [c]lose")
map("n", "<leader>qn", "<cmd>cnext<cr>", "[Q]uickfix [n]ext")
map("n", "<leader>qp", "<cmd>cprevious<cr>", "[Q]uickfix [p]revious")

-- location window
map("n", "<leader>lo", "<cmd>lopen<cr>", "[L]ocation [o]pen")
map("n", "<leader>lc", "<cmd>lclose<cr>", "[L]ocation [c]lose")
map("n", "<leader>ln", "<cmd>lnext<cr>", "[L]ocation [n]ext")
map("n", "<leader>lp", "<cmd>lprevious<cr>", "[L]ocation [p]revious")

-- buffer
map("n", "<leader>be", "<cmd>enew<cr>", "[B]uffer [o]pen")
map("n", "<leader>bc", "<cmd>bdelete<cr>", "[B]uffer [c]lose")
map("n", "<leader>bn", "<cmd>bnext<cr>", "[B]uffer [n]ext")
map("n", "<leader>bp", "<cmd>bprevious<cr>", "[B]uffer [p]revious")

-- tab
map("n", "<leader>te", "<cmd>tabnew<cr>", "[T]ab [o]pen")
map("n", "<leader>tc", "<cmd>tabclose<cr>", "[T]ab [c]lose")
map("n", "<leader>tn", "<cmd>tabnext<cr>", "[T]ab [n]ext")
map("n", "<leader>tp", "<cmd>tabprevious<cr>", "[T]ab [p]revious")

-- copy and paste
map({"n", "v"}, "<leader>y", "\"+y", "[Y]ank")
map({"n", "v"}, "<leader>p", "\"+p", "[P]aste")

-- cmake compile
map("n", "<leader>cb", "<cmd>call BuildCmakeProj(\"build\")<cr>", "[c]make [b]uild")
map("n", "<leader>ci", "<cmd>call BuildCmakeProj(\"install\")<cr>", "[c]make [i]nstall")
map("n", "<leader>cc", "<cmd>call BuildCmakeProj(\"clean\")<cr>", "[c]make [c]lean")
map("n", "<leader>crb", "<cmd>call BuildCmakeProj(\"rebuild\")<cr>", "[c]make [r]e[b]uild")
map("n", "<leader>ce", "<cmd>call BuildCmakeProj(\"export_compile_commands\")<cr>", "[c]make [e]xport compile commands")
