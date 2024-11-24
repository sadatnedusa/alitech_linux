# Q1: Write bash script to count number "O" into given string str

```
str="HELLO WORLD"
```
---

## Multiple ways to solve the problem

### Solution 1

- Bash script to count the number of occurrences of the letter `O` in the given string `str="HELLO WORLD"`:

```bash
#!/bin/bash

# Define the string
str="HELLO WORLD"

# Initialize a counter
count=0

# Convert the string to an array of characters and iterate over it
for char in $(echo "$str" | fold -w1); do
  if [ "$char" == "O" ]; then
    count=$((count + 1))
  fi
done

# Output the result
echo "The letter 'O' appears $count times in the string '$str'"
```

### Explanation:
1. The string `HELLO WORLD` is stored in the variable `str`
2. The `fold -w1` command splits the string into individual characters.
3. The script iterates over each character using a `for` loop.
4. An `if` statement checks if the character is `O`, and if so, increments the `count`
5. The script finally prints the result.

### Output:
```bash
The letter 'O' appears 2 times in the string 'HELLO WORLD'
``` 
---
### Solution 2

- Brute Force : You can copy the string into an array and iterate over it to count the occurrences of `O`:

```bash
#!/bin/bash

# Define the string
str="HELLO WORLD"

# Convert the string into an array of characters
# Using `fold -w1` to split the string into individual characters
char_array=($(echo "$str" | fold -w1))

# Initialize a counter
count=0

# Iterate over the array
for char in "${char_array[@]}"; do
  if [ "$char" == "O" ]; then
    count=$((count + 1))
  fi
done

# Output the result
echo "The letter 'O' appears $count times in the string '$str'"
```

### Explanation:
1. **String to Array Conversion**:
   - `fold -w1` splits the string into individual characters, each on a new line.
   - `$(...)` captures the output, and the `()` converts it into an array.

2. **Array Iteration**:
   - The `for char in "${char_array[@]}"` loop iterates over each character in the array.

3. **Condition and Counter**:
   - The `if` statement checks if the character is `O`
   - The counter is incremented when `O` is found.

4. **Output**:
   - Displays the total count of `O`

### Example Output:
```bash
The letter 'O' appears 2 times in the string 'HELLO WORLD'
```
---
### Solution 3

- Bash script that reads a string from the user and counts the number of occurrences of the letter `O` (case-sensitive) in the given string.

```bash
#!/bin/bash

# Read a string from the user
echo -n "Enter a string: "
read input_string

# Count occurrences of 'O' using grep and wc
count=$(echo "$input_string" | grep -o "O" | wc -l)

# Output the result
echo "The letter 'O' appears $count times in the given string."
```

### Explanation:
1. **`echo -n` and `read`**:
   - `echo -n`: Prompts the user without adding a newline.
   - `read input_string`: Reads the user's input into the variable `input_string`.

2. **`grep -o "O"`**:
   - The `-o` flag in `grep` extracts only the matching parts (`O`) from the input string.

3. **`wc -l`**:
   - Counts the number of lines output by `grep`, which corresponds to the number of matches.

4. **Output**:
   - The script prints the number of times `O` appears in the input string.

### Example:
```bash
Enter a string: HELLO WORLD
The letter 'O' appears 2 times in the given string.
```
