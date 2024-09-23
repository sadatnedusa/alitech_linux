# Learn vim editor
- https://www.vim-hero.com/
- https://openvim.com/sandbox.html


---
### Beginner to Advanced Guide: Learning Vim Editor

Vim is a powerful and highly configurable text editor that is widely used in the Linux and programming communities. Here's a step-by-step guide to help you learn Vim from beginner to advanced levels.

---

### **1. Beginner Level: Basic Usage**

#### **Opening Vim**
- **Open Vim**: 
  ```bash
  vim filename
  ```
  If the file exists, it will open the file. If not, a new file will be created.

#### **Vim Modes**
Vim has several modes, but the most important ones are:
- **Normal Mode**: Default mode when Vim starts. Use it to navigate and execute commands.
- **Insert Mode**: For inserting and editing text. Press `i` to switch to this mode.
- **Command Mode**: For saving, quitting, and executing commands. Access it by pressing `Esc`, then `:`.

#### **Basic Navigation in Normal Mode**
- **Move the cursor**:
  - `h`: Move left
  - `j`: Move down
  - `k`: Move up
  - `l`: Move right
- **Words and lines**:
  - `w`: Move to the start of the next word.
  - `b`: Move to the start of the previous word.
  - `0`: Jump to the beginning of the line.
  - `$`: Jump to the end of the line.
  - `gg`: Jump to the beginning of the file.
  - `G`: Jump to the end of the file.

#### **Basic Editing**
- **Insert text**: Press `i` to enter Insert Mode, then type your text.
- **Delete**:
  - `x`: Delete the character under the cursor.
  - `dw`: Delete from the cursor to the end of the current word.
  - `dd`: Delete the current line.
- **Undo and Redo**:
  - `u`: Undo the last change.
  - `Ctrl + r`: Redo the last undone change.
  
#### **Saving and Quitting**
- **Save changes**: Press `Esc` to go back to Normal Mode, then type `:w` to save.
- **Quit Vim**: Type `:q` to quit.
- **Save and quit**: Type `:wq` or `ZZ`.
- **Quit without saving**: Type `:q!`.

---

### **2. Intermediate Level: Editing and Navigation**

#### **More Efficient Editing**
- **Replace Mode**: Press `R` to overwrite text under the cursor.
- **Cut (Yank) and Paste**:
  - `yy`: Yank (copy) the current line.
  - `p`: Paste the yanked or deleted content after the cursor.
  - `P`: Paste before the cursor.
- **Change**:
  - `cw`: Change from the cursor to the end of the word.
  - `cc`: Change the entire line.

#### **Search and Replace**
- **Search for text**: Type `/pattern` and press `Enter` to search for "pattern."
  - Use `n` to find the next occurrence.
  - Use `N` to find the previous occurrence.
- **Search and replace**:
  ```bash
  :%s/old/new/g
  ```
  This command replaces all occurrences of "old" with "new" in the file.
  - `%`: Applies to the whole file.
  - `g`: Replace all occurrences in a line.

#### **Working with Multiple Files**
- **Open another file**: Type `:e anotherfile.txt` to open a new file.
- **Switch between files**: Use `:bnext` and `:bprev` to cycle between open files.
- **Split windows**:
  - `:vsp filename`: Open a file in a vertical split.
  - `:sp filename`: Open a file in a horizontal split.
  - Use `Ctrl + w, w` to switch between splits.

---

### **3. Advanced Level: Customization and Plugins**

#### **Customizing Vim**
Vim can be customized using the `~/.vimrc` configuration file. This file allows you to set options, define mappings, and load plugins.
- **Set line numbers**:
  Add this line to your `~/.vimrc` file:
  ```bash
  set number
  ```
- **Enable syntax highlighting**:
  ```bash
  syntax on
  ```
- **Customize key mappings**:
  You can create custom key mappings to increase productivity. For example:
  ```bash
  nnoremap <C-n> :NERDTreeToggle<CR>
  ```
  This maps `Ctrl + n` to toggle the NERDTree file explorer.

#### **Using Vim Plugins**
Vim has a rich plugin ecosystem. To install plugins, you'll need a plugin manager like **vim-plug**.

- **Install vim-plug**:
  ```bash
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ```
- **Add plugins to your `.vimrc`**:
  ```bash
  call plug#begin('~/.vim/plugged')

  " List your plugins here
  Plug 'scrooloose/nerdtree'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  call plug#end()
  ```

- **Install the plugins**: In Vim, run `:PlugInstall` to install the plugins.

#### **Macros and Registers**
- **Record macros**:
  - Press `q` followed by a letter (e.g., `qa` to record into register `a`).
  - Perform the actions you want to record.
  - Press `q` again to stop recording.
  - Play the macro by typing `@a` (for register `a`).
  
- **Registers**: Vim stores copied and deleted text in registers, which you can access using `"` followed by the register name (e.g., `"ay` to yank into register `a`).

#### **Advanced Text Manipulation**
- **Visual Mode**:
  - `v`: Select text character by character.
  - `V`: Select entire lines.
  - `Ctrl + v`: Enter visual block mode (for column editing).
  
- **Text Objects**:
  - `ciw`: Change inner word.
  - `caw`: Change a word (including surrounding spaces).
  - `dit`: Delete inside a tag (useful in HTML/XML files).

---

### **4. Expert Level: Scripting and Efficiency**

#### **Vim Scripting**
Vim supports a scripting language called **Vimscript**, which you can use to automate tasks or create more advanced customizations.

- **Simple Script Example**:
  ```bash
  function! SayHello()
      echo "Hello, Vim!"
  endfunction
  ```
  You can call this function in Vim by typing `:call SayHello()`.

#### **Using Buffers, Windows, and Tabs**
- **Buffers**: Each file opened in Vim is a buffer.
  - `:ls`: List all open buffers.
  - `:bd`: Delete a buffer (close a file).
  
- **Tabs**:
  - `:tabnew filename`: Open a new tab with the specified file.
  - `:tabn`: Move to the next tab.
  - `:tabp`: Move to the previous tab.

#### **Efficiency Tips**
- **Jumping to Marks**:
  - Set a mark by pressing `m` followed by a letter (e.g., `ma`).
  - Jump to the mark by typing `'a`.
  
- **Quickfix List**: Useful for dealing with compiler errors or search results.
  - `:copen`: Open the quickfix window.
  - `:cnext`: Jump to the next error in the list.
  - `:cprev`: Jump to the previous error.

---

By mastering these concepts, you can become highly efficient in Vim, whether you're writing code, editing configuration files, or processing text.

Let me know if you'd like to dive deeper into any specific aspect!
