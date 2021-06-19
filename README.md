# dotfiles

## 他のコンピュータからの取得

```
cd ~/ 
git clone https://github.com/tagasuke/dotfiles.git

# シンボリックリンクを作成
ln -s dotfiles/.vimrc .vimrc
ln -s dotfiles/.tmux.conf .tmux.conf

# カラースキーマの設定
mkdir -p .vim/colors

## 以下をコピペ
## https://github.com/tomasr/molokai/blob/master/colors/molokai.vim
vim .vim/colors/molokai.vim
```
