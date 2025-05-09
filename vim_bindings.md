# Vim Cheat Sheet

A comprehensive list of essential Vim shortcuts for efficient text editing.

## Global

* `:h[elp] keyword` - Open help for keyword
* `:sav[eas] file` - Save file as
* `:clo[se]` - Close current pane
* `:ter[minal]` - Open a terminal window
* `K` - Open man page for word under the cursor

*Tip: Run `vimtutor` in a terminal to learn the first Vim commands.*

## Cursor movement

* `h` - Move cursor left
* `j` - Move cursor down
* `k` - Move cursor up
* `l` - Move cursor right
* `gj` - Move cursor down (multi-line text)
* `gk` - Move cursor up (multi-line text)
* `H` - Move to top of screen
* `M` - Move to middle of screen
* `L` - Move to bottom of screen
* `w` - Jump forward to the start of a word
* `W` - Jump forward to the start of a word (words can contain punctuation)
* `e` - Jump forward to the end of a word
* `E` - Jump forward to the end of a word (words can contain punctuation)
* `b` - Jump backward to the start of a word
* `B` - Jump backward to the start of a word (words can contain punctuation)
* `ge` - Jump backward to the end of a word
* `gE` - Jump backward to the end of a word (words can contain punctuation)
* `%` - Move cursor to matching character (e.g., parentheses, braces, brackets)
* `0` - Jump to the start of the line
* `^` - Jump to the first non-blank character of the line
* `$` - Jump to the end of the line
* `g_` - Jump to the last non-blank character of the line
* `gg` - Go to the first line of the document
* `G` - Go to the last line of the document
* `5gg` or `5G` - Go to line 5
* `gd` - Move to local declaration
* `gD` - Move to global declaration
* `fx` - Jump to next occurrence of character `x`
* `tx` - Jump to before next occurrence of character `x`
* `Fx` - Jump to the previous occurrence of character `x`
* `Tx` - Jump to after previous occurrence of character `x`
* `;` - Repeat previous `f`, `t`, `F` or `T` movement
* `,` - Repeat previous `f`, `t`, `F` or `T` movement backwards
* `}` - Jump to next paragraph or code block
* `{` - Jump to previous paragraph or code block
* `zz` - Center cursor on screen
* `zt` - Position cursor at top of screen
* `zb` - Position cursor at bottom of screen
* `Ctrl+e` - Scroll screen down one line (cursor stays)
* `Ctrl+y` - Scroll screen up one line (cursor stays)
* `Ctrl+b` - Move screen up one page (cursor to last line)
* `Ctrl+f` - Move screen down one page (cursor to first line)
* `Ctrl+d` - Move cursor and screen down half a page
* `Ctrl+u` - Move cursor and screen up half a page

*Tip: Prefix a cursor movement command with a number to repeat it. E.g., `4j` moves down 4 lines.*

## Insert mode - inserting/appending text

* `i` - Insert before the cursor
* `I` - Insert at the beginning of the line
* `a` - Insert (append) after the cursor
* `A` - Insert (append) at the end of the line
* `o` - Open a new line below the current line and enter insert mode
* `O` - Open a new line above the current line and enter insert mode
* `ea` - Insert at the end of the word
* `Ctrl+h` - Delete character before the cursor
* `Ctrl+w` - Delete word before the cursor
* `Ctrl+j` - Add a line break at the cursor position
* `Ctrl+t` - Indent line one shiftwidth
* `Ctrl+d` - De-indent line one shiftwidth
* `Ctrl+n` - Auto-complete next match
* `Ctrl+p` - Auto-complete previous match
* `Ctrl+rx` - Insert the contents of register `x`
* `Ctrl+ox` - Temporarily enter normal mode to issue one normal-mode command `x`
* `Esc` or `Ctrl+c` - Exit insert mode

## Editing

* `r` - Replace a single character
* `R` - Enter replace mode until `Esc` is pressed
* `J` - Join line below to the current one with a space
* `gJ` - Join line below without a space
* `gwip` - Reflow paragraph
* `g~` - Switch case up to motion
* `gu` - Change to lowercase up to motion
* `gU` - Change to uppercase up to motion
* `cc` - Change (replace) entire line
* `c$` or `C` - Change (replace) to the end of the line
* `ciw` - Change (replace) entire word
* `cw` or `ce` - Change (replace) to the end of the word
* `s` - Delete character and substitute text (same as `cl`)
* `S` - Delete line and substitute text (same as `cc`)
* `xp` - Transpose two letters
* `u` - Undo
* `U` - Restore last changed line
* `Ctrl+r` - Redo
* `.` - Repeat last command

## Marking text (visual mode)

* `v` - Start visual mode (character-wise)
* `V` - Start linewise visual mode
* `o` - Move to other end of marked area
* `Ctrl+v` - Start visual block mode
* `O` - Move to other corner of block
* `aw` - Select a word
* `ab` - Select a block with `()`
* `aB` - Select a block with `{}`
* `at` - Select a block with `<>` tags
* `ib` - Select inner block with `()`
* `iB` - Select inner block with `{}`
* `it` - Select inner block with `<>` tags
* `Esc` or `Ctrl+c` - Exit visual mode

*Tip: Instead of `b` or `B`, you can also use `(` or `{` respectively.*

## Visual commands

* `>` - Shift text right
* `<` - Shift text left
* `y` - Yank (copy) marked text
* `d` - Delete marked text
* `~` - Switch case
* `u` - Change marked text to lowercase
* `U` - Change marked text to uppercase

