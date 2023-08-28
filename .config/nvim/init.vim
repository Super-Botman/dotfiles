" load theme
lua require('theme')

" load packer
lua require('plugins')

" load file manager
lua require('file-manager')

" install plugins with vim-plug
call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
  Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
  Plug 'elkowar/yuck.vim'
call plug#end()

" config
set number relativenumber
augroup COQ 
        autocmd!
        autocmd VimEnter * COQnow -s
augroup END

" keybind
nnoremap <C-t> :NvimTreeToggle<CR>
nnoremap <C-n> :tabnew<CR>
nnoremap <Tab> :tabNext<CR>
nnoremap <C-x> :tabclose<CR>
