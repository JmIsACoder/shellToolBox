#!/bin/sh

echo "******Installing vim, git, m4, gcc, g++, typora"
echo

sudo apt-get install -y vim git m4 gcc g++ net-tools
# typora
# or run:
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
# add Typora's repository
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt-get update
# install typora
sudo apt-get install -y typora

echo "******configure .vimrc"
echo

filename="/home/$USER"
touch $filename/.vimrc 
cat > $filename/.vimrc << EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 显示相关  

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示  

"winpos 5 5          " 设定窗口位置  

"set lines=40 columns=155    " 设定窗口大小  

"set nu              " 显示行号  

set go=             " 不要图形按钮  

"color asmanian2     " 设置背景主题  

set guifont=Courier_New:h10:cANSI   " 设置字体  

syntax on           " 语法高亮  

autocmd InsertLeave * se nocul  " 用浅色高亮当前行  

autocmd InsertEnter * se cul    " 用浅色高亮当前行  

"set ruler           " 显示标尺  

set showcmd         " 输入的命令显示出来，看的清楚些  

"set cmdheight=1     " 命令行（在状态行下）的高度，设置为1  

"set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)  

"set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离  

"set novisualbell    " 不要闪烁(不明白)  

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  

set laststatus=1    " 启动显示状态行(1),总是显示状态行(2)  

" set foldenable      " 允许折叠  

"set foldmethod=manual   " 手动折叠  

"set background=dark "背景使用黑色 

set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限  

" 显示中文帮助

if version >= 603

    set helplang=cn

    set encoding=utf-8

endif

" 设置配色方案

"colorscheme murphy

"字体 

"if (has("gui_running")) 

"   set guifont=Bitstream\ Vera\ Sans\ Mono\ 10 

"endif 


 
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936

set termencoding=utf-8

set encoding=utf-8

set fileencodings=ucs-bom,utf-8,cp936

set fileencoding=utf-8



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""新文件标题""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"新建.c,.h,.sh,.java文件，自动插入文件头 

autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 

""定义函数SetTitle，自动插入文件头 

func SetTitle() 

    "如果文件类型为.sh文件 

    if &filetype == 'sh' 

        call setline(1,"\#########################################################################") 

        call append(line("."), "\# File Name: ".expand("%")) 

        call append(line(".")+1, "\# Author: jiaming") 

        call append(line(".")+2, "\# Mail: jmzhang@lzu.edu.com") 

        call append(line(".")+3, "\# Created Time: ".strftime("%c")) 

        call append(line(".")+4, "\#########################################################################") 

        call append(line(".")+5, "\#!/bin/bash") 

        call append(line(".")+6, "") 

    else 

        call setline(1, "/*************************************************************************") 

        call append(line("."), "    > File Name: ".expand("%")) 

        call append(line(".")+1, "    > Author: jiaming") 

        call append(line(".")+2, "    > Mail: jmzhang2020@lzu.edu.com ") 

        call append(line(".")+3, "    > Created Time: ".strftime("%c")) 

        call append(line(".")+4, " ************************************************************************/") 

        call append(line(".")+5, "")

    endif

    if &filetype == 'cpp'

        call append(line(".")+6, "#include <iostream>")

        call append(line(".")+7, "using namespace std;")

        call append(line(".")+8, "")

    endif

    if &filetype == 'c'

        call append(line(".")+6, "#include <stdio.h>")

        call append(line(".")+7, "")

    endif

    "新建文件后，自动定位到文件末尾

    autocmd BufNewFile * normal G

endfunc 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"键盘命令

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



nmap <leader>w :w!<cr>

nmap <leader>f :find<cr>



" 映射全选+复制 ctrl+a

map <C-A> ggVGY

map! <C-A> <Esc>ggVGY

map <F12> gg=G

" 选中状态下 Ctrl+c 复制

vmap <C-c> "+y

"去空行  

nnoremap <F2> :g/^\s*$/d<CR> 

"比较文件  

nnoremap <C-F2> :vert diffsplit 

"新建标签  

map <M-F2> :tabnew<CR>  

"列出当前目录文件  

map <F3> :tabnew .<CR>  

"打开树状文件目录  

map <C-F3> \be  

"C，C++ 按F5编译运行

map <F5> :call CompileRunGcc()<CR>

