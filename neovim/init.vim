if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'mhartington/oceanic-next'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'Raimondi/delimitMate'
Plug 'mklabs/split-term.vim'
Plug 'kassio/neoterm'
Plug 'rust-lang/rust.vim'
Plug 'fishbullet/deoplete-ruby'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/BufOnly.vim'
Plug 'brettanomyces/nvim-terminus'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-scripts/bufkill.vim'
Plug 'mtahmed/click.vim'
Plug 'janko-m/vim-test'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()

"https://github.com/mhartington/oceanic-next
" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
  set termguicolors
endif

"Basics
set mouse=a
set tabstop=2
set softtabstop=0 noexpandtab
set shiftwidth=2
set autoindent
set smartindent
set splitright

" Copy paste
set clipboard+=unnamed
set number
set relativenumber

" Highlight 80
set cc=80

"Learn VIM correctly
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Write the default yank register to a file so we can pull it locally
" To do make this use $HOME
nnoremap Y :call writefile(getreg('"', 1, 1), "/home/anujp/.remote_copy")<cr>

"Set leader key to space
nnoremap <SPACE> <nop>
let mapleader=" "
set notimeout

nnoremap <Leader>l <c-w>l
nnoremap <Leader>h <c-w>h
nnoremap <Leader>j <c-w>j
nnoremap <Leader>k <c-w>k

vnoremap <Leader>l <c-w>l
vnoremap <Leader>h <c-w>h
vnoremap <Leader>j <c-w>j
vnoremap <Leader>k <c-w>k
"Tabs
" nnoremap <Leader>t :tabnew<CR>
" nnoremap <Leader>w :q<CR>
" nnoremap <Leader>q :q<CR> Seems to work without mapping
" nnoremap <Leader>] gt
" nnoremap <Leader>[ gT

nnoremap <Leader>d :vsplit<CR>
nnoremap <Leader>D :VTerm<CR>
nnoremap <Leader>T :terminal<CR>
nnoremap <Leader>w :close<CR>

nnoremap <Leader>= :VTerm<cr>
nnoremap <Leader>- :Term<cr>

nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt

" Theme
syntax enable
syntax on
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
let g:airline_theme='oceanicnext'
colorscheme OceanicNext

" Autocomplete
" let g:python3_host_prog = '/Users/anuj/.pyenv/versions/neovim3/bin/python'
" let g:python_host_prog = '/Users/anuj/.pyenv/versions/neovim2/bin/python'

" Function to source only if file exists {
function! SourceIfExists(file)
	if filereadable(expand(a:file))
		exe 'source' a:file
	endif
endfunction

"Syntastic cpp
" let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

"Auto chdir, NOT sure why I needed this
" autocmd BufEnter * silent! lcd %:p:h

"Fzf
let g:fzf_layout = { 'up': '~40%' }
" nmap <Leader>o :GFiles<CR>
nmap <Leader>o :GFiles<CR>/
" nmap <Leader>s :Tags<CR>
nmap <Leader>f :Ag<CR>

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
			\   <bang>0 ? fzf#vim#with_preview('up:40%')
			\           : fzf#vim#with_preview('right:50%:hidden', '?'),
			\   <bang>0)
" Search in current dir
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

"Don't need this
" nnoremap <leader>d :call fzf#vim#tags(expand('<cword>'), {'options': '--exact --select-1 --exit-0'})<CR>

" Do I need this?
function! s:my_fzf_handler(lines) abort
	if empty(a:lines)
		return
	endif
	let cmd = get({ 'ctrl-t': 'tabedit',
				\ 'ctrl-x': 'split',
				\ 'ctrl-v': 'vsplit' }, remove(a:lines, 0), 'e')
	for item in a:lines
		execute cmd escape(item, ' %#\')
	endfor
endfunction

" http://vimcasts.org/episodes/neovim-terminal-mappings/
tnoremap <Esc> <C-\><C-n>
tnoremap <A-[> <Esc>
"Auto start in insert mode
au TermOpen * setlocal listchars= nonumber norelativenumber
au TermOpen * startinsert
au BufEnter,BufWinEnter,WinEnter term://* startinsert

"NerdTree
nnoremap <Leader>N :NERDTreeToggle<CR>

" Local neovim configs
call SourceIfExists("~/.config/nvim/local.vim")

"Buffers
" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden


" Move to the next buffer
nnoremap <Leader>] :bnext<CR>
nnoremap <Leader>[ :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
function! QuitBuffer()
	if &buftype == 'terminal'
		:BD!
	else
		:BD
	endif
endfunction
"adfix"
nnoremap <Leader>q :call QuitBuffer()<CR>

" Show all open buffers and their status
nmap <Leader>p :Buffers<CR>

" Copy filename
nnor yf :let @"=expand("%:p")<CR>    " Mnemonic: Yank File path

" http://www.blog.bdauria.com/?p=609
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1 "enable/disable displaying open splits per tab (only when tabs are opened). >
let g:airline#extensions#tabline#show_buffers = 1 " enable/disable displaying buffers with a single tab
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

"Ale
let g:airline#extensions#ale#enabled = 1
"Necessary to parse compile commands
let g:ale_c_parse_compile_commands = 1

"Tags
nnoremap <Leader>' <c-]>
nnoremap <Leader>; <c-t>

"deoplete
let g:deoplete#enable_at_startup = 1


" https://github.com/cquery-project/cquery/wiki/Neovim
" c++ language server
let g:LanguageClient_serverCommands = {
    \ 'cpp': ['cquery', '~/.log/cquery/cq.log'],
    \ 'c': ['cquery', '~/.log/cquery/cq.log'],
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ }

let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> gS :call LanguageClient_workspace_symbol({'query':input('workspace/symbol ')})<cr>

nnoremap <silent> gR :call LanguageClient#textDocument_rename()<CR>
augroup LanguageClient_config
  au!
  au BufEnter * let b:Plugin_LanguageClient_started = 0
  au User LanguageClientStarted setl signcolumn=yes
  au User LanguageClientStarted let b:Plugin_LanguageClient_started = 1
  au User LanguageClientStopped setl signcolumn=auto
  au User LanguageClientStopped let b:Plugin_LanguageClient_stopped = 0
  au CursorMoved * if b:Plugin_LanguageClient_started | call LanguageClient_textDocument_hover() | endif
augroup END



" Rspec
let test#strategy = "neoterm"
let test#ruby#rspec#options = "-fd"
let test#ruby#rspec#executable = 'bundle exec script/zeus test'
nnoremap <Leader>r :TestNearest<CR>

" Neoterm run last command, https://github.com/kassio/neoterm/issues/210
nnoremap <silent> <leader>c :<c-u>exec printf("%sTexec !! \<lt>cr>", v:count)<cr>

"Neosnippet
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <S-Tab>  <Plug>(neosnippet_expand_or_jump)
smap <S-Tab>  <Plug>(neosnippet_expand_or_jump)
xmap <S-Tab>  <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:deoplete#auto_complete_delay = 0
let g:auto_refresh_delay = 0

" Copy filename to clipboard
nmap <Leader>P :let @" = expand("%:p")<CR>

" Set default shell
set shell=/bin/zsh
