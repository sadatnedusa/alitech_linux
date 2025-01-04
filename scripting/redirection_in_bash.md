### Redirection Symbols in Bash

In Bash scripting, **redirection symbols** are used to control the input and output of commands. Here are the main symbols:

1. **`>`**: Redirects standard output (stdout) to a file or device, overwriting its contents.
   - Example: `echo "Hello" > file.txt` writes "Hello" to `file.txt`.

2. **`>>`**: Redirects stdout to a file or device, appending to its contents.
   - Example: `echo "Hello" >> file.txt` appends "Hello" to `file.txt`.

3. **`<`**: Redirects standard input (stdin) from a file or device.
   - Example: `wc -l < file.txt` counts the number of lines in `file.txt`.

4. **`2>`**: Redirects standard error (stderr) to a file or device.
   - Example: `command 2> error.log` writes error messages to `error.log`.

5. **`2>>`**: Redirects stderr to a file, appending to its contents.
   - Example: `command 2>> error.log` appends error messages to `error.log`.

6. **`&>`**: Redirects both stdout and stderr to the same file or device.
   - Example: `command &> output.log` writes both output and error messages to `output.log`.

7. **`2>&1`**: Redirects stderr to the same destination as stdout.
   - Example: `command > output.log 2>&1` combines stdout and stderr into `output.log`.

8. **`|`**: Pipes stdout of one command into the stdin of another.
   - Example: `ls | grep file` sends the output of `ls` to `grep`.

9. **`/dev/null`**: A special file that discards all input and output.
   - Example: `command > /dev/null` sends stdout to `/dev/null` (effectively hiding it).

---

### Explanation of `2>/dev/null`

This command specifically **hides error messages**:

1. **`2>`**: Redirects stderr (file descriptor `2`).
2. **`/dev/null`**: The null device discards any data written to it.

When you use `2>/dev/null` after a command, it suppresses error messages because those messages are redirected to `/dev/null`, which discards them.

#### Example:
```bash
ls non_existent_file 2>/dev/null
```
- **`ls non_existent_file`**: Tries to list a file that doesn't exist, causing an error message to be displayed.
- **`2>/dev/null`**: Hides the error message by redirecting it to `/dev/null`.

#### Use Case:
- **Quiet Operations**: Useful in scripts when you want to suppress non-critical error messages to avoid cluttering the output.

If you want to hide **both stdout and stderr**, use:
```bash
command &>/dev/null
```
