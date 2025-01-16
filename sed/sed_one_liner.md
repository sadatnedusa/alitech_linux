## sed one liner

- The `sed` (stream editor) command is incredibly powerful for text manipulation and can help automate a lot of mundane tasks.
- Below,  list of `sed` one-liners,  to help you be more productive in your daily tasks.

### 1. **Basic Substitution**
This is the most common use of `sed`, replacing text in a file.

**Replace the first occurrence of "apple" with "orange" in each line:**
```bash
sed 's/apple/orange/' filename
```

**Replace all occurrences of "apple" with "orange" in each line:**
```bash
sed 's/apple/orange/g' filename
```

### 2. **In-place Editing**
You can modify the file directly instead of printing the changes to the terminal.

**Replace "apple" with "orange" in the file (in place):**
```bash
sed -i 's/apple/orange/g' filename
```

### 3. **Case-Insensitive Substitution**
**Replace "apple" with "orange", regardless of case:**
```bash
sed 's/apple/orange/Ig' filename
```

### 4. **Delete Lines Containing a Specific Pattern**
**Delete lines containing the word "banana":**
```bash
sed '/banana/d' filename
```

### 5. **Delete Blank Lines**
**Remove empty lines from a file:**
```bash
sed '/^$/d' filename
```

### 6. **Print Specific Line(s)**
**Print the 5th line of the file:**
```bash
sed -n '5p' filename
```

**Print lines 2 to 4:**
```bash
sed -n '2,4p' filename
```

### 7. **Replace Only on Specific Line Numbers**
**Replace "apple" with "orange" only on line 3:**
```bash
sed '3s/apple/orange/' filename
```

### 8. **Multiple Commands**
**Perform multiple `sed` operations at once:**
```bash
sed -e 's/apple/orange/' -e 's/banana/grape/' filename
```

### 9. **Insert Text Before/After a Line**
**Insert "fruit" before the 3rd line:**
```bash
sed '3i\fruit' filename
```

**Append "fruit" after the 3rd line:**
```bash
sed '3a\fruit' filename
```

### 10. **Replace Text Across Multiple Files**
**Replace "apple" with "orange" across multiple files:**
```bash
sed -i 's/apple/orange/g' file1.txt file2.txt file3.txt
```

### 11. **Change Delimiters**
You can change the delimiter from `/` to something else, which is useful when working with paths.

**Using `:` as delimiter for paths:**
```bash
sed 's:/home/user:/mnt/data:' filename
```

### 12. **Extract Part of the Line**
**Extract the text before the first space:**
```bash
sed 's/ .*//g' filename
```

**Extract everything after the first space:**
```bash
sed 's/^[^ ]* //' filename
```

### 13. **Using Regular Expressions**
You can use regular expressions for more complex patterns.

**Replace any line that starts with "fruit" with "vegetable":**
```bash
sed '/^fruit/s/.*/vegetable/' filename
```

**Remove lines that contain a number (matches digits):**
```bash
sed '/[0-9]/d' filename
```

### 14. **Replace Multiple Consecutive Spaces with a Single Space**
**Replace multiple spaces with a single space in the file:**
```bash
sed 's/  */ /g' filename
```

### 15. **Change the Case of Letters**
**Convert all lowercase letters to uppercase:**
```bash
sed 's/.*/\U&/' filename
```

**Convert all uppercase letters to lowercase:**
```bash
sed 's/.*/\L&/' filename
```

### 16. **Substitute Text and Print Context**
**Replace "apple" with "orange" and show the 2 lines before and after the match:**
```bash
sed -n '/apple/{=;p;}' filename
```

### 17. **Replace Text from a Range of Lines**
**Replace "apple" with "orange" only from lines 2 to 5:**
```bash
sed '2,5s/apple/orange/g' filename
```

### 18. **Transform Text to Columns**
**Convert space-separated text into columns:**
```bash
sed 's/ /\n/g' filename
```

### 19. **Using `sed` in a Pipeline**
You can use `sed` to filter output from other commands.

**Find all files in the current directory and replace `old` with `new` in the filenames:**
```bash
ls | sed 's/old/new/g'
```

**Display the contents of a file and remove every other line:**
```bash
cat file.txt | sed 'n;d'
```

### 20. **Combine Multiple `sed` Operations in a File**
You can use a script file to store multiple `sed` operations.

**Create a script (`my_sed_script.sed`) and run it:**
```bash
# my_sed_script.sed
s/apple/orange/g
s/banana/grape/g

# Run the script
sed -f my_sed_script.sed filename
```

### 21. **Transform Characters Based on Character Class**
**Replace every vowel (a, e, i, o, u) with "X":**
```bash
sed 'y/aeiou/XXXXX/' filename
```

### 22. **Print the Line Numbers**
**Print lines with their line numbers:**
```bash
sed = filename | sed 'N;s/\n/ /'
```

### 23. **Advanced Use Case: Extract and Append Data**
You can use `sed` to capture parts of the line and append or prepend them.

**Extract and append the text from two columns:**
```bash
sed -E 's/([a-z]+) ([a-z]+)/\2 \1/' filename
```
This swaps the first and second word of each line.

### 24. **Replace Only if Pattern Matches (Conditional Replacement)**
**Replace "apple" with "orange" only if the line contains "fruit":**
```bash
sed '/fruit/s/apple/orange/' filename
```

### 25. **Working with Files: Print First N Lines**
**Print the first 10 lines of a file:**
```bash
sed -n '1,10p' filename
```
