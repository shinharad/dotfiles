
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





" =========================================================================
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


" =========================================================================
" NeoBundle 
set nocompatible
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'scrooloose/nerdtree'

call neobundle#end()
filetype plugin indent on

NeoBundleCheck

