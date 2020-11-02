" vim: ft=vim
let home = $HOME
let shell = $SHELL
let nvim_home = home . '/.config/nvim'
let asdf_home = home . '/.asdf'
let asdf_installs = home . '/.asdf/installs'

" - scripting paths
let g:node_host_prog = asdf_home . '/shims/node'
let g:node_host_prod = asdf_home . '/shims/node'
let g:python_host_prog = asdf_home . '/shims/python2'
let g:python3_host_prog = asdf_home . '/shims/python3'

" - truecolor
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

" - rplug
let $NVIM_RPLUGIN_MANIFEST = nvim_home . '/rplugin.nvim'

" - automated vimplug install
let vimplug_store  = nvim_home . '/incoming'
let vimplug_conf   = nvim_home . '/incoming/plug.vim'
let vimplug_url    = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

if empty(glob(vimplug_conf))
  silent exe '!curl -fLo' vimplug_conf '--create-dirs' vimplug_url
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

runtime incoming/plug.vim


" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "

" - plugins
call plug#begin(vimplug_store)
  Plug 'godlygeek/tabular'                               " required by vim-markdown
  Plug 'ryanoasis/vim-devicons'                          " required by nerdtree

  Plug 'neoclide/jsonc.vim'
  "Plug 'sheerun/vim-polyglot'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'zinit-zsh/zinit-vim-syntax'

  Plug 'plasticboy/vim-markdown'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

  Plug 'Yggdroot/indentLine'

  Plug 'dracula/vim'
  Plug 'overcache/NeoSolarized'
  Plug 'lifepillar/vim-gruvbox8'
  Plug 'sainnhe/gruvbox-material'
  Plug 'kaicataldo/material.vim', { 'branch': 'main' }

  Plug 'edkolev/tmuxline.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'tpope/vim-rhubarb'                                      " gh plugin for fugitive
  Plug 'tpope/vim-fugitive'                                     " git helpers
  Plug 'mhinz/vim-signify'                                      " show git differences

  Plug 'SirVer/ultisnips'                                       " snippets
  Plug 'honza/vim-snippets'                                     " snippets

  Plug 'mattn/vim-gist'
  Plug 'mattn/webapi-vim'

  Plug 'scrooloose/nerdtree'                                    " file browser
  Plug 'liuchengxu/vista.vim'                                   " tag helper
  Plug 'Shougo/deoplete.nvim'                                   " completion
  Plug 'voldikss/vim-floaterm'                                  " floating terminal
  Plug 'preservim/nerdcommenter'                                " line commenting
  Plug 'MattesGroeger/vim-bookmarks'                            " bookmarks
  Plug 'christoomey/vim-tmux-navigator'                         " seamless vim+tmux

  Plug 'mattn/msgpack-vim'
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'voldikss/fzf-floaterm'
call plug#end()



" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "
let mapleader = ","
let g:mapleader = ","

nmap <leader>L :IndentLinesToggle<CR>
nmap <leader>l :set list!<CR>
nmap <leader>ve :tabnew $HOME/.config/nvim/init.vim<CR>
nmap <leader>vr :source $MYVIMRC<CR>:PlugClean<CR>:PlugInstall<CR>:q<CR>:source $MYVIMRC<CR>

" <space> 🚀
nnoremap <silent> <space>b :Buffers<CR>
nnoremap <silent> <space>c :Commands<CR>
nnoremap <silent> <space>d :FloatermNew lazydocker<CR>
nnoremap <silent> <space>e :NERDTreeToggle<CR>
nnoremap <silent> <space>f :Files<CR>
nnoremap <silent> <space>ft :Filetypes<CR>
nnoremap <silent> <space>F :NERDTreeFind<CR>
nnoremap <silent> <space>g :FloatermNew lazygit<CR>
nnoremap <silent> <space>m :Maps<CR>
nnoremap <silent> <space>rg :Rg<CR>
nnoremap <silent> <space>rgw :Rg <C-R><C-W><CR>
nnoremap <silent> <space>s :Snippets<CR>
nnoremap <silent> <space>t :Vista!!<CR>

" <leader>/ - Claer highlighted search terms while preserving history
nmap <silent> <space>/ :nohlsearch<CR>

