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
}

-- Set options from table
for opt, val in pairs(opts) do
  vim.o[opt] = val
end

vim.cmd([[
	cnoreabbrev rg AsyncRun! rg --vimgrep --smart-case
	packadd cfilter
]])

if vim.fn.has("gui_running") then
  vim.opt.guifont = "Roboto Nerd Font Mono"
end

-- vim.cmd([[
-- function! BuildCmakeProj(cmd)
--     if getfsize("CMakeLists.txt") <= 0
--         echo "CMakeListsx.txt not found in working directory!"
--         return
--     endif
--     if a:cmd == "build"
--         if ! isdirectory("build")
--             call mkdir("build")
--         endif
--         cd build
--         exec ":AsyncRun cmake .. -DBUILD_STD=c++11 -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON && make -j 8"
--         cd -
--     elseif a:cmd == "install"
--         if ! isdirectory("build")
--             call mkdir("build")
--         endif
--         cd build
--         exec ":AsyncRun cmake .. -DBUILD_STD=c++11 -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && make -j 8 && make install"
--         cd -
--     elseif a:cmd == "clean"
--         cd build
--         :AsyncRun make clean
--         cd -
--     elseif a:cmd == "rebuild"
--         call system("rm -rf build")
--         call mkdir("build")
--         cd build
--         exec ":AsyncRun cmake .. -DBUILD_STD=c++11 -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && make -j 8"
--         cd -
--     elseif a:cmd == "export_compile_commands"
--         if ! isdirectory("build")
--             call mkdir("build")
--         endif
--         cd build
--         exec ":AsyncRun cmake .. -DBUILD_STD=c++11 -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON"
--         cd -
--         call system("ln -s build/compile_commands.json .")
--     endif
-- endfu
-- ]])

vim.api.nvim_create_user_command("CopyRelPath", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
