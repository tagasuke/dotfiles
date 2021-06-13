filetype off                   " required!

"==========================
"init
"==========================
autocmd!
set nocompatible
set modelines=5

"==========================
"Tab Char
"==========================
set tabstop=4
set expandtab
set softtabstop=0
set shiftwidth=4
set smarttab


"==========================
"Tab Pages
"==========================
nnoremap <C-t>  <Nop>
nnoremap <C-t>n  :<C-u>tabnew<CR>
nnoremap <C-t>c  :<C-u>tabclose<CR>
nnoremap <C-t>o  :<C-u>tabonly<CR>
nnoremap <C-t>j  :<C-u>execute 'tabnext' 1 + (tabpagenr() + v:count1 - 1) % tabpagenr('$')<CR>
nnoremap <C-t>k  gT

"==========================
"tags-and-searches
"==========================
nnoremap t  <Nop>
nnoremap tt  <C-]>
nnoremap tj  :<C-u>tag<CR>
nnoremap tk  :<C-u>pop<CR>
nnoremap tl  :<C-u>tags<CR>

"==========================
"view
"==========================
colorscheme molokai
"行番号表示
set number
"タイトルを表示
set title
"画面の端から5行目でスクロール
set scrolloff=5

"現在の行を強調表示
if v:version >= 700
    set cursorline
    highlight CursorLine guibg=lightblue ctermbg=lightgray
endif

set cmdheight=2


"==========================
"Searching and Moving
"==========================
"メタ文字を\で前置きせずに使えるようにする
nnoremap / /\v
vnoremap / /\v
"大文字小文字区別せず検索
set ignorecase
"検索文字列に大文字が含まれていれば区別して検索
set smartcase
set gdefault    " %s/hoge/foo/gを%s/hoge/foo/でできる。常にglobal。
"検索文字列を順次ヒットさせる
set incsearch
"対応する括弧にカーソルが飛ぶ
set showmatch
"検索結果をハイライト表示
set hlsearch
"検索文字列が最後まで行ったら最初に戻る
set wrapscan
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
"検索状態からすぐ抜ける
nnoremap <leader><space> :noh<cr>

"%の移動をtabでも可能に。
nnoremap <tab> %
vnoremap <tab> %

"検索パターン入力中は/および?をエスケープ
"そのまま入力するには<C-v>{/?}で
cnoremap <expr> /
            \ getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ?
            \ getcmdtype() == '?' ? '\?' : '?'

"==========================
"Handling long lines
"==========================
set wrap

set formatoptions=qrn1

"==========================
"Key Bind
"==========================
"vimrcをリローダブルにする
noremap <C-c><C-c> <C-c>
noremap <C-c><C-e>e :edit $HOME/.vimrc<CR>
noremap <C-c><C-e>s :source $HOME/.vimrc<CR>

" 表示行単位で上下移動
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" 検索箇所を真ん中に
noremap n nzz
noremap N Nzz
noremap * *zz
noremap # #zz
noremap g* g*zz
noremap g# g#zz

"leaderを,に変更
let mapleader = ","

"F1もESCにする
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

"ノーマルモードではセミコロンをコロンに。
nnoremap ; :

"フォーカスを失ったら自動的に上書き。
au FocusLost * :wa

"insertモードでjj押せばノーマルモードに。
inoremap jj <ESC>

",wで水平分割→アクティブに
nnoremap <leader>w <C-w>v<C-w>l

"F2でpasteモードに。pasteするときにインデントを無効化。
set pastetoggle=<F2>

"splitの移動を簡単に。ctrl押しながらhjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"Enterでいつでも一行挿入
map <S-Enter> O<ESC>
map <Enter> o<ESC>

" マークアップのための上線や下線を作成する
" Inspired by http://sphinx.pocoo.org/rest.html#sections
"================================
nnoremap <leader>1 yyPVr=jyypVr=
"********************************
nnoremap <leader>2 yyPVr*jyypVr*
"--------------------------------
nnoremap <leader>3 yyPVr-jyypVr-
nnoremap <leader>4 yypVr=
nnoremap <leader>5 yypVr-
nnoremap <leader>6 yypVr^
nnoremap <leader>7 yypVr"

"registerとmarkの確認を楽にする
"http://whileimautomaton.net/2008/08/vimworkshop3-kana-presentation
nnoremap <Space>m :<C-u>marks
nnoremap <Space>r :<C-u>registers

" マウス操作の有効化 & ホイール操作の有効化
set mouse=a
set ttymouse=xterm2

"大文字Yで行末までヤンク
nnoremap Y y$


"==========================
"language
"==========================

"UTF-8化
set encoding=utf-8

if has('win32') && has('kaoriya')
    set   ambiwidth=auto
else
    set   ambiwidth=double
endif