func! CompileRunGcc()

    exec "w"

    if &filetype == 'c'

        exec "!g++ % -o %<"

        exec "! ./%<"

    elseif &filetype == 'cpp'

        exec "!g++ % -o %<"

        exec "! ./%<"

    elseif &filetype == 'java' 

        exec "!javac %" 

        exec "!java %<"

    elseif &filetype == 'sh'

        :!./%

    endif

endfunc

"C,C++的调试

map <F8> :call Rungdb()<CR>

func! Rungdb()

    exec "w"

    exec "!g++ % -g -o %<"

    exec "!gdb ./%<"

endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""实用设置

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 设置当文件被改动时自动载入

set autoread

" quickfix模式

autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>

"代码补全 

set completeopt=preview,menu 

"允许插件  

filetype plugin on

"共享剪贴板  

set clipboard+=unnamed 

"从不备份  

set nobackup

"make 运行

:set makeprg=g++\ -Wall\ \ %

"自动保存

set autowrite

set ruler                   " 打开状态栏标尺

set cursorline              " 突出显示当前行

set magic                   " 设置魔术

set guioptions-=T           " 隐藏工具栏

set guioptions-=m           " 隐藏菜单栏

"set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\

" 设置在状态行显示的信息

set foldcolumn=0

set foldmethod=indent 

set foldlevel=3 

set foldenable              " 开始折叠

" 不要使用vi的键盘模式，而是vim自己的

set nocompatible

" 语法高亮

set syntax=on

" 去掉输入错误的提示声音

set noeb

" 在处理未保存或只读文件的时候，弹出确认

set confirm

" 自动缩进

set autoindent

set cindent

" Tab键的宽度

set tabstop=4

" 统一缩进为4

set softtabstop=4

set shiftwidth=4

" 不要用空格代替制表符

set noexpandtab

" 在行和段开始处使用制表符

set smarttab

" 显示行号

set number

" 历史记录数

set history=1000

"禁止生成临时文件

set nobackup

set noswapfile

"搜索忽略大小写

set ignorecase

"搜索逐字符高亮

set hlsearch

set incsearch

"行内替换

set gdefault

"编码设置

set enc=utf-8

set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936

"语言设置

set langmenu=zh_CN.UTF-8

set helplang=cn

" 我的状态行显示的内容（包括文件类型和解码）

"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]

" 总是显示状态行

set laststatus=2

" 命令行（在状态行下）的高度，默认为1，这里是2

set cmdheight=2

" 侦测文件类型

filetype on

" 载入文件类型插件

filetype plugin on

" 为特定文件类型载入相关缩进文件

filetype indent on

" 保存全局变量

set viminfo+=!

" 带有如下符号的单词不要被换行分割

set iskeyword+=_,$,@,%,#,-

" 字符间插入的像素行数目

set linespace=0

" 增强模式中的命令行自动完成操作

set wildmenu

" 使回格键（backspace）正常处理indent, eol, start等

set backspace=2

" 允许backspace和光标键跨越行边界

set whichwrap+=<,>,h,l

" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）

set mouse=a

set selection=exclusive

set selectmode=mouse,key

" 通过使用: commands命令，告诉我们文件的哪一行被改变过

set report=0

" 高亮显示匹配的括号

set showmatch

" 匹配括号高亮的时间（单位是十分之一秒）

set matchtime=1

" 光标移动到buffer的顶部和底部时保持3行距离

set scrolloff=3

" 为C程序提供自动缩进

set smartindent

" 高亮显示普通txt文件（需要txt.vim脚本）

au BufRead,BufNewFile *  setfiletype txt

"自动补全

:inoremap ( ()<ESC>i

:inoremap ) <c-r>=ClosePair(')')<CR>

:inoremap { {<CR>}<ESC>O

:inoremap } <c-r>=ClosePair('}')<CR>

:inoremap [ []<ESC>i

:inoremap ] <c-r>=ClosePair(']')<CR>

:inoremap " ""<ESC>i

:inoremap ' ''<ESC>i

function! ClosePair(char)

    if getline('.')[col('.') - 1] == a:char

        return "\<Right>"

    else

        return a:char

    endif

endfunction

filetype plugin indent on 

"打开文件类型检测, 加了这句才可以用智能补全

set completeopt=longest,menu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" CTags的设定  

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let Tlist_Sort_Type = "name"    " 按照名称排序  

let Tlist_Use_Right_Window = 1  " 在右侧显示窗口  

let Tlist_Compart_Format = 1    " 压缩方式  

