## Understanding File Descriptors.
### The Fundamentals

A **file descriptor (FD)** is a non-negative integer that represents an open file or I/O stream in Unix-like operating systems (including Linux).

File descriptors are crucial for handling input/output (I/O) in Bash and programming.

### **1. What Are File Descriptors?**

File descriptors represent:
1. **Standard Input (stdin):** File descriptor `0`.
   - Used to receive input (e.g., keyboard).
2. **Standard Output (stdout):** File descriptor `1`.
   - Used to send normal output (e.g., screen).
3. **Standard Error (stderr):** File descriptor `2`.
   - Used to send error messages (e.g., warnings).

These are automatically opened when a program starts.

### **2. Basic File Descriptors**

| FD   | Stream Name | Description                  | Default Target |
|------|-------------|------------------------------|----------------|
| `0`  | stdin       | Input to the program         | Keyboard       |
| `1`  | stdout      | Regular output from the program | Screen         |
| `2`  | stderr      | Error messages from the program | Screen         |

### **3. Using File Descriptors**

#### **3.1 Redirecting Standard Output (stdout)**
By default, stdout is written to the terminal. You can redirect it to a file using the `>` symbol:
```bash
echo "Hello, World!" > output.txt
```
- Redirects FD `1` (stdout) to `output.txt`.

#### **3.2 Redirecting Standard Error (stderr)**
To redirect error messages, use `2>`:
```bash
ls non_existent_file 2> error.log
```
- Redirects FD `2` (stderr) to `error.log`.

#### **3.3 Redirecting Both stdout and stderr**
To redirect both outputs to the same file, combine `2>&1` or use `&>`:
```bash
ls non_existent_file > output.log 2>&1
```
- Redirects both FD `1` (stdout) and FD `2` (stderr) to `output.log`.

### **4. Advanced File Descriptors**

#### **4.1 Custom File Descriptors**
You can create your own file descriptors (e.g., `FD 3`) for advanced I/O handling:
```bash
exec 3> custom_output.txt
echo "This is FD 3" >&3
exec 3>&-
```
- **`exec 3>`**: Opens FD `3` and redirects it to `custom_output.txt`.
- **`echo ... >&3`**: Writes to FD `3`.
- **`exec 3>&-`**: Closes FD `3`.

#### **4.2 Redirecting Input**
To redirect stdin, use `n<` where `n` is the file descriptor (commonly `0`):
```bash
exec 0< input.txt
cat
exec 0<&-
```
- **`exec 0< input.txt`**: Redirects stdin to read from `input.txt`.
- **`cat`**: Reads input from `input.txt` (instead of the keyboard).
- **`exec 0<&-`**: Restores stdin to its default state.

#### **4.3 Duplicating File Descriptors**
You can redirect one FD to another:
```bash
ls non_existent_file 2>&1 | tee output.log
```
- Redirects FD `2` (stderr) to FD `1` (stdout), which is piped into `tee`.

### **5. Practical Examples**

#### **5.1 Redirect stdout and stderr to Separate Files**
```bash
command > stdout.log 2> stderr.log
```

#### **5.2 Append Output**
```bash
command >> output.log 2>> error.log
```
- Appends stdout and stderr instead of overwriting.

#### **5.3 Discard Output**
```bash
command > /dev/null 2>&1
```
- Discards both stdout and stderr.

#### **5.4 Use Custom File Descriptors**
```bash
exec 3> output.log
echo "Message to FD 3" >&3
exec 3>&-
```

### **6. Summary Table**

| Symbol  | Meaning                                 | Example                                 |
|---------|-----------------------------------------|-----------------------------------------|
| `0>`    | Redirect stdin                         | `command < input.txt`                  |
| `1>`    | Redirect stdout                        | `command > output.txt`                 |
| `2>`    | Redirect stderr                        | `command 2> error.log`                 |
| `n>`    | Redirect custom FD `n`                | `exec 3> custom_output.txt`            |
| `2>&1`  | Redirect stderr to stdout             | `command > output.log 2>&1`            |
| `/dev/null` | Discard output                      | `command > /dev/null`                   |
| `exec`  | Create/manage custom FDs              | `exec 3> output.log`                   |

