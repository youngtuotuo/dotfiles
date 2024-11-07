mkdir -p $HOME/.vim/pack/plug/start
cd $HOME/.vim/pack/plug/start
git clone --depth 1 https://github.com/tpope/vim-fugitive &
git clone --depth 1 https://github.com/tpope/vim-vinegar &
git clone --depth 1 https://github.com/tpope/vim-commentary &
git clone --depth 1 https://github.com/tpope/vim-sleuth &
git clone --depth 1 https://github.com/tpope/vim-surround &
git clone --depth 1 https://github.com/tpope/vim-unimpaired &
vim -u NONE -c "helptags vim-fugitive/doc" -c "helptags vim-vinegar/doc" -c "helptags vim-commentary/doc" \
    -c "helptags vim-sleuth/doc" -c "helptags vim-surround/doc" -c "helptags vim-unimpaired/doc" -c q
