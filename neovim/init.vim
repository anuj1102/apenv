"=============================================================================
"------------------------------Default Packages-------------------------------
"=============================================================================
"
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.local/share/nvim/plugged')

" Theme
Plug 'mhartington/oceanic-next'

" Typing
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'

" Layout & Terminal
Plug 'bling/vim-airline'
Plug 'Raimondi/delimitMate'
Plug 'mklabs/split-term.vim'
Plug 'kassio/neoterm'

" Coding tools
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/BufOnly.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-scripts/bufkill.vim'
Plug 'mtahmed/click.vim'
Plug 'janko-m/vim-test'

"Snippets
"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
" Plug 'fishbullet/deoplete-ruby'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/neosnippet-snippets'
" Plug 'Shougo/neosnippet.vim'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

call plug#end()

"=============================================================================
" --------------------------Basic Configuration-------------------------------
"=============================================================================
"
" ------------------------ Local vim configs --------------------------------
function! SourceIfExists(file)
  if filereadable(expand(a:file))
  	exe 'source' a:file
  endif
endfunction

" Local neovim configs
call SourceIfExists("~/.config/nvim/local.vim")
call SourceIfExists("~/.config/nvim/coc.vim")
call SourceIfExists("~/.config/nvim/ccls.vim")

" Prevent ultisnips from overriding coc tab mapping
let g:UltiSnipsExpandTrigger = "<nop>"


set mouse=a
set tabstop=2
set softtabstop=0 noexpandtab
set shiftwidth=2
set autoindent
set smartindent
set splitright
set clipboard+=unnamed
set number
set relativenumber
set hidden " Allows buffers to be hidden if modifies
set shell=/bin/zsh " Set default shell


"Highlight 80th column
set cc=80

"Learn VIM correctly
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

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

"Buffers
function! QuitBuffer()
	if &buftype == 'terminal'
		:BD!
	else
		:bdelete
	endif
endfunction

nnoremap <Leader>q :call QuitBuffer()<CR>

"Show all open buffers and their status
nmap <Leader>p :Buffers<CR>
nnoremap <Leader>] :bnext<CR>
nnoremap <Leader>[ :bprevious<CR>
nnoremap <Leader>w :close<CR>

"Tabs
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt

"Terminal
"http://vimcasts.org/episodes/neovim-terminal-mappings/
tnoremap <Esc> <C-\><C-n>
tnoremap <A-[> <Esc>
"Auto start in insert mode
au TermOpen * setlocal listchars= nonumber norelativenumber
au TermOpen * startinsert
au BufEnter,BufWinEnter,WinEnter term://* startinsert

"Terminal Splits
nnoremap <Leader>d :vsplit<CR>
nnoremap <Leader>D :VTerm<CR>
nnoremap <Leader>T :terminal<CR>

"Neoterm
let g:neoterm_default_mod='vertical'
nnoremap <silent> <leader>C :Tnew<CR>

" Neoterm run last command, https://github.com/kassio/neoterm/issues/210
nnoremap <silent> <leader>c :<c-u>exec printf("%sTexec !! \<lt>cr>", v:count)<cr>

" SSH copy paste work around
" Write the default yank register to a file so we can pull it locally
" To do make this use $HOME
nnoremap Y :call writefile(getreg('"', 1, 1), "/home/anujp/.remote_copy")<cr>

" Copy filename shortcuts
nnor yf :let @"=expand("%:p")<CR>
" Copy filename to clipboard
nmap <Leader>P :let @" = expand("%:p")<CR>


" --------------------mhartington/oceanic-next(Theme) ------------------------
" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Or if you have Neovim >= 0aj.1.5
if (has("termguicolors"))
  set termguicolors
endif

syntax enable
syntax on
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
let g:airline_theme='oceanicnext'
colorscheme OceanicNext

" ---------------------- bling/vim-airline -----------------------------------
" http://www.blog.bdauria.com/?p=609
let g:airline#extensions#tabline#enabled = 1
"enable/disable displaying open splits per tab (only when tabs are opened). >
let g:airline#extensions#tabline#show_splits = 1
 " enable/disable displaying buffers with a single tab
let g:airline#extensions#tabline#show_buffers = 1
 " tab number
let g:airline#extensions#tabline#show_tabs = 0 "Prefer showing buffers
" Remove term:// from the default ignore list
let g:airline#extensions#tabline#ignore_bufadd_pat = '!|defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

"ale
let g:airline#extensions#ale#enabled = 1
" let g:ale_ruby_rubocop_executable = 'bundle'

"=============================================================================
" -------------------------- Advanced Configuration---------------------------
"=============================================================================
"

" ---------------------------- junegunn/fzf ----------------------------------
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

command! -bang -nargs=* OldRg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:40%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

let g:fzf_layout = { 'up': '~40%' }
nmap <Leader>o :GFiles<CR>/
nmap <Leader>f :RG<CR>

" Rspec
let test#strategy = "neoterm"
let test#ruby#rspec#options = "-fd"
let test#ruby#rspec#executable = 'bundle exec script/zeus test'
nnoremap <Leader>r :TestNearest<CR>
"******************************************************************************
