Dotfiles
========


Nvim Compile
============

```bash
make distclean && make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local" && make install
```

Vim Compile
===========

```console
./configure --prefix=$HOME/.local --disable-gui --without-x && make && make install
```