## Registers

* `:reg[isters]` - Show registers content
* `"xy` - Yank into register `x`
* `"xp` - Paste contents of register `x`
* `"+y` - Yank into the system clipboard register
* `"+p` - Paste from the system clipboard register

*Tip: Registers are stored in `~/.viminfo` and loaded on restart.*

## Marks and positions

* `:marks` - List of marks
* `ma` - Set mark `a` at current position
* ``a` `` - Jump to mark `a`
* `y`a`- Yank text to mark`a\`
* ``0` `` - Go to position where Vim was last exited
* ``"` `` - Go to position when last editing this file
* ``.` `` - Go to position of last change in this file
* ```- Go to position before last jump
  ```
* `:ju[mps]` - List of jumps
* `Ctrl+i` - Go to newer position in jump list
* `Ctrl+o` - Go to older position in jump list
* `:changes` - List of changes
* `g,` - Go to newer position in change list
* `g;` - Go to older position in change list
* `Ctrl+]` - Jump to tag under cursor

*Tip: Use an apostrophe (`'`) to jump to the first non-blank character of the mark's line.*

## Macros

* `qa` - Record macro `a`
* `q` - Stop recording macro
* `@a` - Run macro `a`
* `@@` - Rerun last macro

## Cut and paste

* `yy` - Yank (copy) a line
* `2yy` - Yank two lines
* `yw` - Yank characters of the word from cursor to next word start
* `yiw` - Yank inner word
* `yaw` - Yank a word including trailing space
* `y$` or `Y` - Yank to end of line
* `p` - Paste after cursor
* `P` - Paste before cursor
* `gp` - Paste after cursor, leave cursor after new text
* `gP` - Paste before cursor, leave cursor after new text
* `dd` - Delete (cut) a line
* `2dd` - Delete two lines
* `dw` - Delete word from cursor to next word start
* `diw` - Delete inner word
* `daw` - Delete a word including space
* `:3,5d` - Delete lines 3 to 5
* `:.,$d` - Delete from current line to end of file
* `:.,1d` - Delete from current line to beginning of file
* `:10,1d` - Delete from line 10 to beginning of file
* `:g/{pattern}/d` - Delete all lines containing pattern
* `:g!/{pattern}/d` - Delete all lines not containing pattern
* `d$` or `D` - Delete to end of line
* `x` - Delete a character

## Indent text

* `>>` - Indent one shiftwidth
* `<<` - De-indent one shiftwidth
* `>%` - Indent a block with `()` or `{}` (on brace)
* `<%` - De-indent a block with `()` or `{}` (on brace)
* `>ib` - Indent inner block with `()`
* `>at` - Indent a block with `<>` tags
* `3==` - Re-indent three lines
* `=%` - Re-indent block with `()` or `{}`
* `=iB` - Re-indent inner block with `{}`
* `gg=G` - Re-indent entire buffer
* `]p` - Paste and adjust indent

## Exiting

* `:w` - Write (save) file
* `:w !sudo tee %` - Save file with sudo privileges
* `:wq` or `:x` or `ZZ` - Save and quit
* `:q` - Quit (fails if unsaved changes)
* `:q!` or `ZQ` - Quit without saving
* `:wqa` - Save and quit all tabs

## Search and replace

* `/pattern` - Search forward for pattern
* `?pattern` - Search backward for pattern
* `\vpattern` - Very magic regex pattern (no escaping needed)
* `n` - Repeat search in same direction
* `N` - Repeat search in opposite direction
* `:%s/old/new/g` - Replace all occurrences in file
* `:%s/old/new/gc` - Replace with confirmation
* `:noh[lsearch]` - Clear search highlighting

## Search in multiple files

* `:vim[grep] /pattern/ {file}` - Search pattern in multiple files (e.g. `:**/*`)
* `:cn[ext]` - Jump to next match in quickfix
* `:cp[revious]` - Jump to previous match
* `:cope[n]` - Open quickfix list
* `:ccl[ose]` - Close quickfix window

## Tabs

* `:tabnew` or `:tabnew {file}` - Open file in new tab
* `Ctrl+wT` - Move split window to its own tab
* `gt` or `:tabn[ext]` - Next tab
* `gT` or `:tabp[revious]` - Previous tab
* `#gt` - Go to tab number `#`
* `:tabm[ove] #` - Move current tab to position `#`
* `:tabc[lose]` - Close current tab
* `:tabo[nly]` - Close all but current tab
* `:tabdo {command}` - Run command on all tabs

## Working with multiple files

* `:e[dit] file` - Edit file in new buffer
* `:bn[ext]` - Next buffer
* `:bp[revious]` - Previous buffer
* `:bd[elete]` - Close a buffer
* `:b[uffer]#` - Go to buffer by index
* `:b[uffer] file` - Go to buffer by name
* `:ls` or `:buffers` - List open buffers
* `:sp[lit] file` - Horizontal split
* `:vs[plit] file` - Vertical split
* `:vert[ical] ba[ll]` - Vertical buffer windows
* `:tab ba[ll]` - Open all buffers as tabs
* `Ctrl+ws` - Split window horizontally
* `Ctrl+wv` - Split window vertically
* `Ctrl+ww` - Switch windows
* `Ctrl+wq` - Close a window
* `Ctrl+wx` - Exchange current window with next
* `Ctrl+w=` - Equalize window sizes
* `Ctrl+wh` - Move cursor to left window
