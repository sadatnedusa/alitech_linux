# sed - notes - part 1
## How to use the `sed` command in Linux. 

- How the `sed` command can be used for line manipulation in files, including deleting specific or multiple lines, or ranges of lines, and removing empty lines. 


### **1) How to delete the first line from a file?**
- **Syntax**: `sed 'Nd' file`
   - `N`: Denotes the `Nth` line in a file.
   - `d`: Indicates the deletion of the line.

- **Example**:
  ```bash
  # sed '1d' sed-demo.txt
  ```
  **After deletion**:
  ```
  2 Unix Operating System
  3 RHEL
  4 Red Hat
  5 Fedora
  6 Arch Linux
  7 CentOS
  8 Debian
  9 Ubuntu
  10 openSUSE
  ```

### **2) How to delete the last line from a file?**
- **Syntax**: `sed '$d' file`  
  (`$` denotes the last line of the file.)

- **Example**:
  ```bash
  # sed '$d' sed-demo.txt
  ```
  **After deletion**:
  ```
  1 Linux Operating System
  2 Unix Operating System
  3 RHEL
  4 Red Hat
  5 Fedora
  6 Arch Linux
  7 CentOS
  8 Debian
  9 Ubuntu
  ```

- **To delete the first and last lines from the file**:
  ```bash
  # sed '1d;$d' sed-demo.txt
  ```
  **After deletion**:
  ```
  2 Unix Operating System
  3 RHEL
  4 Red Hat
  5 Fedora
  6 Arch Linux
  7 CentOS
  8 Debian
  9 Ubuntu
  ```

### **3) Deleting a particular line from a file**
- **To delete the third line**:
  ```bash
  # sed '3d' sed-demo.txt
  ```
  **After deletion**:
  ```
  1 Linux Operating System
  2 Unix Operating System
  4 Red Hat
  5 Fedora
  6 Arch Linux
  7 CentOS
  8 Debian
  9 Ubuntu
  10 openSUSE
  ```

### **4) Deleting a range of lines**
- **Syntax**: `sed 'MIN,MAXd' file`  
  Removes lines from `MIN` to `MAX`.

- **Example** (removes lines 5 to 7):
  ```bash
  # sed '5,7d' sed-demo.txt
  ```
  **After deletion**:
  ```
  1 Linux Operating System
  2 Unix Operating System
  3 RHEL
  4 Red Hat
  8 Debian
  9 Ubuntu
  10 openSUSE
  ```

### **5) How to remove multiple lines**
- **Example** (removes 1st, 5th, 9th, and last lines):
  ```bash
  # sed '1d;5d;9d;$d' sed-demo.txt
  ```
  **After deletion**:
  ```
  2 Unix Operating System
  3 RHEL
  4 Red Hat
  6 Arch Linux
  7 CentOS
  8 Debian
  ```

### **5.a) Deleting lines other than the specified range**
- **Example** (keeps lines 3 to 6, deletes the rest):
  ```bash
  # sed '3,6!d' sed-demo.txt
  ```
  **After deletion**:
  ```
  3 RHEL
  4 Red Hat
  5 Fedora
  6 Arch Linux
  ```

- **To delete all lines except the first line**:
  ```bash
  # sed '1!d' sed-demo.txt
  ```
  **After deletion**:
  ```
  1 Linux Operating System
  ```

- **To delete all lines except the last line**:
  ```bash
  # sed '$!d' sed-demo.txt
  ```
  **After deletion**:
  ```
  10 openSUSE
  ```

### **6) Deleting empty or blank lines**
- **Example**:
  ```bash
  # sed '/^$/d' sed-demo.txt
  ```
  **After deletion**:
  ```
  1 Linux Operating System
  2 Unix Operating System
  3 RHEL
  4 Red Hat
  5 Fedora
  6 Arch Linux
  7 CentOS
  8 Debian
  9 Ubuntu
  10 openSUSE
  ```

### **Displaying specific lines from a file**
- **Syntax**: `sed -n 'MIN,MAXp' file`  
  Displays lines from `MIN` to `MAX`.

- **Examples**:
  ```bash
  sed -n '1543,1684'p lspci
  sed -n '2036,2149'p lspci
  ```
