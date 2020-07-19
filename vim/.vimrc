" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Insert a single character with space in normal mode
:nnoremap <Space> i_<Esc>r
