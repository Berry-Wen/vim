" 设置鼠标
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Jan 26
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
" set mouse=n
"将leader键设置为空格，leadr键类似于windows键
let mapleader=" "
" 打开语法高亮
syntax on
" 设置行号
set number
" 设置相对行号
set relativenumber
" 设置当前光标所在位置下划线
set cursorline
" 让字不会超出当前窗口
set wrap
set showcmd
"快速索引命令
set wildmenu
" 光亮搜索
set hlsearch
exec "nohlsearch"
set incsearch
" 忽略大小写
set ignorecase
" 智能大小写，只修改tab显示的宽度，不修改按Tab键的行为
set smartcase
" 在插入模式下，对每行按与上行同样的标准进行缩进，与shiftwidth选项结合使用
set autoindent
" 在vi中输入），}时，光标会暂时的回到相匹配的（，{ （如果没有相匹配的就发出错误信息的铃声），编程时很有用
set showmatch
" 指定tab缩进的字符数目，只修改tab显示的宽度，不修改按Tab键的行为
set tabstop=4
set encoding=utf-8


" 每次搜索后，如果想取消高亮，则直接输入空格+回车就可以取消高亮
noremap <LEADER><CR> :nohlsearch<CR>
map s <nop>
map S :w<CR>
map Q :q<CR>
map R :so $MYVIMRC<CR>
map TOC :Toc<CR>:vertical resize 25<CR>
map MARK :MarkdownPreview<CR>

"------bash------
" 右端启动
noremap <F5> : belowright vert term<cr> 
" 下端启动
noremap <F4> : below term<cr> 
" tnoremap <C-n> <c-\><c-n> # 把bash转为normal模式
"------End------
" 将jk映射未<esc>
inoremap jk  <ESC>
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <space> za
"基于缩进进行代码折叠
set foldmethod=indent
" 启动 Vim 时关闭折叠
set nofoldenable



"------F5 run python-file------
map <F1> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'python'
		exec "!time python %"
	endif
endfunc

" https://www.jianshu.com/p/f0513d18742a
"按F5运行python, 在窗口下方运行"
map <F5> :Autopep8<CR> :w<CR> :call RunPython()<CR>
function RunPython()
    let mp = &makeprg
    let ef = &errorformat
    let exeFile = expand("%:t")
    setlocal makeprg=python\ -u
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    silent make %
    copen
    let &makeprg = mp
    let &errorformat = ef
endfunction

"------End------
let python_highlight_all=1
au Filetype python set tabstop=4
au Filetype python set softtabstop=4
au Filetype python set shiftwidth=4
au Filetype python set textwidth=79
au Filetype python set expandtab
au Filetype python set autoindent
au Filetype python set fileformat=unix
autocmd Filetype python set foldmethod=indent
autocmd Filetype python set foldlevel=99


" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'



call plug#begin('~/.config/nvim/plugged')

"安装插件

Plug 'tell-k/vim-autopep8'
" 语法检查
Plug 'scrooloose/syntastic'

" tag
Plug 'majutsushi/tagbar'

Plug 'Valloric/YouCompleteMe'
" change ycm color
highlight Pmenu ctermfg=3 ctermbg=4 guifg=#ffffff guibg=#0000ff
" define jump
" map <F6> :YcmCompleter GoTo<CR>
"------End------

 
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone
noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }

Plug 'kien/rainbow_parentheses.vim'



Plug 'scrooloose/nerdtree'
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 25  " 设定开启NERDTree的窗口大小



Plug 'godlygeek/tabular' "必要插件，安装在vim-markdown前面
Plug 'plasticboy/vim-markdown'

let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1


"安装插件
Plug 'mzlogin/vim-markdown-toc'
let g:vmt_auto_update_on_save = 0


" 安装插件
Plug 'iamcco/markdown-preview.nvim'
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 1

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = '127.0.0.1'

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 1


" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'





Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"



Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=1
set conceallevel=2
let g:tex_conceal='abdmg'
let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 --interaction=nonstopmode $*'


Plug 'KeitaNakamura/tex-conceal.vim'
"    set conceallevel=0
"    let g:tex_conceal='abdmg'
"    hi Conceal ctermbg=none

Plug 'dylanaraps/wal'
" colorscheme wal
set background=dark



Plug 'vim-airline/vim-airline'
Plug 'connorholyday/vim-snazzy'

Plug 'ferrine/md-img-paste.vim' 
"设置默认储存文件夹。这里表示储存在当前文档所在文件夹下的'pic'文件夹下，相当于 ./pic/
let g:mdip_imgdir = 'pic' 
"设置默认图片名称。当图片名称没有给出时，使用默认图片名称
let g:mdip_imgname = 'image'
"设置快捷键，个人喜欢 Ctrl+p 的方式，比较直观
autocmd FileType markdown nnoremap <silent> <C-p> :call mdip#MarkdownClipboardImage()<CR>F%i
" setlocal spell
" set spelllang=en_us,cjk
call plug#end()


"if v:lang =~ "zh_CN"
"		echo "早上好"
"else
"		echo "Good morning"
"endif


autocmd BufNewFile *.py exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
        if &filetype == 'python'
                call setline(1, "\#######################################")
                call append(line("."), "\# > File Name: ".expand("%"))
                call append(line(".")+1, "#!/usr/bin/env python")
                call append(line(".")+2, "# -*- coding:utf-8 -*-")
                call append(line(".")+3,"")

		else
                call setline(1, "/*************************************************************************")
                call append(line("."), "        > File Name: ".expand("%"))
                call append(line(".")+1, "      > Author: xxxxx")
                call append(line(".")+2, "      > Created Time: ".strftime("%c"))
                call append(line(".")+3, " **********************************************************************/)
                call append(line(".")+4, "")
        endif
endfunc

"新建文件后，自动定位到文件末尾"
autocmd BufNewFile * normal G


" 防止ulti与YCM冲突
" https://blog.csdn.net/qq_20336817/article/details/51115411
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif
if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
