# prelude-personal

My personal directory for prelude (emacs). It's not very interesting, but this seems like a good place to keep it.

## Installation

``` shell
mkdir -p ~/personal
cd ~/personal
git clone https://github.com/bbatsov/prelude.git
ln -s ~/.emacs.d ~/personal/prelude

emacs -batch -f batch-byte-compile ~/.emacs.d/core/*.el

git clone git@github.com:zuercher/prelude-personal.git
~/personal/prelude-personal/link-files.sh
```