let Tlist_Exist_OnlyWindow = 1  " 如果只有一个buffer，kill窗口也kill掉buffer  

let Tlist_File_Fold_Auto_Close = 0  " 不要关闭其他文件的tags  

let Tlist_Enable_Fold_Column = 0    " 不要显示折叠树  

autocmd FileType java set tags+=D:\tools\java\tags  

"autocmd FileType h,cpp,cc,c set tags+=D:\tools\cpp\tags  

"let Tlist_Show_One_File=1            "不同时显示多个文件的tag，只显示当前文件的

"设置tags  

set tags=tags  

"set autochdir 



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"其他东东

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"默认打开Taglist 

let Tlist_Auto_Open=1 

"""""""""""""""""""""""""""""" 

" Tag list (ctags) 

"""""""""""""""""""""""""""""""" 

let Tlist_Ctags_Cmd = '/usr/bin/ctags' 

let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的 

let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim 

let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口

" minibufexpl插件的一般设置

let g:miniBufExplMapWindowNavVim = 1

let g:miniBufExplMapWindowNavArrows = 1

let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1




EOF

# Han
echo "******configure han"
echo

filename="/home/$USER/.config/Typora/themes"
mkdir -p $filename/han

touch $filename/han.css
cat > $filename/han.css << EOF
@charset "utf-8";

:root {
  --active-file-bg-color: #dadada;
  --active-file-bg-color: rgba(32, 43, 51, 0.63);
  --active-file-text-color: white;
  --bg-color: #fff;
  --text-color: #333;
  --side-bar-bg-color: #f5f5f5;
  --control-text-color: #666;
}

/* 防止用户自定义背景颜色对网页的影响，添加让用户可以自定义字体 */
html {
  color: #333;
  background: #fff;
  -webkit-text-size-adjust: 100%;
  -ms-text-size-adjust: 100%;
  text-rendering: optimizelegibility;
  font-size: 14px;
  -webkit-font-smoothing: initial;
}

#write {
  max-width: 960px;
  padding-top: 2em;
  padding-left: 60px;
  padding-right: 60px;
  min-height: calc(100vh - 6em);
  -webkit-font-smoothing: antialiased;
  font-size: 16px;
}

.typora-node #write {
  min-height: calc(100% - 6em);
}

pre.md-meta-block {
  background: #f5f5f5;
  padding: 1em;
  border-radius: 3px;
  font-size: 14px;
}

@media screen and (max-width: 800px) {
    html {
      font-size: 14px;
    }

    #write {
      padding-left: 30px;
      padding-right: 30px;
      font-size: 14px;
    }
}

@media screen and (min-width: 1100px) {
    body, #footer-word-count-info {
      background: #f5f5f5;
    }

    body.pin-outline,
    .pin-outline #footer-word-count-info,
    .pin-outline footer {
      background: #fff;
    }

    #write {
      max-width: 1000px;
      padding: 40px 60px;
      background: #fff;
      margin: 3em auto 3em;
      border: 1px solid #ddd;
      border-width: 0 1px;
    }

    .pin-outline #write {
      max-width: 1000px;
      background: #fff;
      margin: 0 0 0;
      border: 0;
      padding-left: 60px;
      padding-right: 60px;
    }

    footer {
      background-color: transparent;
    }
}

@media screen and (min-width: 1300px) {
    body.pin-outline,
    .pin-outline #footer-word-count-info,
    .pin-outline footer {
      background: #f5f5f5;
    }

    .pin-outline  #write {
      max-width: 1000px;
      padding: 40px 60px;
      background: #fff;
      margin: 3em auto 3em;
      border: 1px solid #ddd;
      border-width: 0 1px;
    }

    .pin-outline footer {
      background-color: transparent;
    }

    #footer-word-count-info {
      background: #f5f5f5;
    }
}


/* 如果你的项目仅支持 IE9+ | Chrome | Firefox 等，推荐在 <html> 中添加 .borderbox 这个 class */
html.borderbox *, html.borderbox *:before, html.borderbox *:after {
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
}

/* 内外边距通常让各个浏览器样式的表现位置不同 */
body, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, code, form, fieldset, legend, input, textarea, p, blockquote, th, td, hr, button, article, aside, details, figcaption, figure, footer, header, menu, nav, section {
  margin: 0;
  padding: 0;
}

/* 重设 HTML5 标签, IE 需要在 js 中 createElement(TAG) */
article, aside, details, figcaption, figure, footer, header, menu, nav, section {
  display: block;
}

