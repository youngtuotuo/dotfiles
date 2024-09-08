Neovim
------

Python.h
-----------------------------------

To resolve `#include <Python.h>`, run the following command to get the path of `Python.h`

```console
python -c "import sysconfig; print(sysconfig.get_paths()['include'])"
# or
python3 -c "import sysconfig; print(sysconfig.get_paths()['include'])"
# or
pkg-config --libs --cflags python
# or
pkg-config --libs --cflags python3
```
