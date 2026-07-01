" ==============================================================================
" UI & LINE NUMBERS
" ==============================================================================
syntax on
set number              " Show absolute line number for the current line
set relativenumber      " Show relative numbers for all other lines (fast jumping)
set cursorline          " Highlight the current line to easily find your cursor
set colorcolumn=80      " Visual guide to keep code clean and readable
set nowrap              " Don't wrap long lines (better for reading grid logic)

" ==============================================================================
" TABS & INDENTATION (Standard C++ Style)
" ==============================================================================
set tabstop=4           " A tab counts as 4 spaces
set shiftwidth=4        " Indent by 4 spaces when using >> or <<
set expandtab           " Convert tabs to spaces automatically
set autoindent          " Copy indent from current line when starting a new line
set smartindent         " Automatically inserts extra indent in C-style blocks

" ==============================================================================
" SEARCHING
" ==============================================================================
set incsearch           " Jump to search matches as you type
set hlsearch            " Highlight all search results
set ignorecase          " Ignore case in searches...
set smartcase           " ...unless you type a capital letter
" Pressing Space clears the search highlight
nnoremap <space> :nohlsearch<CR>

" ==============================================================================
" EFFICIENCY & SYSTEM TWEAKS
" ==============================================================================
set clipboard=unnamedplus " Use system clipboard (Crucial for fast copy/pasting to Codeforces/LeetCode)
set noswapfile          " Disables .swp files to keep your directory clean
set updatetime=300      " Faster update time for smoother terminal experience
set scrolloff=8         " Keep 8 lines visible above/below cursor when scrolling

" ==============================================================================
" COMPETITIVE PROGRAMMING SHORTCUTS (C++)
" ==============================================================================
" Press F5 to instantly save, compile (O2 optimization), and run your C++ file.
" It automatically feeds 'in.txt' into your program so you don't have to manually type test cases.
autocmd filetype cpp nnoremap <F5> :w <bar> !g++ -std=c++20 -O2 -Wall % -o %:r && ./%:r < in.txt<CR>

" Fast window splitting for viewing test cases side-by-side
nnoremap <C-w>h :vsplit in.txt<CR>

" Quick bracket completion
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
