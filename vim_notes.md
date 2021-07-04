# Always use :help

### Cut And Change

        d/c   [number]  motion

        Where:
                d/c    - Delete operator/change operate.
                number - The repeat times
                motion - What the operator will operate on.

### Page Reading

        Ctrl-e  - Scroll down one line
        Ctrl-d  - Scroll down half page
        Ctrl-f  - Scroll down one page
        Ctrl-y  - Scroll up one line
        Ctrl-u  - Scroll up half page
        Ctrl-b  - Scroll up one page
        zz      - Put cursor's line at the center of the window. Be careful that caps-lock is off, "ZZ" will write buffer and exit.
        zt      - Put cursor's line at the top of the window
        zb      - Put cursor's line at the bottom of the window
        z.      - Put the cursor's line at the center of the window but leave the cursor in the same coumn 

### Key notation

        <BS>    - Ctrl-h
        <Tab>   - Ctrl-i
        <CR>    - Ctrl-m

### Tabe

        $ vim -p file1 file2    - Open multiple files in tabs
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


### Editing Efficiency

        J   - Join line below

### Cursor Movement

        Ctrl-g    - Show location in the file and the file status
        Ctrl-o    - Go to last cursor position
        Ctrl-i    - Go to next cursor position
        %         - Parentheses match and search
        ``        - To the position before the latest jump, or where the last "m`" command was given.
        ''        - The same as ``

### Split

        :[number]vsp [filepath]    - vertical split according to [number]
        :[number]sp  [filepath]    - horizontal split according to [number]

### Pane Resize

        Ctrl-w  _   - max out the height of the current split
        Ctrl-w |    - max out the width of the current split
        Ctrl-w =    - normalize all split sizes
        Ctrl-w R    - swap top/bottom or  left/right split

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

:help  
$ vimtutor  
<https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally#easier-split-navigations>  
<https://www.freecodecamp.org/news/learn-linux-vim-basic-features-19134461ab85/>  
<http://vimregex.com/#news>
