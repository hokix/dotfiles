 if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'vim-scripts/Mark--Karkat'
" 在头文件和源文件直接切换
Plug 'vim-scripts/a.vim'
Plug 'easymotion/vim-easymotion'
Plug 'yggdroot/indentline'
Plug 'godlygeek/tabular'
Plug 'fatih/vim-go'
Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'dhruvasagar/vim-zoom'
Plug 'yssl/QFEnter'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'rust-lang/rust.vim'
Plug 'puremourning/vimspector'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
Plug 'bfrg/vim-cpp-modern'
Plug 'ryanoasis/vim-devicons'
Plug 'Eliot00/git-lens.vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
call plug#end()

"set foldmethod=indent
"set foldlevel=99

let mapleader=","

set hlsearch
set incsearch
set nocompatible    " Use Vim defaults (much better!)
set bs=indent,eol,start     " allow backspacing over everything in insert mode
set showcmd
set mouse=

syntax on
syntime on
filetype on
set autoindent
filetype plugin indent on
let g:pyflakes_use_quickfix = 0
let g:pep8_map='<leader>8'

set encoding=utf-8
let &termencoding=&encoding
set fileencodings=utf8,gbk

set number
augroup toggle_relative_number
autocmd InsertEnter * :setlocal norelativenumber
autocmd InsertLeave * :setlocal relativenumber
"let loaded_matchparen=1

" highlighting the current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline "cursorcolumn
au InsertEnter * set nocursorline nocursorcolumn
au InsertLeave * set cursorline "cursorcolumn
set cursorline "cursorcolumn

set tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType proto setlocal tabstop=2 shiftwidth=2 softtabstop=2

"if bufwinnr(1)
"    map + <C-W>+
"    map - <C-W>-
"    map < <C-W><
"    map > <C-W>>
"endif

autocmd ColorScheme * hi airline_c guibg=NONE ctermbg=NONE
autocmd ColorScheme * hi airline_tabfill guibg=NONE ctermbg=NONE

set t_Co=256
set termguicolors
colo catppuccin_mocha
set background=dark

" restore cursor position
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"map <F12> :AsyncRun ctags -R .<CR>
"map <F12> :AsyncRun -strip ctags -R --c++-kinds=+p --fields=+iaSl --extras=+q --exclude=*.so --exclude=*.so.* --exclude=*.la --exclude=*.a --exclude=*_bin* --exclude=*_lib* --exclude=*.bin* --exclude=*.lib* --exclude=*_include* --exclude=common_inc --languages=c++ .<CR> :!cscope -Rbq <CR> cs add cscope.out <CR>

set ts=4
set expandtab
%retab!

set laststatus=2

" tagbar
map <Leader>tt :TagbarToggle<CR>
imap <Leader>tt <ESC> :TagbarToggle<CR>

" NERDTree
let NERDTreeWinSize = 40
"autocmd VimEnter * if argc() == 1 | NERDTree | wincmd p | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <Leader>nt :NERDTreeToggle<CR>
imap <Leader>nt :NERDTreeToggle<CR>
nmap <Leader>nf :NERDTreeFind<CR>
"let NERDTreeShowHidden=1
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" backup & undo
let bakext=strftime("%y%m%d_%H%M")
let bakext="set backupext=_". bakext
execute bakext
set backup
set backupdir=~/.vim/tmp,.
set undodir=~/.vim/undo,.
set undofile

" a.vim
map <leader>a :AV<CR>

set wildmode=longest,list,full
set wildmenu

" EasyMotion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

set formatoptions+=r

" auto insert head comment
autocmd bufnewfile *.cpp,*.cc,*.c so ~/.vim/templates/cpp_header.txt
autocmd bufnewfile *.cpp,*.cc,*.c exe "1," . 18 . "g#Filename:.*#s##Filename:  " .expand("%")
autocmd bufnewfile *.cpp,*.cc,*.c exe "1," . 18 . "g#Created:.*#s##Created:  " .strftime("%m/%d/%Y %H:%M:%S %p")
autocmd bufnewfile *.cpp,*.cc,*.c exe "1," . 18 . "g#Author:.*#s##Author:  " .g:username ." (" .g:email .")"

