## grep one liner

- The `grep` command is  powerful tool that can help you quickly search through text, files, or outputs.
- Below, a list of `grep` one-liners.

- These `grep` one-liners will help you with tasks ranging from simple searches to complex text manipulations.
`grep` is highly versatile, so you can mix and match these options to make your workflow more efficient.

### **1. Basic String Search**
Search for a specific word in a file.

**Search for the word "apple" in `file.txt`:**
```bash
grep 'apple' file.txt
```

### **2. Case-Insensitive Search**
Make the search case-insensitive.

**Search for "apple" in any case:**
```bash
grep -i 'apple' file.txt
```

### **3. Search for Whole Words**
Only match whole words (not substrings).

**Search for the whole word "apple" (not "applepie"):**
```bash
grep -w 'apple' file.txt
```

### **4. Count Occurrences**
Count how many times a pattern appears in a file.

**Count the number of times "apple" appears:**
```bash
grep -c 'apple' file.txt
```

### **5. Show Line Numbers**
Show the line numbers where the pattern appears.

**Show line numbers for each occurrence of "apple":**
```bash
grep -n 'apple' file.txt
```

### **6. Invert Match (Exclude Pattern)**
Exclude lines that contain a certain pattern.

**Show all lines except those containing "apple":**
```bash
grep -v 'apple' file.txt
```

### **7. Search in Multiple Files**
Search for a pattern in multiple files.

**Search for "apple" in all `.txt` files in the current directory:**
```bash
grep 'apple' *.txt
```

### **8. Search Recursively**
Search for a pattern recursively through all files in a directory.

**Search for "apple" in all files under the current directory:**
```bash
grep -r 'apple' .
```

### **9. Display Only Matching Text (No Entire Line)**
Show just the matching part of the line instead of the entire line.

**Display only the matching text for "apple":**
```bash
grep -o 'apple' file.txt
```

### **10. Search for Multiple Patterns**
Search for multiple patterns in a file.

**Search for either "apple" or "banana":**
```bash
grep -E 'apple|banana' file.txt
```

### **11. Search with Regular Expressions**
Use regular expressions to match more complex patterns.

**Search for any line that contains either "apple" or "orange":**
```bash
grep -E 'apple|orange' file.txt
```

### **12. Show Context Around Match**
Display lines before and after the match for context.

**Show 2 lines before and 2 lines after the match for "apple":**
```bash
grep -C 2 'apple' file.txt
```

**Show only 1 line before and after the match:**
```bash
grep -B 1 -A 1 'apple' file.txt
```

### **13. Show Files That Contain a Pattern**
Search and display the names of files that contain a specific pattern.

**Search all `.txt` files for "apple" and show only the filenames:**
```bash
grep -l 'apple' *.txt
```

### **14. Search for Empty Lines**
Find empty lines in a file.

**Find empty lines in `file.txt`:**
```bash
grep -n '^$' file.txt
```

### **15. Search for Lines that Do Not Contain a Pattern**
Exclude lines that do not contain a pattern.

**Show lines that do *not* contain "apple":**
```bash
grep -L 'apple' *.txt
```

### **16. Search for Multiple Words**
Search for lines that contain multiple words.

**Search for lines that contain both "apple" and "banana":**
```bash
grep 'apple' file.txt | grep 'banana'
```

**Alternatively, using `grep` with a regular expression:**
```bash
grep -E 'apple.*banana|banana.*apple' file.txt
```

### **17. Search for Lines Matching a Pattern in a Specific Field**
Use `grep` along with `awk` or `cut` to search specific columns.

**Find lines where the second field (separated by spaces) contains "apple":**
```bash
awk '{if ($2 == "apple") print}' file.txt
```

### **18. Match Specific File Extensions**
Search within files with a specific extension.

**Search for "apple" only in `.log` files:**
```bash
grep 'apple' *.log
```

### **19. Search for Pattern in Compressed Files**
Search inside compressed files like `.gz` or `.bz2`.

**Search for "apple" in a `.gz` compressed file:**
```bash
zgrep 'apple' file.txt.gz
```

**Search in `.bz2` compressed files:**
```bash
bzgrep 'apple' file.txt.bz2
```

### **20. Use `grep` with `ps` or `top` to Find Running Processes**
Search for specific processes running on your system.

**Find processes related to "nginx":**
```bash
ps aux | grep 'nginx'
```

**Find processes related to "python" but exclude the `grep` command itself:**
```bash
ps aux | grep '[p]ython'
```

### **21. Search for a Pattern in Logs**
Find specific error or warning messages in system logs.

**Search for "error" in `/var/log/syslog`:**
```bash
grep 'error' /var/log/syslog
```

### **22. Exclude Certain Files or Directories from Recursively Searching**
Search for a pattern in all files, but exclude certain files or directories.

**Search for "apple" but exclude files in the `logs/` directory:**
```bash
grep -r --exclude-dir=logs 'apple' .
```

### **23. Use `grep` with `find`**
Combine `grep` with `find` to search for patterns in specific files.

**Find all `.txt` files modified within the last 7 days and search for "apple":**
```bash
find . -name "*.txt" -mtime -7 -exec grep 'apple' {} \;
```

### **24. Search for Lines Containing a Number (Using Regular Expression)**
Search for lines that contain numbers.

**Find lines containing numbers (digits) in a file:**
```bash
grep '[0-9]' file.txt
```

### **25. Search for a Pattern and Display Only the Count**
Instead of printing matching lines, just show how many lines match the pattern.

**Count the number of lines containing "apple" in a file:**
```bash
grep -c 'apple' file.txt
```

### **26. Search for a Pattern and Show the First Match**
If you want to stop after finding the first match:

**Show the first line that contains "apple":**
```bash
grep -m 1 'apple' file.txt
```

### **27. Search with Color Highlighting**
Highlight matches in the output for better readability.

**Highlight the matches of "apple" in `file.txt`:**
```bash
grep --color=auto 'apple' file.txt
```

### **28. Search for a Pattern and Display the Line's Position**
Find the position of the matched text within each line.

**Show the position of "apple" in each line:**
```bash
grep -b 'apple' file.txt
```

### **29. Search for Files Modified in the Last X Days and Match a Pattern**
**Find all files modified in the last 7 days and search for "apple":**
```bash
find . -type f -mtime -7 -exec grep -l 'apple' {} \;
```

### **30. Search for Pattern with Exclusion of a Specific Line**
You can search for a pattern but exclude specific lines.

**Find all lines containing "apple" except those that also contain "banana":**
```bash
grep 'apple' file.txt | grep -v 'banana'
```