" <c-g> - toggle a floating terminal
nnoremap <silent> <c-g> :FloatermToggle<CR>
tnoremap <silent> <c-g> <c-\><c-n>:FloatermHide<CR>

" <leader>b64e - base64 encode the selected text
" <leader>b64e - base64 dencode the sdelected text
vmap <silent> <leader>b64e <leader>btoa<CR>
vmap <silent> <leader>b64d <leader>atob<CR>

" <leader>cc - comment or uncomment the selected lines
nmap <leader>cc <plug>NERDCommenterInvert
xmap <leader>cc <plug>NERDCommenterInvert

" -- markdown only
autocmd FileType markdown nnoremap <leader>ft :TableFormat<CR>
autocmd FileType markdown nnoremap <c-/> :MarkdownPreview<CR>



" ============================================================================ "
" ===                           PLUGIN CONFIGURATION                       === "
" ============================================================================ "


" - theme
"let g:material_theme_style = "palenight"
"let g:material_terminal_italics = 1
colorscheme gruvbox-material


" - deoplete.
let g:deoplete#enable_at_startup = 1
" -- tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" - indentLine
let g:indentLine_char = '│'

" - ultisnips
let g:UltiSnipsExpandTrigger="<C-s>"
let g:UltiSnipsJumpForwardTrigger="<C-n>"
let g:UltiSnipsJumpBackwardTrigger="<C-p>"

" - markdown
let g:vim_markdown_conceal = 0

" - fzf
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"
let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git,node_modules,vendor}/*"'
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" fzf for all vim runtime files
command! VimRuntime call fzf#run(fzf#wrap({
  \ 'source': split(substitute(execute('scriptnames'), ' *\d*: ', '', 'g'), "\n"),
  \ 'options': ['--prompt', 'Vim> ', '--nth=2'],
  \ }))

" - vista
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" - nerdtree
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeDirArrowExpandable = '⬏'
let g:NERDTreeDirArrowCollapsible = '⬎'
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']

" - floaterm
let s:float_term_win = 1
let g:floaterm_autoclose=1
let g:floaterm_width = 0.9
let g:floaterm_autoinsert=1
let g:floaterm_height = 0.9
let s:float_term_border_win = 1

" - nerdcomment
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDCreateDefaultMappings = 0

" - airline
let g:airline_powerline_fonts = 1
let g:airline_section_b = '%{getcwd()}' " in section B of the status line display the CWD
" -- tabline
let g:airline#extensions#tabline#enabled = 1           " enable airline tabline
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right
let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline
let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline
let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline



" ============================================================================ "
" ===                              OPTIONS                                 === "
" ============================================================================ "

" - options
set hidden                                          " don't unload buffer when it is YXXYabandon
set ruler
set number                                          " show line and cursor number at position
set mouse=a                                         " enable mouse suppose by default
set nobackup                                        " keep backup file after overwriting a file
set autoread                                        " autoread files when changes are detected on disk
set hlsearch
set showmatch
set incsearch
set showmatch                                       " briefly jump to matching bracket if jinsert one
set expandtab                                       " use spaces when <Tab> is inserted
set tabstop:2                                       " number of spaces that <Tab> in file uses
set noswapfile                                      " whether to use a swapfile for a buffer
set cmdheight=2                                     " Give more space for displaying messages.
set shortmess+=c                                    " Don't pass messages to ins-completion-menu
set shiftwidth=2                                    " number of spaces to use for (auto)indent step
set termguicolors
set nowritebackup
set viminfo='1000
set updatetime=300                                  " longer leads to noticable delays
set encoding=utf-8
set signcolumn=yes
set background=dark
set termencoding=utf-8
set wildmode=list:longest                           " set wildmode=list:longest
set fillchars+=stl:\ ,stlnc:\                       " automatically detected values for 'fileformat'
set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵,space:·   " characters for displaying in list mode
set conceallevel=0



"
"============================================================================ "
" ===                             AUTOMATION                               === "
" ============================================================================ "
" - automation
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif    " return to last edit position when opening files
au BufWritePre * :%s/\s\+$//e " Remove trailing spaces when saving a file "                     " remove trailing whitespace on save