/* HTML5 媒体文件跟 img 保持一致 */
audio, canvas, video {
  display: inline-block;
}

/* 要注意表单元素并不继承父级 font 的问题 */
body, button, input, select, textarea {
  font: 300 1em/1.8 "PingFang SC", "Lantinghei SC", "Microsoft Yahei", "Hiragino Sans GB", "Microsoft Sans Serif", "WenQuanYi Micro Hei", sans;
}

body {
  font-family: "PingFang SC", "Lantinghei SC", "Microsoft Yahei", "Hiragino Sans GB", "Microsoft Sans Serif", "WenQuanYi Micro Hei", sans;
}

h1, h2, h3, h4, h5, h6 {
  font-family: "TimesNewRomanPS-ItalicMT", "PingFang SC", "Lantinghei SC", "Microsoft Yahei", "Hiragino Sans GB", "Microsoft Sans Serif", "WenQuanYi Micro Hei", sans;
  /*font-family: "PingFang SC", "Lantinghei SC", "Microsoft Yahei", "Hiragino Sans GB", "Microsoft Sans Serif", "WenQuanYi Micro Hei", sans;*/
  -webkit-font-smoothing: initial;
  font-weight: 100;
  color: var(--text-color);
  line-height: 1.35; 
  font-variant-numeric: lining-nums;
  margin-bottom: 1em;
}

em {
  font-family: Georgia-Italic, STSongti-SC-Light, serif;
}

strong em,
em strong {
  font-family: Georgia-BoldItalic, STSongti-SC-Regular, serif;
}

button::-moz-focus-inner,
input::-moz-focus-inner {
  padding: 0;
  border: 0;
}

/* 去掉各Table cell 的边距并让其边重合 */
table {
  border-collapse: collapse;
  border-spacing: 0;
}

/* 去除默认边框 */
fieldset, img {
  border: 0;
}

/* 块/段落引用 */
blockquote {
  position: relative;
  color: #999;
  font-weight: 400;
  border-left: 1px solid #1abc9c;
  padding-left: 1em;
  margin: 1em 3em 1em 2em;
}

@media only screen and ( max-width: 640px ) {
  blockquote {
    margin: 1em 0;
  }
}

/* Firefox 以外，元素没有下划线，需添加 */
acronym, abbr {
  border-bottom: 1px dotted;
  font-variant: normal;
}

/* 添加鼠标问号，进一步确保应用的语义是正确的（要知道，交互他们也有洁癖，如果你不去掉，那得多花点口舌） */
abbr {
  cursor: help;
}

address, caption, cite, code, dfn, th, var {
  font-style: normal;
  font-weight: 400;
}

/* 去掉列表前的标识, li 会继承，大部分网站通常用列表来很多内容，所以应该当去 */
ul, ol {
  list-style: none;
}

/* 对齐是排版最重要的因素, 别让什么都居中 */
caption, th {
  text-align: left;
}

q:before, q:after {
  content: '';
}

/* 统一上标和下标 */
sub, sup {
  font-size: 75%;
  line-height: 0;
  position: relative;
}

:root sub, :root sup {
  vertical-align: baseline; /* for ie9 and other modern browsers */
}

sup {
  top: -0.5em;
}

sub {
  bottom: -0.25em;
}

/* 让链接在 hover 状态下显示下划线 */
a {
  color: #1abc9c;
}

a:hover {
  text-decoration: underline;
}

#write a {
  border-bottom: 1px solid #1abc9c;
}

#write a:hover {
  border-bottom-color: #555;
  color: #555;
  text-decoration: none;
}

/* 默认不显示下划线，保持页面简洁 */
ins, a {
  text-decoration: none;
}

/* 标记，类似于手写的荧光笔的作用 */
mark {
  background: #fffdd1;
  border-bottom: 1px solid #ffedce;
  padding: 2px;
  margin: 0 5px;
}

/* 代码片断 */
pre, code, pre tt {
  font-family: Courier, 'Courier New', monospace;
}

#write .md-fences {
  border: 1px solid #ddd;
  padding: 1em 0.5em;
  display: block;
  -webkit-overflow-scrolling: touch;
}

/* 一致化 horizontal rule */
hr {
  border: none;
  border-bottom: 1px solid #cfcfcf;
  margin-bottom: 0.8em;
  height: 10px;
}

#write strong {
  font-weight: bolder;
  color: #000;
}

