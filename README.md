
This is a vim configuration directory, set up to use Vundle
(https://github.com/gmarik/vundle) to manage packages. Clone it using

```
git clone --recursive https://github.com/jgtate/dot.vim-vundle.git ~/.vim
```

Install Vundle:

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Start vim and run ```:PluginInstall``` to set up most of the plugins. Command-T
requires ruby; look for ```+ruby``` in the output of ```vim --version```. If it's
there, check the [Command-T docs](https://github.com/wincent/command-t/blob/master/doc/command-t.txt).

To integrate vim and tmux, make sure the file `bin/tmux-vim-select-pane` is
on your path and add the key bindings in `tmux.conf`.
