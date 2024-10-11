# Unix Linux shell interpreter

- In Linux, both `sh` and `bash` are Unix shell interpreters, but they have some important differences in terms of functionality, usage, and compatibility.

## Here's a detailed comparison:

### 1. **Origins and Evolution**
   - **`sh` (Bourne Shell)**:
     - **Origin**: `sh` stands for **Bourne Shell**, named after its creator Stephen Bourne. It was the original Unix shell and was released in 1977.
     - **Purpose**: It was designed to be a simple, reliable scripting environment for Unix systems.
     - **Compatibility**: Since it is one of the oldest shells, it is widely supported across Unix-like systems.
  
   - **`bash` (Bourne Again Shell)**:
     - **Origin**: `bash` stands for **Bourne Again Shell**, developed as a free and open-source successor to the Bourne Shell. It was released in 1989 as part of the GNU Project.
     - **Enhancements**: `bash` includes all features of `sh` along with several additional features borrowed from other shells like `csh` and `ksh`.
     - **Usage**: It is the default shell in most modern Linux distributions.

### 2. **Functionality**
   - **`sh`**:
     - **Basic Features**: Supports basic shell scripting with features like conditionals, loops, and command chaining.
     - **Limited Scripting Features**: Lacks many advanced features found in modern shells like arrays, associative arrays, or brace expansion.
     - **Minimal Prompt Features**: Limited command-line editing or customization of prompts.
   
   - **`bash`**:
     - **Enhanced Features**: Supports advanced features such as:
       - **Command history**: Lets you navigate through and reuse previous commands using the arrow keys.
       - **Tab completion**: Autocompletes commands, filenames, or directory names when you press the Tab key.
       - **Brace expansion**: Allows concise expression of multiple commands (e.g., `mkdir {a,b,c}`).
       - **Arrays and associative arrays**: Allows you to store and manipulate lists of values.
       - **Arithmetic operations**: Supports basic math operations natively within the shell.

### 3. **Scripting Syntax**
   - **Compatibility**:
     - Scripts written for `sh` will generally work in `bash`, but the reverse is not true because `bash` supports additional syntax and features not available in `sh`.
     - If you're aiming for portability (e.g., for systems where only `sh` is available), you should avoid using `bash`-specific features in your scripts.
   
   - **Example of Bash-Specific Features**:
     ```bash
     # Using arrays in bash (not available in sh)
     my_array=(apple orange banana)
     echo ${my_array[1]}  # Outputs: orange
     ```

### 4. **Performance**
   - **`sh`**: 
     - As it is more basic and lacks some advanced features, `sh` can be slightly faster in scenarios where complex features are not required. It is often used in lightweight systems or scripts that need to run in minimal environments.
   
   - **`bash`**: 
     - With more features, `bash` is slightly heavier than `sh`. However, the performance difference is minimal in most modern environments. `bash` is more flexible and convenient for complex scripting tasks.

### 5. **Interactivity**
   - **`sh`**:
     - Designed more for scripting and automation than interactive use.
     - Lacks modern conveniences like command-line editing, history, and auto-completion, making it less user-friendly for interactive terminal work.
   
   - **`bash`**:
     - Optimized for interactive use, with features like command history, auto-completion, customizable prompts, and more. This makes it the preferred shell for interactive use by most users.

### 6. **Availability**
   - **`sh`**:
     - In modern systems, `sh` is often a symlink to another shell like `bash`, `dash`, or `ksh`. For instance, on many Linux systems, `/bin/sh` points to `dash`, which is a lightweight, fast version of `sh`.
     - On Unix systems, however, `sh` still refers to the traditional Bourne Shell.
   
   - **`bash`**:
     - The default shell on most Linux distributions (like Ubuntu, CentOS, Fedora) and macOS (though macOS switched to `zsh` in recent versions).
     - Widely available and supported across many Unix-like systems.

### 7. **POSIX Compliance**
   - **`sh`**:
     - `sh` is more aligned with **POSIX** (Portable Operating System Interface) standards, making it suitable for writing scripts that need to be portable across different Unix systems.
   
   - **`bash`**:
     - `bash` is mostly POSIX compliant, but it includes many extensions beyond the POSIX standard, which might lead to portability issues when using `bash`-specific features.

### Summary Table

| Feature                | `sh` (Bourne Shell)              | `bash` (Bourne Again Shell)            |
|------------------------|----------------------------------|----------------------------------------|
| **Origin**              | 1977, by Stephen Bourne          | 1989, GNU Project                      |
| **Portability**         | Highly portable, older systems   | Default on modern Linux systems        |
| **Features**            | Basic scripting capabilities     | Advanced features (history, arrays, etc.) |
| **Interactivity**       | Minimal                         | Enhanced for interactive use           |
| **POSIX Compliance**    | Fully POSIX-compliant            | Mostly POSIX-compliant with extensions |
| **Command History**     | No                              | Yes                                    |
| **Tab Completion**      | No                              | Yes                                    |
| **Performance**         | Slightly faster (lightweight)    | Slightly slower (feature-rich)         |

### Summary

- Use **`sh`** if you need to write portable, lightweight scripts that can run on any Unix-like system, especially where only basic functionality is required.
- Use **`bash`** for interactive terminal work and for scripting when you need more advanced features and don't mind relying on it being available (which is common in modern Linux distributions).
