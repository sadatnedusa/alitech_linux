## "free -m" command notes

The `free -m` command in Linux is used to display the system’s memory usage, showing the amount of used, free, shared, and cached memory in the system.
The `-m` option specifically formats the output in **megabytes (MB)** for easier reading, as opposed to the default output, which is in kilobytes.

The `free -m` command and its output:

### Command:
```bash
free -m
```

### Sample Output:
```bash
              total        used        free      shared  buff/cache   available
Mem:           8032         2436        3241          80        3355        5193
Swap:          2048          512        1536
```

### Explanation of Each Column:
#### **Mem:**
- **total**: The total amount of physical RAM (random access memory) installed on the system.
- **used**: The amount of RAM that is currently being used by the system (including by running processes and the OS itself).
- **free**: The amount of unused RAM that is available for new processes or applications.
- **shared**: The memory that is shared between different processes. This is typically used by inter-process communication (IPC) mechanisms.
- **buff/cache**: The memory used by the kernel for buffers and caches. Linux uses free RAM for caching to speed up access to frequently used data (e.g., file system data).
- **available**: The amount of memory that is available for starting new processes without swapping. It includes free memory and the memory that can be reclaimed from buffers/cache when needed.

#### **Swap:**
- **total**: The total amount of swap space available on the system. Swap is space on a disk used to simulate extra RAM when physical memory is exhausted.
- **used**: The amount of swap space currently being used.
- **free**: The amount of swap space that is not in use.

### Key Points:
1. **Physical RAM Usage:**
   - `used`: Shows how much memory is being actively used by processes, but it also includes memory used for caching. So, the system may not be entirely "out of memory" even if this value is high because Linux reclaims memory used for cache when needed.
   - `free`: Shows memory that is not in use. A low `free` value is not always a problem because Linux efficiently uses RAM for caching and buffers, which can be freed if needed.

2. **Buffers and Cache:**
   - `buff/cache`: Memory that is being used to store data for faster access but can be freed if more memory is required by running applications. This value may be high if the system is actively caching data.
   - `available`: Unlike `free`, which only shows truly unused memory, `available` provides a better estimate of how much memory can be used for new processes without relying on swap space.

3. **Swap Space:**
   - Swap is used when the system runs out of physical memory. If the system starts swapping heavily, it can lead to performance degradation because disk access is much slower than RAM.
   - Ideally, the `used` swap value should be low, indicating that the system is able to operate mostly in physical memory.

### Practical Example:
If the system shows high `used` memory but a high `available` value, it likely means that the system is actively using RAM for caching, which is not a problem because that memory can be freed up if more applications need memory.

On the other hand, if the `used` memory is high and `available` is low, this could indicate that the system is under memory pressure and might start swapping, which could affect performance.

### Summary:
The `free -m` command is a useful tool for checking the memory status on a Linux system, providing a clear overview of the total, used, free, and available memory, as well as swap space usage. 
Using this command regularly can help system administrators monitor memory usage and diagnose potential performance issues related to insufficient memory.

---
## Notice that the `total`, `used`, `free`, and `available` figures in the output of `free -m` do not always seem to match perfectly. 
   Here's an explanation of how these values are derived and why it may appear that they don't directly add up:

### Sample Output:
```
              total        used        free      shared  buff/cache   available
Mem:           8032         2436        3241          80        3355        5193
```

### Key Columns:
- **total**: The total physical RAM on the system.
- **used**: The memory currently being used by the system.
- **free**: The unused memory that is not allocated for any processes or caches.
- **buff/cache**: Memory used for file system buffers and cache. This memory is not actively used by processes but can be reclaimed if necessary.
- **available**: The memory that can be used by new processes without swapping, which includes both free memory and reclaimable memory from buffers and cache.

### Why They Don’t Add Up:
1. **Reclaimable Buffers and Cache:**
   - The **`buff/cache`** memory is not included in the `free` value because it’s used for caching and buffering data that can be quickly released if needed. However, it is still considered "in use" by the system. This is a key reason why `used + free + buff/cache` might not directly match `total`.

