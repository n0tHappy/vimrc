set nocompatible "不用vi的键盘模式
"设置插件可用
filetype plugin indent on


"过70字符，如果前面有空格的话，会在空格处自动换行
set lbr
set tw=200

set fileencodings=utf-8,chinese,latin-1
set termencoding=utf-8
set encoding=utf-8
"if has("win32")
"set fileencoding=chinese
"else
"set fileencoding=utf-8
"endif
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"解决consle输出乱码
language messages zh_CN.utf-8

"不要备份文件
set nobackup 
"set noundofile
set noswapfile
" 开启undo备份
set undofile

"设置行号
set nu!

"总是显示目前的位置
set ruler

filetype off 
"不同文件采用不同缩进
filetype indent on

"统一Tab缩进为4
set softtabstop=4
set shiftwidth=4   "每一级的缩进长度
set autoindent  "自动缩进
set smartindent
set expandtab "用多个空格代替tab键


source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

"引入html相关的自动补全
"设置在html文件下才加载
"source $VIM/configure/html.vim

"建立模板

"配置背景配色
colorscheme desert
set background=dark



"常见易错单词
iabbrev sturts struts
iabbrev syso System.out.println("")<esc>hh


"映射alt来快速切换tab,新建，关闭   注意：:tabn1前必须要有空格，否则无法识别
if has('gui_running')
   set winaltkeys=no
   "set macmeta
   noremap <silent><c-tab> :tabprev<CR>
   inoremap <silent><c-tab> <ESC> :tabprev<CR>
   noremap <silent><m-1> :tabn1<cr>
   noremap <silent><m-2> :tabn2<cr>
   noremap <silent><m-3> :tabn3<cr>
   noremap <silent><m-4> :tabn4<cr>
   noremap <silent><m-5> :tabn5<cr>
   noremap <silent><m-6> :tabn6<cr>
   noremap <silent><m-7> :tabn7<cr>
   noremap <silent><m-8> :tabn8<cr>
   noremap <silent><m-9> :tabn9<cr>
   noremap <silent><m-0> :tabn10<cr>
   noremap <silent><m-n> :tabnew<cr>
   noremap <silent><m-c> :tabclose<cr>
   inoremap <silent><m-1> <ESC>:tabn1<cr>
   inoremap <silent><m-2> <ESC>:tabn2<cr>
   inoremap <silent><m-3> <ESC>:tabn3<cr>
   inoremap <silent><m-4> <ESC>:tabn4<cr>
   inoremap <silent><m-5> <ESC>:tabn5<cr>
   inoremap <silent><m-6> <ESC>:tabn6<cr>
   inoremap <silent><m-7> <ESC>:tabn7<cr>
   inoremap <silent><m-8> <ESC>:tabn8<cr>
   inoremap <silent><m-9> <ESC>:tabn9<cr>
   inoremap <silent><m-0> <ESC>:tabn10<cr>
   inoremap <silent><m-n> <ESC>:tabnew<cr>
   inoremap <silent><m-c> <ESC>:tabclose<cr>
   "设置多行注释
   "noremap <silent><m-/> 0<c-q>I//<ESC>
   "noremap <silent><m-.> <c-q>lld
endif

""""""""""""""""""""""""""""""""""""""""
"各种映射
""""""""""""""""""""""""""""""""""""""""
"快速建立tags文件
nnoremap <f5> :!ctags -R<CR>
"映射窗口快速切换的快捷键
map <c-k> <C-w>k
map <c-j> <C-w>j
map <c-h> <C-w>h
map <c-l> <C-w>l
"把ctrl + p映射为esc,避免误触
inoremap <c-p> <esc>
"映射 kj 为 <esc>键
inoremap kj <esc>
"把alt+j,k映射成翻页功能
noremap <m-j> <pagedown>
noremap <m-k> <pageup>
"插入模式下的上下左右移动
if has('gui_running')
    set winaltkeys=no
    inoremap <m-h> <left>
    inoremap <m-j> <down>
    inoremap <m-k> <up>
    inoremap <m-l> <right>
endif
"标签页的左右移动
nnoremap <m-l> gt
nnoremap <m-h> gT
"把空格映射为viw
nmap <space> viw
"把U映射为反撤销
nmap U <c-r>
"把去除高亮显示映射为退格键
noremap <backspace> :noh<cr>


set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

func! CompileJava()
	exec "!javac -encoding utf-8 %"
endfunc

func! RunJava()
	exec "!java %<"
endfunc

map <F6> : call CompileJava()<CR>
imap <F6> <ESC>:call CompileJava()<CR>
map <F6> <ESC>:call CompileJava()<CR>

map <F7> :call RunJava()<CR>