.code-tooltip.md-hover-tip strong {
  color: white;
}

/* 保证块/段落之间的空白隔行 */
#write p, #write .md-fences, #write ul, #write ol, #write dl, #write form, #write hr, #write figure,
#write-p, #write-pre, #write-ul, #write-ol, #write-dl, #write-form, #write-hr, #write-table, blockquote {
  margin-bottom: 1.2em
}

html {
  font-family: PingFang SC, Verdana, Helvetica Neue, Microsoft Yahei, Hiragino Sans GB, Microsoft Sans Serif, WenQuanYi Micro Hei, sans-serif;
}

/* 标题应该更贴紧内容，并与其他块区分，margin 值要相应做优化 */
#write h1, #write h2, #write h3, #write h4, #write h5, #write h6,
#write-h1, #write-h2, #write-h3, #write-h4, #write-h5, #write-h6 {
  margin-top: 1.2em;
  margin-bottom: 0.6em;
  line-height: 1.35;
  color: #000;
}

#write h1, #write-h1 {
  font-size: 2.4em;
  padding-bottom: 1em;
  border-bottom: 3px double #eee;
}

#write h2, #write-h2 {
  font-size: 1.8em;
}

#write h3, #write-h3 {
  font-size: 1.6em;
}

#write h4, #write-h4 {
  font-size: 1.4em;
}

#write h5, #write h6, #write-h5, #write-h6 {
  font-size: 1.2em;
}

/* 在文章中，应该还原 ul 和 ol 的样式 */
#write ul, #write-ul {
  margin-left: 1.3em;
  list-style: disc;
}

#write ol, #write-ol {
  list-style: decimal;
  margin-left: 1.9em;
}

#write li ul, #write li ol, #write-ul ul, #write-ul ol, #write-ol ul, #write-ol ol {
  margin-bottom: 0.8em;
  margin-left: 2em;
}

#write li ul, #write-ul ul, #write-ol ul {
  list-style: circle;
}


#write table th, #write table td {
  border: 1px solid #ddd;
  padding: 0.5em 1em;
  color: #666;
}

#write table .md-table-edit th {
  border: none;
  padding: 0;
  color: inherit;
}

#write table th, #write-table th {
  background: #fbfbfb;
}

#write table thead th, #write-table thead th {
  background: #f1f1f1;
}

#write table caption {
  border-bottom: none;
}

#write em {
  font-weight: inherit;
  font-style: inherit;
}

li>p {
    margin-bottom: 0 !important;
}

/* Responsive images */
#write img {
  max-width: 100%;
}

a.md-toc-inner {
    border-bottom: 0 !important;
}

.md-toc-h1:first-of-type:last-of-type{
  display: none;
}

.md-toc {
  font-size: inherit;
}

.md-toc-h1 .md-toc-inner {
  font-weight: normal;
}

.md-table-edit th {
  padding: 0 !important;
  border: 0 !important;
}

.mac-seamless-mode #write {
  min-height: calc(100vh - 6em - 20px);
}

.typora-quick-open-item.active {
    color: var(--active-file-text-color);
}

*.in-text-selection, ::selection {
    background: var(--active-file-bg-color);
    text-shadow: none;
    color: white;
}

.btn-primary {
    background-color: #2d2d2d;
    border-color: #020202;
}

.btn-primary:hover, .btn-primary:focus, .btn-primary.focus, .btn-primary:active, .btn-primary.active, .open > .dropdown-toggle.btn-primary {
    background-color: #4e4c4e;
    border: #4e4c4e;
}

#preference-dialog .modal-content{
  background: #6e757a;
  --bg-color: #6e757a;
  --text-color: #f1f1f1;
  color: #f1f1f1;
}

#typora-source,
.typora-sourceview-on  {
  --bg-color: #eee;
  background: #eee;
}

.cm-s-typora-default .cm-header, .cm-s-typora-default .cm-property {
    color: #116098;
}

.cm-s-typora-default .cm-link {
    color: #11987d;
}

.cm-s-typora-default .cm-em {
  font-family: Georgia-Italic, STSongti-SC-Light, serif;
  color: #6f6400;
}

.cm-s-typora-default .cm-em{
    color: rgb(0, 22, 45);
}

.CodeMirror.cm-s-typora-default div.CodeMirror-cursor{
    border-left: 3px solid #6e757a;
}

.cm-s-typora-default .CodeMirror-selectedtext,
.typora-sourceview-on .CodeMirror-focused .CodeMirror-selected {
    background: #6e757a;
    color: white;
}

