" 开启语法高亮  
syntax enable

" 开启语法高亮
syntax on 

" 设置历史记录条数  
set history=2000

" 检测文件类型  
filetype on  

" 针对不同的文件，采用不同的缩进方式  
filetype indent on

" 允许插件  
filetype plugin on

" 启动自动补全
filetype plugin indent on

" 设置取消备份，禁止临时文件生成  
"set nobackup  
"set noswapfile

" 设置在Vim中可以使用鼠标，防止终端无法拷贝  
"set mouse=a  

" 显示当前行号和列号
set ruler

" 在状态栏显示正在输入的命令
set showcmd

" 左下角显示当前Vim模式
set showmode

set hidden

" 显示行号  
set number 

" 设置代码匹配,包括括号匹配情况  
set showmatch 

" 设置搜索高亮(hlsearch)  
set hls  


" 设置搜索时忽略大小写  
set ignorecase 

" 当搜索的时候尝试smart  
set smartcase 

" 设置C/C++方式自动对齐  
set autoindent  
set cindent  
set smartindent 

" 设置tab宽度  
set tabstop=4  

" 设置自动对齐空格数  
set shiftwidth=4  

" 按退格键时可以一次删除4个空格
set softtabstop=4

" 将tab键自动转换为空格
set expandtab

" 自动补全括号
"inoremap ( ()<Esc>i
"inoremap [ []<Esc>i
"inoremap { {<CR>}<Esc>O

" 不兼容vi语法
set nocp

set dir-=.
set bdir-=.

set runtimepath+=./vim/autoload


" 中文
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

" set path+=/usr/include/c++/8
set path+=/usr/include/**,/usr/local/include/**


set background=dark

source $VIMRUNTIME/ftplugin/man.vim

" 设置取消备份，禁止临时文件生成  
set backup  
set swapfile

" 生成系统include的tags
let s:systags = findfile('~/.systags')
if(s:systags == "")
    !ctags -I __THROW --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --fields=+S  -R -f .systags /usr/include /usr/local/include
endif
set tags+=~/.systags

" 搜索选中区域
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

" 注释快捷键#b #e
iabbrev #b /************************
iabbrev #e <Space>************************/



" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif




" 配置autoload/plug.vim
call plug#begin('~/.vim/plugged')
Plug 'ludovicchabant/vim-gutentags'
call plug#end()
