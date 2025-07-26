## 🔧 What Is a Pipe?

A **pipe** is a **form of Inter-Process Communication (IPC)** that allows the **output (stdout)** of one process to become the **input (stdin)** of another.

### Syntax:

```bash
command1 | command2
```

* `command1` produces output.
* `command2` reads that output as input.

---

## 🧠 How It Works Internally (Step-by-Step)

### 1. **Creation of Pipe**

When you use `|`, the shell (like `bash`) creates a **pipe** using the `pipe()` system call:

```c
int pipe(int fd[2]);
```

This creates **two file descriptors**:

* `fd[0]` — for reading (input to second command)
* `fd[1]` — for writing (output from first command)

```bash
   command1            command2
   ---------           ---------
  stdout → fd[1] ────→ fd[0] → stdin
```

### 2. **Forking**

The shell **forks** two child processes:

* One for `command1`
* One for `command2`

### 3. **Redirection of File Descriptors**

In the child processes:

* `command1` closes `fd[0]` and duplicates `fd[1]` to `stdout` (`dup2(fd[1], STDOUT_FILENO)`)
* `command2` closes `fd[1]` and duplicates `fd[0]` to `stdin` (`dup2(fd[0], STDIN_FILENO)`)

### 4. **Execution**

Each child process is now connected through the pipe. `command1` writes to the pipe, and `command2` reads from it.

---

## 🔁 Example

```bash
ls -l | grep ".cpp"
```

### Breakdown:

1. `ls -l` generates a list of files.
2. That output is sent through the pipe.
3. `grep ".cpp"` reads from the pipe and filters `.cpp` files.

---

## 🧪 Behind-the-Scenes Using `strace`

You can trace how the pipe works using `strace`:

```bash
strace -f -e trace=pipe,dup2,execve bash -c 'ls -l | grep ".cpp"'
```

You'll see:

* `pipe()` creating file descriptors
* `dup2()` redirecting `stdout` and `stdin`
* `execve()` running the actual commands

---

## 🎨 Visualization

```
+-------------+       pipe       +-------------+
|   command1  | ───────────────> |   command2  |
| (producer)  |                 | (consumer)  |
+-------------+                 +-------------+
       |                              |
     stdout                         stdin
```

---

## 🧱 Characteristics of Pipes

| Feature          | Details                                              |
| ---------------- | ---------------------------------------------------- |
| Direction        | **Unidirectional** – flows from left to right only   |
| File Descriptors | Uses file descriptors internally (`fd[0]`, `fd[1]`)  |
| Buffer Size      | Typically 64KB or 1MB depending on the system        |
| Blocking         | Write blocks if buffer is full; read blocks if empty |

---

## 🧵 Types of Pipes

| Type                  | Description                                                 |
| --------------------- | ----------------------------------------------------------- |
| **Anonymous Pipe**    | Created with `pipe()` – used between parent-child processes |
| **Named Pipe (FIFO)** | Created with `mkfifo` – exists as a file on filesystem      |

```bash
mkfifo mypipe
echo "hello" > mypipe
cat < mypipe
```

---

## 🔁 Chaining Pipes

You can connect multiple commands:

```bash
ps aux | grep apache | awk '{print $2}' | xargs kill -9
```

---

## 🛑 Limitations

* Pipes are **unidirectional**
* Can't be used between unrelated processes (unless using **named pipes**)
* Limited buffer size
* Not suitable for **bidirectional communication** (use socketpair or other IPC)

---

## 🔍 Summary

| Concept       | Description                                            |                |
| ------------- | ------------------------------------------------------ | -------------- |
| System Call   | `pipe(int fd[2])`                                      |                |
| Purpose       | Connect output of one process to input of another      |                |
| Mechanism     | File descriptors with redirection using `dup2()`       |                |
| Usage Example | \`cat file.txt                                         | grep "hello"\` |
| Scope         | Within same shell session; uses parent-child processes |                |

---


