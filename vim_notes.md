# Always use :help

### Cut And Change

        d/c   [number]  motion

    Where:
        d/c    - delete operator/change operate.
        number - is the repeat times
        motion - is what the operator will operate on.

### Join

        J   - Join line below

### Cursor Movement

        Ctrl + g    - Show location in the file and the file status
        Ctrl + o    - Go to last cursor position
        Ctrl + i    - Go to next cursor position
        %           - Parentheses match and search

### Split

        :[number]vsp [filename]    - vertical split according to [number]
        :[number]sp  [filename]    - horizontal split according to [number]

### Pane Resize

        Ctrl + w  _   - max out the height of the current split
        Ctrl + w |    - max out the width of the current split
        Ctrl + w =    - normalize all split sizes
        Ctrl + w R    - swap top/bottom or  left/right split

### Delete all trailing spaces

        :[range]s/{pattern}/{string}/[flags] [count]

        :%s/\s\+$//e
                % : all matching pattern
                \s: white space or tab
                \+: match one or more of them
                $ : anchor at the end of line
                e : not give an error if there is no match
                g : globally match

### Reference

        $ vimtutor
        <https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally#easier-split-navigations>
