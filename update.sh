cp ~/.zshrc .
cp ~/.zprofile .
cp ~/.gitconfig .
rsync -a --delete ~/.config/oh-my-posh/ .config/oh-my-posh/
rsync -a --delete ~/.dircolors/ .dircolors/
cp -L ~/.tmux.conf.local .tmux.conf.local
cp ~/.config/git/ignore .config/git/ignore
cp ~/.config/gh/config.yml .config/gh/config.yml
rsync -a --delete --exclude .DS_Store ~/.config/ghostty/ .config/ghostty/
