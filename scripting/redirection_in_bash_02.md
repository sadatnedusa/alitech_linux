### Redirection in Bash: From Basic to Advanced

Bash redirection allows you to control where the output of a command goes and where it takes its input from.
Starting from the basics and moving to advanced usage with examples.

## **1. Basic Redirection**

### **1.1 Redirecting Standard Output (stdout)**
- **Symbol:** `>`
- **Purpose:** Redirects stdout to a file. Overwrites the file if it exists.

```bash
echo "Hello, World!" > output.txt
```
- Writes "Hello, World!" to `output.txt`.

### **1.2 Appending Standard Output**
- **Symbol:** `>>`
- **Purpose:** Redirects stdout to a file. Appends to the file instead of overwriting.

```bash
echo "Append this line." >> output.txt
```
- Adds "Append this line." to `output.txt`.

### **1.3 Redirecting Standard Input (stdin)**
- **Symbol:** `<`
- **Purpose:** Takes input from a file instead of the keyboard.

```bash
wc -l < input.txt
```
- Counts the number of lines in `input.txt`.

### **1.4 Redirecting Standard Error (stderr)**
- **Symbol:** `2>`
- **Purpose:** Redirects error messages to a file.

```bash
ls non_existent_file 2> error.log
```
- Writes error messages (like "File not found") to `error.log`.

## **2. Intermediate Redirection**

### **2.1 Combining stdout and stderr**
- **Symbol:** `&>`
- **Purpose:** Redirects both stdout and stderr to the same file.

```bash
command &> output.log
```
- Saves both output and errors to `output.log`.

### **2.2 Redirecting stderr to stdout**
- **Symbol:** `2>&1`
- **Purpose:** Redirects stderr to where stdout is currently being redirected.

```bash
ls non_existent_file > output.log 2>&1
```
- Saves both stdout and stderr to `output.log`.

---

### **2.3 Discarding Output**
- **Symbol:** `/dev/null`
- **Purpose:** Sends output to `/dev/null`, effectively discarding it.

```bash
command > /dev/null 2>&1
```
- Silences both stdout and stderr.

### **2.4 Using Pipes**
- **Symbol:** `|`
- **Purpose:** Sends the stdout of one command as the stdin of another.

```bash
ls | grep ".txt"
```
- Lists files and filters for those containing `.txt`.

## **3. Advanced Redirection**

### **3.1 Appending stderr**
- **Symbol:** `2>>`
- **Purpose:** Appends stderr to a file.

```bash
command 2>> error.log
```
- Appends error messages to `error.log`.

### **3.2 Redirecting Both stdin and stdout**
- **Syntax:** `command < input_file > output_file`
- **Purpose:** Reads input from a file and writes output to another file.

```bash
sort < unsorted.txt > sorted.txt
```
- Sorts the content of `unsorted.txt` and saves it in `sorted.txt`.

### **3.3 Duplicating File Descriptors**
- **Syntax:** `n>&m`
- **Purpose:** Redirects one file descriptor to another.

```bash
exec 3>&1
ls non_existent_file 2>&1 >&3 | tee error.log
exec 3>&-
```
- Redirects stdout to a temporary file descriptor (`3`) and saves stderr to `error.log`.

### **3.4 Reading From Here Documents**
- **Symbol:** `<<`
- **Purpose:** Allows you to provide stdin inline in a script or command.

```bash
cat << EOF
This is line 1
This is line 2
EOF
```
- Prints:
  ```
  This is line 1
  This is line 2
  ```

### **3.5 Reading From Here Strings**
- **Symbol:** `<<<`
- **Purpose:** Provides a single string as stdin.

```bash
grep "line" <<< "This is a line"
```
- Searches for "line" in the given string.

### **3.6 Redirecting Open File Descriptors**
- **Syntax:** `n<file` or `n>file`
- **Purpose:** Allows advanced file descriptor manipulation.

```bash
exec 3>output.txt
echo "Using fd 3" >&3
exec 3>&-
```
- Writes "Using fd 3" to `output.txt` using file descriptor 3.

### **4. Combining Advanced Techniques**

#### **4.1 Chain Commands with Redirection**
```bash
command1 > temp.txt && command2 < temp.txt > final.txt
```
- Executes `command1`, then uses its output as input for `command2`.

#### **4.2 Debugging with Redirected Logs**
```bash
command > >(tee stdout.log) 2> >(tee stderr.log >&2)
```
- Simultaneously writes stdout and stderr to separate log files while displaying them.

### Summary Table

| Symbol   | Purpose                                  | Example                                 |
|----------|------------------------------------------|-----------------------------------------|
| `>`      | Redirect stdout (overwrite)             | `echo "text" > file.txt`                |
| `>>`     | Redirect stdout (append)                | `echo "text" >> file.txt`               |
| `<`      | Redirect stdin                          | `wc -l < file.txt`                      |
| `2>`     | Redirect stderr                         | `command 2> error.log`                  |
| `&>`     | Redirect stdout and stderr              | `command &> output.log`                 |
| `2>&1`   | Redirect stderr to stdout               | `command > output.log 2>&1`             |
| `/dev/null` | Discard output                         | `command > /dev/null`                   |
| `|`      | Pipe stdout to another command          | `ls | grep file`                        |
| `<<`     | Here document (inline stdin)            | `cat << EOF ... EOF`                    |
| `<<<`    | Here string (single-line stdin)         | `grep "text" <<< "This is a test"`      |

### Mastery Tips
- Use `tee` to split output between a file and the terminal.
- Combine `&>`, `/dev/null`, and `2>&1` to manage noisy commands.
- Practice with **file descriptors** for dynamic and flexible redirection.

