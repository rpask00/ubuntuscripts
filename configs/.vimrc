"" Source your .vimrc
"source ~/.vimrc

"" -- Suggested options --
" Show a few lines of context around the cursor. Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching.
set incsearch

" Don't use Ex mode, use Q for formatting.
map Q gq


"" -- Map IDE actions to IdeaVim -- https://jb.gg/abva4t
"" Map \r to the Reformat Code action
"map \r <Action>(ReformatCode)

"" Map <leader>d to start debug
"map <leader>d <Action>(Debug)

"" Map \b to toggle the breakpoint on the current line
"map \b <Action>(ToggleLineBreakpoint)


" Find more examples here: https://jb.gg/share-ideavimrc


" używaj systemowegi schowka zamiast vimowych rejestrów
set clipboard=unnamed

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

