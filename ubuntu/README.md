Ubuntu/WSL2
-----------

Scripts that support installing the following softwares

```bash
./install.sh
```


```bash
./ubuntu/install.sh dependencies cmake .local python rust lua neovim nvim-config tmux tmux-config nvtop zig sioyek case-insensitive-bash
```

cuda dev for clangd
-------------------
`.clangd` file at the project root.

```
CompileFlags:
  Add:
    - -std=c++11
    - --cuda-path=/usr/local/cuda
    - --cuda-gpu-arch=sm_86
    - -L/usr/local/cuda/lib64
    - -I/usr/local/cuda/include
```

For `--cuda-gpu-arch`, 
[https://arnon.dk/matching-sm-architectures-arch-and-gencode-for-various-nvidia-cards/](https://arnon.dk/matching-sm-architectures-arch-and-gencode-for-various-nvidia-cards/)


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