"输入 { 会自动换行，并且 光标在两个{}之中的一行
inoremap {<cr> {<cr>}<esc>O
"自动补全 ()
"inoremap ( ()<ESC>i
"自动补全 <>
"inoremap < <><ESC>i
"自动补全 []
"inoremap [ []<ESC>i

"隐藏菜单栏
set guioptions-=m
"隐藏工具栏
set guioptions-=T

"编写一个移动一行的操作，按键是 Alt + j

"设置桌面地址的变量



"把%%映射为打印当前文件所在目录
cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:h').'/' : '%%'

"加载matchit插件，增强了%的功能
runtime macros/matchit.vim



"ycm
"set runtimepath+=$VIM/vimfiles/bundle/YouCompleteMe

"====================================================
"vimtweak
"配置界面透明度
"map <leader>- <esc>:call libcallnr("vimtweak.dll","SetAlpha",200)<cr>
"map <leader>= <esc>:call libcallnr("vimtweak.dll","SetAlpha",255)<cr>
"Only on windows make windows transparent 
"au GUIEnter * simalt ~x
:let g:m_tweak_SetAlpha = 1
func! Tweak_SetAlpha()
:if g:m_tweak_SetAlpha == 1
call libcallnr("vimtweak.dll","SetAlpha",190)
let g:m_tweak_SetAlpha=0
:else 
call libcallnr("vimtweak.dll","SetAlpha",255)
let g:m_tweak_SetAlpha=1
:endif
endfunc 
map <m-a> :call Tweak_SetAlpha()<cr>
" func! SaveInputData()
" call libcallnr("vimtweak.dll","SetAlpha",200)
" let g:m_tweak_SetAlpha=0
" endfunc
" :autocmd BufReadPost * call SaveInputData()


" if executable("vimtweak.dll") 
" autocmd guienter * call libcallnr("vimtweak","SetAlpha",222) 
" endif
" ==============================================================
" vimwiki
let g:vimwiki_user_mouse=1
let g:vimwiki_list=[{'path': 'D:/vimwiki/','path_html' : 'D:/vimwiki/vimwiki_html/'}]
" 取消驼峰建立词条
let g:vimwiki_camel_case = 0
" 标记为完成的checklist项目会有特别的颜色
let g:vimwiki_hl_cb_checked = 1
" 取消vimwiki菜单
let g:vimwiki_menu = ''
" 把f2映射为生成目录
noremap <leader>t :VimwikiTOC<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'""""""""
"vundle插件  :BundleInstall
set rtp+=$VIM/vimfiles/bundle/vundle/
call vundle#rc('$VIM/vimfiles/bundle/')
Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/nerdtree'
Bundle 'Xuyuanp/nerdtree-git-plugin'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'majutsushi/tagbar'
"javascript缩进
Bundle 'jiangmiao/simple-javascript-indenter'
"html缩进
Bundle 'othree/html5.vim'
Bundle 'kien/ctrlp.vim'
" 查询插件，代替ctrlp
Bundle 'Yggdroot/LeaderF'
"Bundle 'Shougo/neocomplcache.vim'
"Bundle 'terryma/vim-multiple-cursors'
"快速注释
Bundle 'tpope/vim-commentary'
Bundle 'vimwiki/vimwiki'
"markdown高亮插件，前一个插件为后者的依赖，是文本对齐插件
Bundle 'godlygeek/tabular'
"Bundle 'plasticboy/vim-markdown'


"====================================================
"nerdtree配置
" Ctrl+u 打开/关闭
map <C-u> :NERDTreeToggle<CR>
"把当前文件所在目录设为项目根目录
noremap <f4> :NERDTreeFind<cr>
" 当不带参数打开Vim时自动加载项目树
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" 当所有文件关闭时关闭项目树窗格
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" 不显示这些文件
let NERDTreeIgnore=['\.pyc$', '\~$', 'node_modules'] "ignore files in NERDTree
" 不显示项目树上额外的信息，例如帮助、提示什么的
let NERDTreeMinimalUI=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"airline配置
let g:airline_theme='luna'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#whitespace#enabled=0
if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif
set t_Co=256
set laststatus=2
set lazyredraw
"设置字体和大小
set guifont=Powerline\ Consolas:h12:cDEFAULT

"html缩进
let g:html_indent_script1 = "inc"   
let g:html_indent_style1 = "inc"  
let g:html_indent_inctags = "html,body,head,tbody"

"配置tagbar
nnoremap <silent> <c-m> :TagbarToggle<CR>

"ctrlp
"let g:ctrlp_map = '<c-f>'

" Leaderf
" LeaderfFile %% 当前文件所在的空间作为搜索空间
