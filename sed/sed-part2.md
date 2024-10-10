# sed - notes - part 2

- The second part of your guide demonstrates more advanced `sed` command techniques for removing lines based on matching patterns, characters, and ranges.
- Here’s a detailed breakdown of the commands and their usage:

---

### **7) Removing lines that contain a pattern**
- **Example**: To remove lines matching the pattern "System" from the file:
  ```bash
  # sed '/System/d' sed-demo.txt
  ```
  **After deletion**:
  ```
  3 RHEL
  4 Red Hat
  5 Fedora
  6 Arch Linux
  7 CentOS
  8 Debian
  9 Ubuntu
  10 openSUSE
  ```

### **8) Deleting lines that contain one of several strings**
- **Example**: To delete lines that contain either "System" or "Linux":
  ```bash
  # sed '/System\|Linux/d' sed-demo.txt
  ```
  **After deletion**:
  ```
  3 RHEL
  4 Red Hat
  5 Fedora
  7 CentOS
  8 Debian
  9 Ubuntu
  10 openSUSE
  ```

### **9) Deleting lines that begin with a specific character**
- **Example**: To delete all lines starting with "R":
  ```bash
  # sed '/^R/d' sed-demo-1.txt
  ```
  **After deletion**:
  ```
  Linux Operating System
  Unix Operating System
  Fedora
  debian
  ubuntu
  Arch Linux - 1
  2 - Manjaro
  3 4 5 6
  ```

- **Example**: To delete all lines starting with "R" or "F":
  ```bash
  # sed '/^[RF]/d' sed-demo-1.txt
  ```
  **After deletion**:
  ```
  Linux Operating System
  Unix Operating System
  debian
  ubuntu
  Arch Linux - 1
  2 - Manjaro
  3 4 5 6
  ```

- **Example**: To delete lines starting with "L" and ending with "System":
  ```bash
  # sed '/^(L).*(System)/d' sed-demo-1.txt
  ```
  **After deletion**:
  ```
  Unix Operating System
  RHEL
  Red Hat
  Fedora
  debian
  ubuntu
  Arch Linux - 1
  2 - Manjaro
  3 4 5 6
  ```

### **10) Removing lines that end with a specified character**
- **Example**: To delete lines ending with "m":
  ```bash
  # sed '/m$/d' sed-demo.txt
  ```
  **After deletion**:
  ```
  3 RHEL
  4 Red Hat
  5 Fedora
  6 Arch Linux
  7 CentOS
  8 Debian
  9 Ubuntu
  10 openSUSE
  ```

- **Example**: To delete lines ending with either "x" or "m":
  ```bash
  # sed '/[xm]$/d' sed-demo.txt
  ```
  **After deletion**:
  ```
  3 RHEL
  4 Red Hat
  5 Fedora
  7 CentOS
  8 Debian
  9 Ubuntu
  10 openSUSE
  ```

### **11) Deleting all lines that start with uppercase**
- **Example**: To delete lines starting with an uppercase letter:
  ```bash
  # sed '/^[A-Z]/d' sed-demo-1.txt
  ```
  **After deletion**:
  ```
  debian
  ubuntu
  2 - Manjaro
  3 4 5 6
  ```

### **12) Deleting a pattern in a specified range**
- **Example**: To delete the pattern "Linux" only from lines 1 to 6:
  ```bash
  # sed '1,6{/Linux/d;}' sed-demo.txt
  ```
  **After deletion**:
  ```
  2 Unix Operating System
  3 RHEL
  4 Red Hat
  5 Fedora
  7 CentOS
  8 Debian
  9 Ubuntu
  10 openSUSE
  ```

- **Example**: To delete the last line only if it contains the pattern "openSUSE":
  ```bash
  # sed '${/openSUSE/d;}' sed-demo.txt
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

### **13) Deleting pattern-matching lines and the next line**
- **Example**: To delete a line containing "System" and the next line:
  ```bash
  # sed '/System/{N;d;}' sed-demo.txt
  ```
  **After deletion**:
  ```
  3 RHEL
  4 Red Hat
  5 Fedora
  6 Arch Linux
  7 CentOS
  8 Debian
  9 Ubuntu
  10 openSUSE
  ```

- **Example**: To delete lines starting from "CentOS" and all subsequent lines till the end:
  ```bash
  # sed '/Centos/,$d' sed-demo.txt
  ```
  **After deletion**:
  ```
  1 Linux Operating System
  2 Unix Operating System
  3 RHEL
  4 Red Hat
  5 Fedora
  6 Arch Linux
  ```

### **14) Deleting lines that contain digits**
- **Example**: To delete all lines containing digits:
  ```bash
  # sed '/[0-9]/d' sed-demo-1.txt
  ```
  **After deletion**:
  ```
  Linux Operating System
  Unix Operating System
  RHEL
  Red Hat
  Fedora
  debian
  ubuntu
  ```

- **Example**: To delete lines that begin with digits:
  ```bash
  # sed '/^[0-9]/d' sed-demo-1.txt
  ```
  **After deletion**:
  ```
  Linux Operating System
  Unix Operating System
  RHEL
  Red Hat
  Fedora
  debian
  ubuntu
  Arch Linux - 1
  ```

- **Example**: To delete lines ending with digits:
  ```bash
  # sed '/[0-9]$/d' sed-demo-1.txt
  ```
  **After deletion**:
  ```
  Linux Operating System
  Unix Operating System
  RHEL
  Red Hat
  Fedora
  debian
  ubuntu
  2 - Manjaro
  ```

### **15) Deleting lines that contain alphabetic characters**
- **Example**: To delete all lines containing alphabetic characters:
  ```bash
  # sed '/[A-Za-z]/d' sed-demo-1.txt
  ```
  **After deletion**:
  ```
  3 4 5 6
  ```
