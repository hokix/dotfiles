local opts = {
	shiftwidth = 4,
	tabstop = 4,
	softtabstop = 4,
	expandtab = true,
	wrap = true,
	-- linebreak = true,
	splitbelow = true,
	splitright = false,
	termguicolors = true,
	number = true,
	relativenumber = true,
	-- mouse = "",
	mouse = "a",
	backupext = "-" .. vim.fn.strftime("%Y%m%d%H%M"),
	backupdir = vim.fs.normalize("~/.cache/nvim/tmp/"),
	backup = true,
	undodir = vim.fs.normalize("~/.cache/nvim/undo/"),
	undofile = true,
	-- cursorline = true,
	spelllang = "en_us,cjk",
	spell = true,
	fileencodings = "utf8,gbk",
	-- scrolloff = 999,
	virtualedit = "block",
	inccommand = "split",
	ignorecase = true,
}

-- Set options from table
for opt, val in pairs(opts) do
	vim.o[opt] = val
end

-- Set other options
local colorscheme = require("helpers.colorscheme")
vim.cmd.colorscheme(colorscheme)

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec2('silent! normal! g`"zv', { output = false })
	end,
})

vim.cmd([[
	cnoreabbrev rg AsyncRun! rg --vimgrep --smart-case
	packadd cfilter
]])


if vim.fn.has("gui_running") then
	vim.opt.guifont = "Roboto Nerd Font Mono"
end

vim.cmd([[
function! BuildCmakeProj(cmd)
    if getfsize("CMakeLists.txt") <= 0
        echo "CMakeListsx.txt not found in working directory!"
        return
    endif
    if a:cmd == "build"
        if ! isdirectory("build")
            call mkdir("build")
        endif
        cd build
        exec ":AsyncRun cmake .. -DBUILD_STD=c++11 -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON && make -j 8"
        cd -
    elseif a:cmd == "install"
        if ! isdirectory("build")
            call mkdir("build")
        endif
        cd build
        exec ":AsyncRun cmake .. -DBUILD_STD=c++11 -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && make -j 8 && make install"
        cd -
    elseif a:cmd == "clean"
        cd build
        :AsyncRun make clean
        cd -
    elseif a:cmd == "rebuild"
        call system("rm -rf build")
        call mkdir("build")
        cd build
        exec ":AsyncRun cmake .. -DBUILD_STD=c++11 -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && make -j 8"
        cd -
    elseif a:cmd == "export_compile_commands"
        if ! isdirectory("build")
            call mkdir("build")
        endif
        cd build
        exec ":AsyncRun cmake .. -DBUILD_STD=c++11 -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON"
        cd -
        call system("ln -s build/compile_commands.json .")
    endif
endfu


]])
