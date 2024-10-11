Here’s a comprehensive cheat sheet for the **Vi editor** (or its improved version, **Vim**) along with some advanced methods for file manipulation. 

### **Basic Vi/Vim Command Modes**

1. **Normal Mode (Command Mode)**:
   - This is the default mode when you open a file in `vi`.
   - You can navigate, delete, or manipulate text, but not insert new text.
   - Switch to this mode by pressing `Esc`.

2. **Insert Mode**:
   - Used for inserting text.
   - Enter this mode by pressing `i` (insert), `I` (insert at beginning of line), `a` (append), `A` (append at end of line), `o` (open a new line below), or `O` (open a new line above).
   - Exit by pressing `Esc`.

3. **Visual Mode**:
   - Used for selecting blocks of text.
   - Enter by pressing `v` (character-wise visual), `V` (line-wise visual), or `Ctrl + v` (visual block mode).

4. **Command-Line Mode**:
   - Used for saving, quitting, and running other commands.
   - Enter by typing `:` from normal mode.

---

### **Basic Navigation Commands**

| Command        | Description                                 |
| -------------- | ------------------------------------------- |
| `h`            | Move cursor left                            |
| `j`            | Move cursor down                            |
| `k`            | Move cursor up                              |
| `l`            | Move cursor right                           |
| `0`            | Go to the beginning of the line             |
| `^`            | Go to the first non-blank character         |
| `$`            | Go to the end of the line                   |
| `gg`           | Go to the beginning of the file             |
| `G`            | Go to the end of the file                   |
| `Ctrl + f`     | Move forward (down) one screen              |
| `Ctrl + b`     | Move backward (up) one screen               |
| `w`            | Move to the beginning of the next word      |
| `b`            | Move to the beginning of the previous word  |
| `e`            | Move to the end of the word                 |
| `nG` or `ngg`  | Go to line `n`                              |
| `Ctrl + u`     | Scroll half a screen up                     |
| `Ctrl + d`     | Scroll half a screen down                   |
| `%`            | Jump between matching parentheses/brackets |

---

### **Insert Mode Commands**

| Command        | Description                                   |
| -------------- | --------------------------------------------- |
| `i`            | Enter insert mode before the cursor           |
| `I`            | Enter insert mode at the beginning of the line|
| `a`            | Enter insert mode after the cursor            |
| `A`            | Enter insert mode at the end of the line      |
| `o`            | Open a new line below the current line        |
| `O`            | Open a new line above the current line        |
| `Esc`          | Return to normal mode                         |

---

### **Editing Commands**

| Command        | Description                                     |
| -------------- | ----------------------------------------------- |
| `x`            | Delete the character under the cursor           |
| `dw`           | Delete a word                                   |
| `dd`           | Delete the entire current line                  |
| `D`            | Delete from cursor to the end of the line       |
| `d$`           | Delete to the end of the line                   |
| `d0`           | Delete to the beginning of the line             |
| `cw`           | Change a word (delete and enter insert mode)    |
| `cc`           | Change the whole line                           |
| `C`            | Change from cursor to the end of the line       |
| `r`            | Replace a single character                      |
| `R`            | Replace mode (overwrite existing text)          |
| `u`            | Undo the last change                            |
| `Ctrl + r`     | Redo the undone change                          |
| `y`            | Yank (copy) selected text                       |
| `p`            | Paste yanked (copied) text                      |
| `J`            | Join the current line with the next one         |
| `.`            | Repeat the last command                         |

---

### **Search and Replace Commands**

| Command            | Description                                     |
| ------------------ | ----------------------------------------------- |
| `/pattern`         | Search for `pattern` forward                    |
| `?pattern`         | Search for `pattern` backward                   |
| `n`                | Repeat the last search forward                  |
| `N`                | Repeat the last search backward                 |
| `:%s/old/new/g`    | Replace all occurrences of `old` with `new`     |
| `:s/old/new/g`     | Replace in the current line                     |
| `:%s/old/new/gc`   | Replace all with confirmation                   |
| `:%s/\<old\>/new/g`| Replace whole words only                        |

---

### **File Operations**

| Command        | Description                                     |
| -------------- | ----------------------------------------------- |
| `:w`           | Save the current file                           |
| `:w filename`  | Save the current file as `filename`             |
| `:x` or `:wq`  | Save and quit                                  |
| `:q`           | Quit (fails if there are unsaved changes)       |
| `:q!`          | Quit without saving                            |
| `:wq!`         | Force save and quit                            |
| `:e filename`  | Open `filename` in the editor                  |
| `:bn` or `:bp` | Navigate to next/previous file in buffer        |
| `:b <n>`       | Switch to buffer number `n`                    |
| `:r filename`  | Read the contents of another file into the buffer |

---

### **Visual Mode (Text Selection)**

| Command        | Description                                   |
| -------------- | --------------------------------------------- |
| `v`            | Start visual mode (character-based selection) |
| `V`            | Start line-wise selection                     |
| `Ctrl + v`     | Start block selection (visual block)          |
| `d`            | Delete the selected text                      |
| `y`            | Yank (copy) the selected text                 |
| `>`            | Indent the selected text                      |
| `<`            | Outdent the selected text                     |
| `p`            | Paste the selected text                       |

---

### **Advanced Methods to Manipulate Files**

1. **Working with Multiple Files**:
   - Open multiple files at once: 
     ```bash
     vi file1 file2
     ```
   - Move between files: `:n` (next file) and `:prev` (previous file).
   
2. **Splitting Windows (Buffers)**:
   - Horizontal split:
     ```bash
     :split filename
     ```
   - Vertical split:
     ```bash
     :vsplit filename
     ```
   - Move between windows: 
     - `Ctrl + w w`: Move to the next split window.
     - `Ctrl + w h/j/k/l`: Move in the specified direction.

3. **Working with Tabs**:
   - Open files in tabs:
     ```bash
     :tabedit filename
     ```
   - Switch between tabs: 
     - `gt`: Move to the next tab.
     - `gT`: Move to the previous tab.
   - List all open tabs:
     ```bash
     :tabs
     ```

4. **Recording and Running Macros**:
   - Record a macro by typing `q` followed by a register (e.g., `q a` to record into register `a`).
   - Perform your series of commands, then press `q` again to stop recording.
   - Replay the macro by typing `@` followed by the register (e.g., `@a`).

5. **Advanced Substitution**:
   - Substituting within a visual selection:
     1. Visually select the text.
     2. Use `:s/pattern/replacement/g` to perform the substitution within the selected block.
   
6. **Working with Registers**:
   - Yank into named registers:
     ```bash
     "aY
     ```
     (Yank into register `a`.)
   - Paste from a register:
     ```bash
     "ap
     ```

7. **Advanced File Navigation**:
   - Jump to a specific line number:
     ```bash
     :<line-number>
     ```
   - Go to the last edited position:
     ```bash
     ``
     ```

---

### Conclusion

This cheat sheet provides an essential guide for both **basic** and **advanced** operations in the **Vi/Vim editor**. The more advanced methods, such as working with multiple files, splitting windows, using tabs, and manipulating text with macros, can greatly enhance productivity when editing code or large text files. By mastering Vi’s powerful commands, you can become much more efficient in navigating and manipulating text in a command-line environment.