2. **Available Memory:**
   - The **`available`** value is a more accurate measure of how much memory is free or can be reclaimed by the system. It’s not just the `free` memory, but also the memory that is currently being used for buffers/cache, which can be freed up if needed.
   - So, **`available`** can be much higher than the sum of `free` and `buff/cache`, as it includes memory that’s not technically free but can be easily reclaimed.

### Breakdown:
- **Total Memory**: `8032 MB`
- **Used Memory**: `2436 MB` (includes memory used by processes, kernel, buffers, and caches)
- **Free Memory**: `3241 MB` (unused, but this is not the same as the available memory for new processes)
- **Buffers/Cache**: `3355 MB` (memory used for caches, which can be reclaimed if needed)
- **Available Memory**: `5193 MB` (includes both free memory and reclaimable buffers/cache)

### Formula for Available Memory:
**Available = Free + Buffers/Cache**  
In your case:
```
Available = 3241 MB (free) + 3355 MB (buff/cache) = 5193 MB (available)
```

This explains why the values don’t add up exactly in a simple manner but still make sense when you understand how Linux manages memory with caching and buffers. 
The system uses free memory for caching to improve performance, but that memory can be reclaimed if more memory is needed by processes.

### Conclusion:
The `free -m` output is designed to show a realistic view of memory usage. The **`used`** memory includes both actively used memory and memory used for caches and buffers.
The **`available`** memory includes both free memory and memory that can be freed from the cache. Therefore, the figures may not match exactly, but they do provide a comprehensive view of your system’s memory status.

---

##  To learn top command and all the options in detail. Specially PR NI ad RES columns in detail

The `top` command in Linux provides a real-time view of the system's resource usage, including CPU, memory, and process information.
It is widely used for monitoring system performance and identifying processes that consume significant resources.

### Basic `top` Command Overview

When you run the `top` command, you'll see a display of the current processes running on your system, along with summary information about system resources like CPU, memory, and swap usage.

```
top
```

The output is divided into two parts:
1. **Summary area**: This section displays overall system statistics, including CPU, memory, and swap usage.
2. **Task area**: This section lists the processes running on your system, showing detailed information about each process.

### Important Columns in `top` Output

The key columns displayed in the task area of `top`:

1. **PID**: Process ID – The unique identifier assigned to each running process.
2. **USER**: The user who owns the process.
3. **PR**: Priority – This column indicates the process priority. Lower values represent higher priorities.
4. **NI**: Nice Value – A value that adjusts the priority of a process. It can range from -20 (highest priority) to 19 (lowest priority). The default value is 0. A negative value makes a process "nicer," i.e., it gets more CPU time. A positive value means the process gets less CPU time.
5. **VIRT**: Virtual Memory – The total amount of memory used by the process, including code, data, shared libraries, and swapped-out memory.
6. **RES**: Resident Memory – The non-swapped physical memory the process is using. It’s the amount of RAM the process is currently using.
7. **SHR**: Shared Memory – The amount of memory shared with other processes. Typically, shared memory is used for things like libraries loaded by multiple processes.
8. **S**: Status – The current status of the process. Common statuses include:
   - `S` for sleeping
   - `R` for running
   - `Z` for zombie
   - `T` for stopped
9. **%CPU**: CPU Usage – The percentage of CPU time the process is consuming.
10. **%MEM**: Memory Usage – The percentage of physical memory the process is consuming.
11. **TIME+**: Total CPU time – The total time the process has been running.
12. **COMMAND**: The name of the command or executable running the process.

### Detailed Explanation of PR, NI, and RES Columns

