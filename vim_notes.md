# Always use :help

### Cut And Change

        d/c   [number]  motion

    Where:
        d/c    - Delete operator/change operate.
        number - The repeat times
        motion - What the operator will operate on.

### Tabs

        :tabe[dit]  [filepath]  - Open a new tab
        :tabc[lose] [filepath]  - Close current tab
        :tabo[nly]  [filepath]  - Leave currrent tab and close all another
        :tabl[ast]              - Go to the last tab
        :tabr[ewind]            - Go to the last edit tab
        :tabfir[st]             - Go to the first tab
        :tabs                   - List all tabs
                                  Shows a ">" for the current window
                                  Shows a "+" for modified buffers
        [number]gt              - Go to the [number]-th tab
        g<Tab>                  - Go to the last accessed tab page(<Tab>=<C-i>)


### Join

        J   - Join line below

### Cursor Movement

        Ctrl + g    - Show location in the file and the file status
        Ctrl + o    - Go to last cursor position
        Ctrl + i    - Go to next cursor position
        %           - Parentheses match and search

### Split

        :[number]vsp [filepath]    - vertical split according to [number]
        :[number]sp  [filepath]    - horizontal split according to [number]

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
<https://www.freecodecamp.org/news/learn-linux-vim-basic-features-19134461ab85/>  
<http://vimregex.com/#news>
