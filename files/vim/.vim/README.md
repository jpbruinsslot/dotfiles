# Install plugins as submodules

```bash
$ cd ~/.vim
$ git submodule add \
	https://github.com/tpope/vim-fugitive.git bundle/fugitive
$ git add .
$ git commit
```

# Install your vim environment on another machine
cd ~/.vim
git submodule init
git submodule update

# Upgrading all bundled plugins
git submodule foreach git pull origin master