### **7. Key Points to Remember**
1. File descriptors `0`, `1`, and `2` are standard but you can define custom ones.
2. Always close custom FDs after use (`exec 3>&-`).
3. Redirection can combine, append, or discard outputs as needed.
4. File descriptors provide granular control over program I/O.


---

## **Why Always Close Custom File Descriptors After Use?**

When you open a custom file descriptor (e.g., `exec 3>file.txt`), it reserves system resources (like file handles) to keep the file descriptor active. 
Failing to close custom file descriptors can lead to the following issues:

1. **Resource Leaks:**
   - Each open file descriptor consumes a limited resource in the operating system. If too many file descriptors remain open, you may reach the system's limit, preventing new files or I/O streams from being opened.

2. **Unexpected Behavior:**
   - An open file descriptor can unintentionally write or read data if the shell script or program mistakenly references it.

3. **File Locks:**
   - Some operations (e.g., writing to a file) can lock the file. If a file descriptor remains open, the lock might persist unnecessarily, blocking other programs or processes from accessing the file.

### **How to Close a Custom File Descriptor**

You can close a custom file descriptor using the syntax:

```bash
exec n>&-
```

- **`n`:** The custom file descriptor you want to close.
- **`>&-`:** Indicates closure of the file descriptor.

#### Example:
```bash
exec 3> output.log  # Open FD 3 for writing to 'output.log'
echo "Logging to FD 3" >&3  # Write to FD 3
exec 3>&-  # Close FD 3
```

- **Before closure:** `FD 3` is open and connected to `output.log`.
- **After closure:** `FD 3` is released and no longer associated with the file.

### **Practical Example**

#### Without Closing the File Descriptor:
```bash
#!/bin/bash

for i in {1..1000}; do
  exec 3> output.log
  echo "Iteration $i" >&3
  # Forgetting to close FD 3
done
```
- This opens a new file descriptor (`FD 3`) in every iteration but never closes it.
- Result: **File descriptor leak**, and the script may fail when the system's file descriptor limit is reached.

#### Properly Closing the File Descriptor:
```bash
#!/bin/bash

for i in {1..1000}; do
  exec 3> output.log
  echo "Iteration $i" >&3
  exec 3>&-  # Close FD 3 after use
done
```
- Here, `FD 3` is closed after every iteration, ensuring no resource leakage.

### **Checking Open File Descriptors**

To debug or verify open file descriptors:
1. Use the `lsof` (list open files) command:
   ```bash
   lsof -p $$  # Shows open file descriptors for the current shell
   ```
   - **`$$`**: The current shell's process ID.

2. Use `/proc` to inspect file descriptors:
   ```bash
   ls -l /proc/$$/fd
   ```
   - Lists all open file descriptors for the current process.

### **Common Use Cases Requiring Closure**

1. **Temporary Log Files:**
   - Open a custom FD for writing logs, and close it when done.

   ```bash
   exec 3> temp.log
   echo "Log message" >&3
   exec 3>&-
   ```

2. **Redirecting Output for Multiple Commands:**
   - Open a custom FD for redirection and reuse it across multiple commands.

   ```bash
   exec 3> output.log
   echo "Command 1 output" >&3
   echo "Command 2 output" >&3
   exec 3>&-
   ```

### **Key Points to Remember**

1. **Always Close Custom FDs:**
   - Use `exec n>&-` to free up resources and avoid leaks.
   - Make it a habit to close FDs in scripts to maintain clean resource usage.

2. **Monitor Open FDs:**
   - Use tools like `lsof` or `/proc` to check if FDs remain open unnecessarily.

3. **Best Practices:**
   - Open custom FDs only when needed.
   - Close FDs as soon as their purpose is fulfilled.