autocmd bufnewfile *.hpp,*.h so ~/.vim/templates/h_header.txt
autocmd bufnewfile *.hpp,*.h exe "1," . 18 . "g#Filename:.*#s##Filename:  " .expand("%")
autocmd bufnewfile *.hpp,*.h exe "1," . 18 . "g#Created:.*#s##Created:  " .strftime("%m/%d/%Y %H:%M:%S %p")
autocmd bufnewfile *.hpp,*.h exe "1," . 18 . "g#Author:.*#s##Author:  " .g:username ." (" .g:email .")"
let gatename = "__" .substitute(toupper(expand("%:t")), "\\.", "_", "g") ."__"
autocmd bufnewfile *.hpp,*.h exe "1," . 21 . "g#ifndef.*#s##ifndef " .gatename
autocmd bufnewfile *.hpp,*.h exe "1," . 21 . "g#define.*#s##define " .gatename
autocmd bufnewfile *.hpp,*.h exe "1," . 21 . "g#endif.*#s##endif // " .gatename

autocmd bufnewfile *.php so ~/.vim/templates/php_header.txt
autocmd bufnewfile *.php exe "1," . 17 . "g#Filename:.*#s##Filename:  " .expand("%")
autocmd bufnewfile *.php exe "1," . 17 . "g#Created:.*#s##Created:  " .strftime("%m/%d/%Y %H:%M:%S %p")
autocmd bufnewfile *.php exe "1," . 17 . "g#Author:.*#s##Author:  " .g:username ." (" .g:email .")"

autocmd Bufwritepre,filewritepre *.cpp,*.cc,*.c,*.hpp,*.h execute "normal ma"
autocmd bufwritepost,filewritepost *.cpp,*.cc,*.c,*.hpp,*.h execute "normal `a"
autocmd BufNewFile * normal G

" 自动关闭代码提示preview窗口
autocmd CompleteDone * pclose

" build
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

nnoremap <Leader>cb :silent call BuildCmakeProj("build")<cr>
nnoremap <Leader>ci :silent call BuildCmakeProj("install")<cr>
nnoremap <Leader>cc :silent call BuildCmakeProj("clean")<cr>
nnoremap <Leader>crb :silent call BuildCmakeProj("rebuild")<cr>
nnoremap <Leader>ce :silent call BuildCmakeProj("export_compile_commands")<cr>

" asyncrun
let g:asyncrun_open=10

" doxygen
"let g:DoxygenToolkit_interCommentTag=' * '
map <leader>dox :Dox<CR>

" indentline
let g:vim_json_conceal=0
let g:markdown_syntax_conceal=0
map <Leader>ilt :IndentLinesToggle<CR>

" tabularize
nmap <Leader>t= :Tabularize /=<CR>
nmap <Leader>t/ :Tabularize /\/\/<CR>
nmap <Leader>t: :Tabularize /:\zs<CR>
nmap <Leader>t, :Tabularize /,\zs<CR>
nmap <Leader>t; :Tabularize /;\zs<CR>

" airline
let g:airline_powerline_fonts=1
let g:airline#extensions#whitespace#enabled=0
" airline-theme
let g:airline_theme='catppuccin_mocha'
"let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#lsp#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamed = ':t'
let g:airline_section_x = '%{zoom#statusline()}'

" tmuxline
" let g:tmuxline_theme = 'zenburn'
let g:tmuxline_powerline_separators = 1
" let g:tmuxline_preset = {
"     \'a'       : '#S',
"     \'win'     : '#I #W',
"     \'cwin'    : '#I #W',
"     \'x'       : '#(cd #{pane_current_path}; git rev-parse --abbrev-ref HEAD)',
"     \'y'       : '%a %Y-%m-%d %H:%M',
"     \'z'       : '#H',
"     \'options' : {'status-justify' : 'left'}}

cnoreabbrev rg AsyncRun! rg --vimgrep --smart-case
cnoreabbrev Rg AsyncRun! rg --vimgrep --smart-case

" quickfix window
nmap <Leader>qo :copen<CR>
nmap <Leader>qc :cclose<CR>
nmap <Leader>qn :cnext<CR>
nmap <Leader>qp :cprevious<CR>

" location window
nmap <Leader>lo :lopen<CR>
nmap <Leader>lc :lclose<CR>
nmap <Leader>ln :lnext<CR>
nmap <Leader>lp :lprevious<CR>