#### 1. **PR (Priority)**:
   - This column shows the priority of a process, which determines how much CPU time it gets relative to other processes. The priority value can be affected by the **nice value** and the process's state.
   - The priority is calculated by the kernel and is influenced by factors such as whether the process is interactive, CPU-bound, or I/O-bound.
   - Values for `PR` range from **-20** to **20**, with lower values representing higher priority.

   **Examples**:
   - **20**: Default priority for most processes.
   - **-20**: Higher priority, meaning it gets more CPU time relative to others.

#### 2. **NI (Nice Value)**:
   - The **nice value** determines the process's priority adjustment. The range of nice values is from **-20** (highest priority) to **+19** (lowest priority).
   - The nice value is used to influence the scheduler's decision on which process gets CPU time. A higher **nice value** makes a process "nicer" (i.e., it uses less CPU time), while a lower **nice value** makes the process "greedier" (i.e., it gets more CPU time).
   - Only the root user can set the nice value to **-20**, and users can set values from **0** to **19**.

   **Examples**:
   - **0**: The default nice value.
   - **-10**: A process with higher priority will receive more CPU time.
   - **10**: A process with lower priority will use less CPU time.

   To change the nice value of a running process, you can use the `renice` command:

   ```bash
   renice -n -10 -p <PID>
   ```

#### 3. **RES (Resident Memory)**:
   - The **RES** column shows the **resident memory** the process is using, which is the portion of the process’s memory that is held in RAM (as opposed to being swapped out to disk).
   - It includes memory used by the process itself, plus any shared memory used by other processes.
   - This column is especially useful for identifying memory-intensive processes because it tells you how much physical RAM the process is using at a given moment.
   - **RES** doesn't include the memory used by the kernel for buffers and cache.

   **Examples**:
   - If a process is consuming a large amount of resident memory, it might indicate a memory leak or that the process is handling large amounts of data.

### Using `top` Command with Additional Options

You can also use various options with the `top` command to modify the display or filter information:

- **To display `top` in a batch mode** (useful for scripts):
  
  ```bash
  top -b -n 1
  ```

- **To filter by process name**:
  
  ```bash
  top -p <PID>
  ```

- **To sort processes by memory usage**:
  
  Press **M** while inside the `top` command interface. This will sort processes by memory usage, with the most memory-consuming processes listed first.

- **To sort by CPU usage**:
  
  Press **P** to sort processes by CPU usage, with the processes consuming the most CPU time at the top.

- **To change the update frequency**:
  
  Use the `-d` option to set the delay between updates:
  
  ```bash
  top -d 2  # Update every 2 seconds
  ```

### Example of `top` Output (with PR, NI, and RES columns):

```
top - 15:50:18 up 1 day,  3:15,  3 users,  load average: 0.20, 0.15, 0.10
Tasks: 143 total,   1 running, 142 sleeping,   0 stopped,   0 zombie
%Cpu(s):  5.3 us,  2.7 sy,  0.0 ni, 91.3 id,  0.7 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :   8032.2 total,   2436.0 used,   3241.0 free,    335.5 buff/cache
MiB Swap:   2048.0 total,      0.0 used,   2048.0 free.    5193.0 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND
  1853 root      20   0  197848   5704   3016 S  2.3  0.1   0:10.33 systemd
  1845 root      20   0  134364   4608   2944 S  1.0  0.1   0:04.56 networkd
  1567 user      20   0  150000   1000    600 S  0.5  0.0   0:01.23 myapp
```

In this example:
- The process with PID 1853 has a **PR** of 20 (default priority) and **NI** of 0 (default nice value).
- The process with PID 1567 has a **RES** value of 1000 KB of resident memory, which tells us how much physical RAM is being used by that process.

### Conclusion

Understanding the `top` command and the **PR**, **NI**, and **RES** columns is essential for effective system monitoring and performance tuning. By analyzing these columns, you can:
- Identify processes with high CPU or memory usage.
- Adjust priorities with nice values to optimize system performance.
- Ensure that processes are using memory efficiently without causing system overloads or starvation.

By becoming familiar with the `top` command's options and columns, you can gain deeper insights into the system's performance and make informed decisions to improve system resource management.

