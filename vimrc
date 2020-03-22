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
set backup  
set swapfile

" 设置在Vim中可以使用鼠标，防止终端无法拷贝  
set mouse=

" 显示当前行号和列号
set ruler

" 在状态栏显示正在输入的命令
set showcmd

" 左下角显示当前Vim模式
set noshowmode

" 切换文件不用保存
set hidden

" 显示行号  
set number 

" 设置代码匹配,包括括号匹配情况  
set showmatch 

" 设置搜索高亮
set hlsearch  

" 增量搜索
set incsearch

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

" 不兼容vi语法
set nocp

" 交换文件目录
set dir-=.

" 备份文件目录
set bdir-=.


" 中文
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

" 添加系统头文件目录
set path+=/usr/include/**,/usr/local/include/**

" 设置背景
set background=dark

" Man命令
source $VIMRUNTIME/ftplugin/man.vim

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


" 编译当前c++文件
command Compile :AsyncRun g++ -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"

" 异步make
command Make :AsyncRun make

" git diff
command Diff :SignifyDiff


" 配置autoload/plug.vim
call plug#begin('~/.vim/plugged')
" 自动生成tags，需要在项目目录有.git，或者.root空文件
Plug 'ludovicchabant/vim-gutentags'
" 异步编译，AsyuncRun
Plug 'skywind3000/asyncrun.vim'
" 动态检查语法错误
Plug 'wenwade/ale'
"Plug 'dense-analysis/ale'
" 修改比较。 SignifyDiff
Plug 'mhinz/vim-signify'
" di, 删除函数参数 dii 删除同缩进 dif 删除函数
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'
" 高亮
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-unimpaired'
" 参数提示
Plug 'Shougo/echodoc.vim'
" 头文件和源文件快速切换
Plug 'tpope/vim-projectionist'
" 文件切换，找函数 <c-p> <c-n> <m-p> <m-n>
Plug 'Yggdroot/LeaderF'
" 代码补全
Plug 'ycm-core/YouCompleteMe'
" 看目录
Plug 'justinmk/vim-dirvish'
call plug#end()
"Plug 'vim-scripts/a.vim'


" for gutentags
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



" For asyncrun
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1


" for ale
" 对应语言需要安装相应的检查工具
" https://github.com/w0rp/ale
"    let g:ale_linters_explicit = 1 "除g:ale_linters指定，其他不可用
"    let g:ale_linters = {
"\   'cpp': ['cppcheck','clang','gcc'],
"\   'c': ['cppcheck','clang', 'gcc'],
"\   'python': ['pylint'],
"\   'bash': ['shellcheck'],
"\   'go': ['golint'],
"\}
"
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_sign_error = "\ue009\ue009"
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=blue
hi! SpellRare gui=undercurl guisp=magenta



" for 'ycm-core/YouCompleteMe'
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


let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
let g:ycm_global_ycm_extra_conf='~/.vim/config/.ycm_extra_conf.py'



" for 'Yggdroot/LeaderF'
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>'
noremap <c-n> :LeaderfMru<cr>
noremap <m-p> :LeaderfFunction!<cr>
noremap <m-n> :LeaderfBuffer<cr>
noremap <m-m> :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
