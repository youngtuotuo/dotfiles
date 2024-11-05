Installation
-----------

```bash
./install.sh
```

tigerVNC
--------

**NOTE**: No need to use this in WSL2.

```bash
vncserver :2
vncserver -kill :2
vncserver -list
vncserver -kill
vncserver -localhost no -geometry 1920x1080
```

noVNC
-----

```bash
git clone https://github.com/novnc/noVNC ~/github/noVNC
pip install numpy
./utils/novnc_proxy --vnc <host>:5901
```
