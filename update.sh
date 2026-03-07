cp ~/.zshrc .
cp ~/.zprofile .
cp ~/.gitconfig .
rsync -a --delete ~/.config/oh-my-posh/ .config/oh-my-posh/
rsync -a --delete ~/.dircolors/ .dircolors/
