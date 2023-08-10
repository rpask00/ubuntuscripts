" VIM Configuration Profile

" Use the PowerLine plugin. Change Python directory if needed.
set rtp+=$HOME/.local/lib/python3.8/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Always show the command as it is being typed.
set showcmd



" używaj systemowegi schowka zamiast vimowych rejestrów
set clipboard=unnamed

" włącz otaczanie
" set surround


" wrzuca kasowany tekst do black hole clipboard
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

" sprawia że te komendy z <leader> działają jak cut"
nnoremap <leader>d "+d
nnoremap <leader>D "+D
vnoremap <leader>d "+d


" relative numbers
:set relativenumber
:set number

:nnoremap j h
:nnoremap k j
:nnoremap l k
:nnoremap ; l
:nnoremap h ;

:vnoremap j h
:vnoremap k j
:vnoremap l k
:vnoremap ; l
:vnoremap h ;

nnoremap <silent><Leader>n :RangerOpenCurrentFile<CR>
nnoremap <silent><Leader>c :RangerOpenCurrentDir<CR>
nnoremap <silent><Leader>f :RangerOpenProjectRootDir<CR>

