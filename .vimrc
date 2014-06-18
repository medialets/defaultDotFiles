set showmatch
set nocompatible backspace=indent,eol,start ts=4 textwidth=0 backupcopy=yes history=500 ruler so=5 cmdheight=2 hh=20 wh=65 hlsearch ic nofoldenable t_Co=256 t_Sf=m t_Sb=m bg=dark showcmd incsearch nocindent nosmartindent

syntax on
let use_xhtml = 1
let html_use_css = 1

if has("autocmd")
  if has("filetype")
    filetype on
    filetype plugin on
    ;filetype indent on
    set fileformats=unix,dos,mac
  endif

  au BufRead,BufNewFile * setfiletype sh
  autocmd FileType html set isk+=:,/,~
  autocmd FileType *             set shiftwidth=4
  autocmd FileType xml,html      set shiftwidth=2
  autocmd FileType java,c,cc,cpp set nocindent
  autocmd FileType text setlocal textwidth=78    " For all text files set 'textwidth' to 78 characters.

  augroup ApacheModule
    au BufRead,BufNewFile httpd*.conf*,srm.conf*,access.conf*,apache.conf*,apache2.conf*,.htaccess,.htpasswd setfiletype apache
    autocmd BufReadPost mod_*.c set ts=4
    autocmd BufReadPost mod_*.c set sw=4
  augroup END

  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  augroup END
endif

if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
if filereadable("/etc/vimrc")
  source /etc/vimrc
endif
inoremap <S-Insert> <ESC>"+p`]a
imap <D-V> ^O"+p
