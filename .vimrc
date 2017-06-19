" 挙動を vi 互換ではなく、Vim のデフォルト設定にする
set nocompatible
" 一旦ファイルタイプ関連を無効化する
filetype off

""""""""""""""""""""""""""""""
" プラグインのセットアップ
""""""""""""""""""""""""""""""
" dein.vim
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " ファイルをtree表示
  call dein#add('scrooloose/nerdtree')
  "  Ctrl+nで複数選択
  call dein#add('terryma/vim-multiple-cursors')
  " テーマ
  call dein#add('tomasr/molokai')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif



" =========================================================================
" バックアップファイルを作成しない
set nobackup
" スワップファイルを作成しない
set noswapfile
" Undoファイルを作成しない
set noundofile
" バッファが編集中でもその他のファイルを開けるようにする
set hidden


" =========================================================================
" 文字コード関連
" 文字コードの自動解釈の優先順位
set fileencodings=utf-8,cp932,euc-jp
" 改行コードの解釈優先順位
set fileformats=unix,dos
" 内部の解釈の文字コード　設定ファイルもこのコードで書け
set encoding=utf-8
" 内部の改行コード
set fileformat=unix


" =========================================================================
" 操作系
" 折り返し時に表示行単位で移動できるようにする
nnoremap j gj
nnoremap k gk
" 削除でレジスタに格納しない
nnoremap x "_x
nnoremap dd "_dd

" 循環検索をOFF
set nowrapscan
" ヤンクしたテキストをそのままクリップボードにコピー
set clipboard+=unnamed,unnamedplus
" バッファをキーで移動
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
" 自動的にインデントする
set autoindent

" =========================================================================
" 検索系
" インクリメンタルサーチ
set incsearch
" ESC連打でハイライト解除
nmap <ESC><ESC> :nohlsearch<CR><ESC>


" =========================================================================
" 見た目
" 行番号表示
set number
" 現在行を強調表示
set cursorline
" Tab文字の表示幅
set tabstop=2
" 対応括弧の瞬間強調時間
set matchtime=3
" タブを空白で入力する
set expandtab
" カラーテーマ
colorscheme molokai

" ステータスエリア関係
"ステータスのところにファイル情報表示
set statusline=%<[%n]%F%=\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ %l,%c\ %P

" ルーラーを表示
" set ruler
" set title


"""""""""""""""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
"""""""""""""""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""

" =========================================================================
" :NERDTreeのショートカット（Ctrl+e）
nnoremap <silent><C-e> :NERDTree<CR> 
" 隠しファイルをデフォルトで表示
let NERDTreeShowHidden = 1