.file-node-icon.fa.fa-folder:before {
  color: rgba(32, 43, 51, 0.49);
}

#preference-dialog .megamenu-menu-panel h1 {
  margin-bottom: 1em;
}

::-webkit-scrollbar-corner {
  display: none;
  background: transparent;
}

/*.file-node-icon.fa.fa-folder:before {
  content: "\f114";
}

#typora-sidebar {

}*/

/*.cm-s-typora-default .cm-header, .cm-s-typora-default .cm-property {
  color: #fffff1;
}

.cm-s-typora-default .cm-link {
    color: #86f9e2;
    color: #e5f7eb;
}

.cm-s-typora-default .cm-comment, .cm-s-typora-default .cm-code {
    color: rgb(255, 199, 199);
}

.cm-s-typora-default .cm-atom, .cm-s-typora-default .cm-number {
    color: #dec4c7;
}

.cm-s-typora-default  .cm-em {
  font-family: Georgia-Italic, STSongti-SC-Light, serif;
  color: #f3ff7e;
}

.typora-sourceview-on .CodeMirror-cursor {
  border-left: 3px solid #ffffd6;
}

.typora-sourceview-on #toggle-sourceview-btn {
  background: #505050;
}

.typora-sourceview-on .cm-s-inner .cm-variable,
.typora-sourceview-on .cm-s-inner .cm-operator,
.typora-sourceview-on .cm-s-inner .cm-property {
    color: #b8bfc6;
}

.typora-sourceview-on .cm-s-inner .cm-keyword {
    color: #C88FD0;
}

.typora-sourceview-on .cm-s-inner .cm-tag {
    color: #7DF46A;
}

.typora-sourceview-on .cm-s-inner .cm-attribute {
    color: #7575E4;
}

.typora-sourceview-on .cm-s-inner .cm-string {
    color: #D26B6B;
}

.typora-sourceview-on .cm-s-inner .cm-comment,
.typora-sourceview-on .cm-s-inner.cm-comment {
    color: #DA924A;
}

.typora-sourceview-on .cm-s-inner .cm-header,
.typora-sourceview-on .cm-s-inner .cm-def,
.typora-sourceview-on .cm-s-inner.cm-header,
.typora-sourceview-on .cm-s-inner.cm-def {
    color: #8d8df0;
}

.typora-sourceview-on .cm-s-inner .cm-quote,
.typora-sourceview-on .cm-s-inner.cm-quote {
    color: #57ac57;
}

.typora-sourceview-on .cm-s-inner .cm-hr {
    color: #d8d5d5;
}

.typora-sourceview-on .cm-s-inner .cm-link {
    color: #d3d3ef;
}

.typora-sourceview-on .cm-s-inner .cm-negative {
    color: #d95050;
}

.typora-sourceview-on .cm-s-inner .cm-positive {
    color: #50e650;
}

.typora-sourceview-on .cm-s-inner .cm-string-2 {
    color: #f50;
}

.typora-sourceview-on .cm-s-inner .cm-meta,
.typora-sourceview-on .cm-s-inner .cm-qualifier {
    color: #b7b3b3;
}

.typora-sourceview-on .cm-s-inner .cm-builtin {
    color: #f3b3f8;
}

.typora-sourceview-on .cm-s-inner .cm-bracket {
    color: #997;
}

.typora-sourceview-on .cm-s-inner .cm-atom,
.typora-sourceview-on .cm-s-inner.cm-atom {
    color: #84B6CB;
}

.typora-sourceview-on .cm-s-inner .cm-number {
    color: #64AB8F;
}

.typora-sourceview-on .cm-s-inner .cm-variable {
    color: #b8bfc6;
}

.typora-sourceview-on .cm-s-inner .cm-variable-2 {
    color: #9FBAD5;
}

.typora-sourceview-on .cm-s-inner .cm-variable-3 {
    color: #1cc685;
}

.typora-sourceview-on .CodeMirror div.CodeMirror-cursor {
    border-left: 1px solid #b8bfc6;
    z-index: 3;
}

.cm-s-typora-default .CodeMirror-selectedtext,
.typora-sourceview-on .CodeMirror-focused .CodeMirror-selected {
  background: #212324;
}

.typora-sourceview-on .CodeMirror-linenumber {
    color: rgb(255, 255, 255);
}*/

EOF

echo
echo "done!"