" buffer
nmap <Leader>be :enew<CR>
nmap <Leader>bn :bnext<CR>
nmap <Leader>bp :bprevious<CR>
nmap <Leader>bc :bdelete<CR>

" tab
nmap <Leader>te :tabnew<CR>
nmap <Leader>tn :tabnext<CR>
nmap <Leader>tp :tabprevious<CR>
nmap <Leader>tc :tabclose<CR>

" FZF
" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

"let g:fzf_layout = { 'down': '30%' }
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" " will not override existing commands.
command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:30%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <leader>f :FZF<cr>
nnoremap <leader>bf :Buffers<cr>
map <leader>rg :Rg <C-r><C-w><CR>

" cscope
"if has("cscope")
"  set csprg=/usr/bin/cscope
"  set csto=1
"  set cst
"  set nocsverb
"  " add any database in current directory
"  if filereadable("cscope.out")
"      cs add cscope.out
"  endif
"  set csverb
"endif

" vim-go
let g:go_def_mapping_enabled = 0
let g:go_gopls_enabled = 0
"let g:go_auto_type_info = 1
let g:go_metalinter_command = 'golangci-lint'
"let g:go_metalinter_autosave = 1
"let g:go_metalinter_autosave_enabled = ['vet', 'revive', 'errcheck', 'staticcheck', 'unused', 'varcheck']

" vim-lsp
let g:lsp_settings = {
    \  'intelephense': {'workspace_config': {'intelephense': {'files.associations': ['*.inc', '*.module', '*.php']}}}
\}
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_semantic_enabled = 1
let g:lsp_inlay_hints_enabled = 1
let g:lsp_inlay_hints_mode = {
\  'normal': ['always'],
\}

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-u> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
    nmap <leader>s :LspDocumentSwitchSourceHeader<CR>
    nmap <leader>h :vsp<CR>:LspDocumentSwitchSourceHeader<CR>
    nmap <buffer> gca <plug>(lsp-code-action)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" asyncomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
" inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"

"set colorcolumn=120
"augroup LineLengthCommands
"autocmd!
"  " When a file is read or the text changes in normal or insert mode,
"  " draw a column marking the maximum line length if a line exceeds this length
"  autocmd BufRead,TextChanged,TextChangedI *.h,*.hpp,*.cpp,*.c,*.cc,*.lua,*.go call ShowColumnIfLineTooLong(120)
"augroup END
"
"" Color the column marking the lengthLimit when the longest line in the file
"" exceeds the lengthLimit
"function! ShowColumnIfLineTooLong(lengthLimit)
"  " See https://stackoverflow.com/questions/2075276/longest-line-in-vim#2982789
"  let maxLineLength = max(map(getline(1,'$'), 'strwidth(v:val)'))
"
"  if maxLineLength > a:lengthLimit
"    " highlight ColorColumn ctermbg=red guibg=red
"    " Draw the vertical line at the first letter that exceeds the limit
"    execute "set colorcolumn=" . (a:lengthLimit + 1)
"  else
"    set colorcolumn=""
"  endif
"endfunction

autocmd! FileType qf noremap <buffer> <Leader><Enter> <C-w><Enter><C-w>L

" vimspector
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
nmap <Leader>di <Plug>VimspectorBalloonEval

" oscyank
vnoremap <Leader>o :OSCYankVisual<CR>
let g:oscyank_term = 'default'

" vim-cpp-modern
" Disable function highlighting (affects both C and C++ files)
"let g:cpp_function_highlight = 0

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 1

" terminal
set splitbelow
map <leader>tm :term ++rows=10<CR>
tmap <leader>tm :term ++rows=10<CR>

" confirm before close unsaved file
set confirm

" transparent
" hi Normal guibg=NONE ctermbg=NONE
" hi airline_c  ctermbg=NONE guibg=NONE
" hi airline_tabfill ctermbg=NONE guibg=NONE

" transparent bg
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
" For Vim<8, replace EndOfBuffer by NonText
autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE
" line number bg
autocmd vimenter * hi LineNr guibg=NONE ctermbg=NONE

" move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" auto remove trailing whitespace
" highlight trailing whitespace
match ErrorMsg '\s\+$'
" remove trailing whitespaces automatically
autocmd BufWritePre * :%s/\s\+$//e

" git-lens
" let g:GIT_LENS_ENABLED = 1
nnoremap <Leader>gl :silent call ToggleGitLens()<cr>
