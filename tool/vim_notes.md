# Always use :help

### Cut And Change

        d/c [number]  motion

        Where:
                d/c    - Delete operator/change operate.
                number - The repeat times
                motion - What the operator will operate on.

### Fold

        [range]zf [number] motion      - Folding lines or blocks

        zd      - Delete one fold at the cursor
        zc      - Close one fold
        zo      - Open one fold
        za      - Toggle one fold between open and clsoe

### Macro

        q{0-9a-zA-Z"}           - Start recording macro {0-9a-zA-Z"}
        @[number]{0-9a-zA-Z"}   - Repeat macro {0-9a-zA-Z"} [number] times

### File Explorer

        :Ex[plore]  [dir] - Explore directory of current file
        :Hex[plore] [dir] - Horizontal Split & Explore
        :Sex[plore] [dir] - Split&Explore current file's directory
        :Vex[plore] [dir] - Vertical   Split & Explore
        :Tex[plore] [dir] - Tab & Explore
        :Rex[plore]       - Return to/from Explorer

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

### Key Notation

        <BS>    - Ctrl-h
        <Tab>   - Ctrl-i
        <CR>    - Ctrl-m

### Tab

        $ vim -p file1 file2    - Open multiple files in tabs
        :tabe[dit]  [filepath]  - Open a new tab
        :tabc[lose] [filepath]  - Close current tab
        :tabo[nly]  [filepath]  - Leave currrent tab and close all another
        :tabl[ast]              - Go to the last tab
        :tabr[ewind]            - Go to the last edit tab
        :tabfir[st]             - Go to the first tab
        :[N]tabm[ove]           - Move the current tab after the [N]-th tab
        :tabm[ove] [N]          - The same as [N]tabm[ove]
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

### Substitute

        :[range]s/{pattern}/{string}/[flags] [count]

### Delete all trailing spaces


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
