set ai
set bg=dark
set cursorline
set fileencodings=utf8,big5
set hls
set mouse=nv
set ruler
set number
set expandtab
set tabstop=4
set shiftwidth=4
set foldenable
set foldmethod=indent
set foldcolumn=1
set foldlevel=5
set showcmd
syntax on
inoremap jk <ESC>
inoremap aa <C-n>
"inoremap {<CR> {<CR>}<ESC>ko
"inoremap ( ()<ESC>i
"inoremap [ []<ESC>i
"inoremap ' ''<ESC>i
"inoremap " ""<ESC>i
set backspace=indent,eol,start
autocmd FileType markdown setlocal spell

if exists('g:loaded_pairify')
    finish
endif
let g:loaded_pairify = 1

let g:pairs = {
            \ "left": {
            \   "[": "]",
            \   "(": ")",
            \   "{": "}",
            \   "<": ">",
            \   "'": "'",
            \   '"': '"'
            \ },
            \ "right": {
            \   "]": "[",
            \   ")": "(",
            \   "}": "{",
            \   ">": "<",
            \   "'": "'",
            \   '"': '"'
            \ }
            \}

function! s:is_compliment(char1, char2)
    if has_key(g:pairs.left, a:char1)
        return a:char2 == g:pairs.left[a:char1]
    elseif has_key(g:pairs.right, a:char1)
        return a:char2 == g:pairs.right[a:char1]
    endif
endfunction

function! s:is_quote(char)
    return a:char ==# "'" || a:char ==# '"'
endfunction

function! s:find_pair(string)
    let stack = []
    let characters = split(a:string, '\zs')

    for char in reverse(characters)
        if has_key(g:pairs.right, char)
            if !empty(stack) && s:is_quote(char) && stack[-1] ==# char
                call remove(stack, -1)
                continue
            endif
            call add(stack, char)
        elseif has_key(g:pairs.left, char)
            if !empty(stack) && s:is_compliment(char, stack[-1])
                call remove(stack, -1)
            elseif empty(stack)
                return g:pairs.left[char]
            endif
        endif
    endfor

    if empty(stack)
        return "\t"
    else
        return remove(stack, 0)
    endif
endfunction

function! s:pairify()
    return s:find_pair(getline('.')[0:col('.')-1])
endfunction

inoremap <expr> <silent> <Plug>(pairify-complete) <SID>pairify()
imap <Tab> <Plug>(pairify-complete)
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
"
"
nmap <F8> :TagbarToggle<CR>


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
