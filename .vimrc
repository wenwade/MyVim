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
set nobackup  
set noswapfile

" 设置在Vim中可以使用鼠标，防止终端无法拷贝  
"set mouse=a  

" 显示当前行号和列号
set ruler

" 在状态栏显示正在输入的命令
set showcmd

" 左下角显示当前Vim模式
set showmode

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
inoremap { {<CR>}<Esc>O

" 不兼容vi语法
set nocp

" 搜索选中区域
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

