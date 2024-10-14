# **`tee` Command

- The `tee` command in Linux is used to **read from standard input (stdin)** and **write to both standard output (stdout)** and one or more files simultaneously. It effectively "tees" the input, allowing you to capture the output of a command in a file **while still displaying it in the terminal**.

## **Syntax**
```bash
command | tee [options] [file...]
```
- **command**: The command whose output you want to capture.
- **file**: The file(s) where the output will be written.
- **options**: Modifiers for the `tee` command.

## **How `tee` Works**
- **Reads from stdin**: Typically used with a pipe (`|`) to capture the output of a command.
- **Writes to both stdout and file(s)**: The output is displayed on the terminal and also written to the specified file(s).

## **Example 1: Basic Use of `tee`**
```bash
ls -l | tee output.txt
```
- **Explanation**: The output of `ls -l` is displayed in the terminal **and** saved to `output.txt`.
  
## **Output in terminal:**
```
total 0
-rw-r--r-- 1 user group 0 Oct 14 09:22 file1.txt
-rw-r--r-- 1 user group 0 Oct 14 09:22 file2.txt
```

## **Contents of `output.txt`:**
```
total 0
-rw-r--r-- 1 user group 0 Oct 14 09:22 file1.txt
-rw-r--r-- 1 user group 0 Oct 14 09:22 file2.txt
```

## **Common Options with `tee`**

- **`-a` (append)**: Append the output to the file rather than overwriting it.
- **`-i` (ignore interrupt signals)**: Ignore interrupts like `Ctrl+C` (useful in long-running commands).

## **Example 2: Appending to a File with `tee -a`**
```bash
echo "New log entry" | tee -a log.txt
```
- **Explanation**: This appends "New log entry" to `log.txt` without overwriting the existing contents.

## **Contents of `log.txt` (after appending):**
```
Old log entry
New log entry
```

## **Example 3: Using `tee` with Multiple Files**
```bash
df -h | tee file1.txt file2.txt
```
- **Explanation**: The output of `df -h` is written to both `file1.txt` and `file2.txt`, while also being displayed on the terminal.

#### **Example 4: Ignoring Interrupts with `tee -i`**
```bash
ping google.com | tee -i ping_output.txt
```
- **Explanation**: Runs `ping` and saves the output to `ping_output.txt`. If you press `Ctrl+C` to stop the command, `tee` will ignore the interrupt and continue capturing output until the `ping` command ends.

#### **Practical Use Cases**

1. **Logging Command Output**: Save the output of a command to a log file while still viewing it in real-time in the terminal.
   ```bash
   make 2>&1 | tee build.log
   ```

2. **Capturing Error Messages**: Capture both `stdout` and `stderr` using `tee` with redirection.
   ```bash
   ./myscript.sh 2>&1 | tee script_output.log
   ```

3. **Monitoring System Information**: For long-running system monitoring, like tracking disk usage, you can use `tee` to log and display the data simultaneously.
   ```bash
   df -h | tee -a disk_usage.log
   ```

4. **Command Pipelines**: `tee` can be used in the middle of a command pipeline to capture intermediate output.
   ```bash
   ls -l | tee intermediate_output.txt | grep "Oct"
   ```

#### **Example 5: Using `tee` in a Pipeline**
```bash
ls -l | tee filelist.txt | wc -l
```
- **Explanation**: The output of `ls -l` is saved to `filelist.txt`, and then passed to `wc -l` to count the number of lines.

#### **Difference Between `tee` and Redirection**

- **Redirection** (`>`, `>>`) only saves the output to a file, without displaying it in the terminal. For example:
  ```bash
  ls -l > output.txt
  ```
  This writes the output to `output.txt`, but nothing is shown in the terminal.
  
- **`tee`** shows the output **in the terminal** and writes it to the file(s) simultaneously:
  ```bash
  ls -l | tee output.txt
  ```

#### **Example 6: Combining Redirection and `tee`**
```bash
(ls -l && echo "Directory listed") | tee output.txt
```
- **Explanation**: Combines two commands using `&&` and pipes the output to `tee`. Both the directory listing and the custom message "Directory listed" are saved to `output.txt` and shown in the terminal.

---

### **Summary of Key Points**
- **`tee`** allows you to write the output of a command to both the terminal and one or more files.
- **`-a`**: Use this option to append to a file instead of overwriting it.
- **`-i`**: Ignores interrupt signals like `Ctrl+C`.
- `tee` is especially useful in logging, debugging, and real-time output capture scenarios.