if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'

    if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213,euc-jp'
        let s:enc_jis = 'iso-2022-jp-3'
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif

    if &encoding ==# 'utf-8'
        let s:fileencodings_default = &fileencodings
        let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
        let &fileencodings = &fileencodings .','. s:fileencodings_default
        unlet s:fileencodings_default

               else
        let &fileencodings = &fileencodings .','. s:enc_jis
        set fileencodings+=utf-8,ucs-2le,ucs-2
        if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
            set fileencodings+=cp932
            set fileencodings-=euc-jp
            set fileencodings-=euc-jisx0213
            set fileencodings-=eucjp-ms
            let &encoding = s:enc_euc
            let &fileencoding = s:
        else
            let &fileencodings = &fileencodings .','. s:enc_euc
        endif
    endif

    unlet s:enc_euc
    unlet s:enc_jis
endif

"autocmdがかかっている場合、エンコーディングをチェックする。
"iso-2022-jpで、文字化けしてたら、ファイルエンコーディングを指定したエンコーディング形式に切り替える
if has('autocmd')
    function! AU_ReCheck_FENC()
        if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
            let &fileencoding=&encoding
        endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
endif


" if has('win32unix')
    " set   termencoding=cp932
" elseif !has('macunix')
    " set   termencoding=euc-jp
" endif

set fileformats=unix,dos,mac

"ambiwidthがある場合、doubleに設定
if exists('&ambiwidth')
    set ambiwidth=double
endif

"==========================
"Folding
"==========================
" Folding rules {{{
set foldenable                  " enable folding
set foldcolumn=2                " add a fold column
set foldmethod=marker           " detect triple-{ style fold markers
set foldlevelstart=0            " start out with everything folded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()

" ******************************
"            Leader
" ******************************
" white spaceをtrailする
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" Ackへのショートカット
nnoremap <leader>a :Ack
" htmlで良く使う。タグに囲まれたものを一気に選択。
nnoremap <leader>ft Vatzf
" CSSプロパティを並べ替え
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
" TextMateの<Ctrl-Q>。ワンライナーに書き換え。
nnoremap <leader>q gqip
" 直前に貼り付けたコードを再選択。インデントとか入れるときに便利。
nnoremap <leader>v V`]


"==========================
"clipboard
"==========================
set clipboard+=autoselect


"==========================
"special Key
"==========================
set list
set listchars=tab:>-,trail:-,extends:<,precedes:<
highlight specialKey ctermfg=darkgray


"==========================
"Input
"==========================
set backspace=indent,eol,start
set formatoptions+=mM
set autoindent
"smartindentの設定
set smartindent

"==========================
"Command
"==========================
set wildmenu
set wildmode=full:list
"set completeopt=menu,preview,menuone

"==========================
"Programming
"==========================
set showmatch "対応する括弧を表示
"set cindent "Cのインデント
set foldmethod=syntax
set grepprg=internal "内蔵grep

"==========================
"Backup
"==========================
set autowrite
set hidden
"スワップファイルを作らない
set noswapfile
"バックアップファイルを作らない
set nobackup
set directory=$HOME/.vimtmp
set history=10000
set updatetime=500
"set viminfo=""
let g:svbfre = '.\+'
"autocmd CursorHold * call NewUpdate()

"==========================
"Status Line
"==========================
set showcmd "ステータスラインにコマンドを表示
"ステータスラインの有効化&2行表示
set laststatus=2
" ステータスラインのテーマ設定
let g:lightline = { 'colorscheme': 'molokai' }
"ステータスラインの表示内容
set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L


"==========================
"Window
"==========================
set splitright "Window Split時に新Windowを右に表示
set splitbelow "Window Split時に新windowを下に表示

"==========================
"Dictionary
"==========================
set dictionary=/usr/share/dict/words
autocmd FileType php :set dictionary=~/.dictionary/phpdoc

"==========================
"File Type
"==========================
"シンタックスハイライトの有効化
syntax on
au FileType perl call PerlType()
"" ファイルタイプに応じてテンプレートを自動読み込み
autocmd BufNewFile * silent! 0r $HOME/.vim/templates/%:e.tpl
" バッファを開いた時に、カレントディレクトリを自動で移動
" autocmd BufEnter * execute ":lcd " . expand("%:p:h")



"行末まで移動可能
set virtualedit=onemore

" ---------------------------
"python
" ---------------------------
if has('autocmd')
    autocmd FileType python setl autoindent
    autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
    autocmd FileType python setl tabstop=4 expandtab shiftwidth=4 softtabstop=4
endif

" Execute python script C-P
function! s:ExecPy()
    exe "!" . &ft . " %"
:endfunction
command! Exec call <SID>ExecPy()
autocmd FileType python map <silent> <C-P> :call <SID>ExecPy()<CR>

" ----
" html
" ----
if has('autocmd')
    autocmd FileType html :compiler tidy
    autocmd FileType html :setlocal makeprg=tidy\ -raw\ -quiet\ -errors\ --gnu-emacs\ yes\ \"%\"
endif

" ---
" css
" ---
if has('autocmd')
    autocmd FileType css :compiler css
endif

"==========================
"help
"==========================
set helplang=ja,en "日本語のヘルプｰ>英語のヘルプの順に検索
