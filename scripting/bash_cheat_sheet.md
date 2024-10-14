# **Bash Scripting Cheat Sheet**

#### **1. Basic Structure**
```bash
#!/bin/bash
# This is a comment
echo "Hello, World!"
```

- **#!/bin/bash**: Specifies the script interpreter.
- **#**: Comments.

#### **2. Variables**
```bash
# Assign and use variables
name="Ali"
echo "Hello, $name"
```
- No spaces around `=` when assigning variables.
- Use `$` to access variable values.

#### **3. User Input**
```bash
read -p "Enter your name: " user_name
echo "Hello, $user_name"
```
- **read**: Reads user input.
- **-p**: Prompt for input.

#### **4. Arithmetic Operations**
```bash
a=5
b=3
sum=$((a + b))
echo "Sum: $sum"
```
- Use `$((expression))` for arithmetic calculations.

#### **5. Conditional Statements**

##### **If-Else**
```bash
if [ $a -gt $b ]; then
    echo "$a is greater than $b"
else
    echo "$a is not greater than $b"
fi
```

##### **Comparison Operators**
- `-eq`: Equal.
- `-ne`: Not equal.
- `-gt`: Greater than.
- `-lt`: Less than.
- `-ge`: Greater than or equal.
- `-le`: Less than or equal.

#### **6. Loops**

##### **For Loop**
```bash
for i in {1..5}; do
    echo "Number: $i"
done
```

##### **While Loop**
```bash
counter=1
while [ $counter -le 5 ]; do
    echo "Counter: $counter"
    counter=$((counter + 1))
done
```

#### **7. Functions**
```bash
greet() {
    echo "Hello, $1"
}
greet "Alice"
```
- Define functions with `function_name()` and use `$1`, `$2` for arguments.

#### **8. File Operations**

##### **Check if a file exists**
```bash
if [ -f "file.txt" ]; then
    echo "File exists"
else
    echo "File does not exist"
fi
```
- `-f`: Checks if the file exists.

##### **Reading a file line by line**
```bash
while read line; do
    echo "$line"
done < file.txt
```

#### **9. String Operations**

##### **String Length**
```bash
string="Hello"
echo "Length: ${#string}"
```

##### **Substring Extraction**
```bash
echo ${string:0:2}  # Output: He
```

#### **10. Command Substitution**
```bash
current_dir=$(pwd)
echo "You are in $current_dir"
```
- Use `$(command)` to capture the output of a command.

#### **11. Exit Status**
```bash
command
if [ $? -eq 0 ]; then
    echo "Command succeeded"
else
    echo "Command failed"
fi
```
- `$?`: Stores the exit status of the last command (0: success, non-zero: error).

#### **12. Redirection**
```bash
command > output.txt  # Redirect output to a file
command >> output.txt # Append output to a file
command 2> error.txt  # Redirect errors to a file
```
- `>`: Redirects output.
- `>>`: Appends to a file.
- `2>`: Redirects errors.

#### **13. Pipes and Chaining**
```bash
ls | grep "file"  # Pipe output of ls to grep
command1 && command2  # Run command2 only if command1 succeeds
command1 || command2  # Run command2 if command1 fails
```

#### **14. Arrays**
```bash
array=("one" "two" "three")
echo "${array[0]}"  # Access element
echo "${array[@]}"  # Access all elements
```

#### **15. Case Statement**
```bash
read -p "Enter a number (1-3): " num
case $num in
    1) echo "You chose 1";;
    2) echo "You chose 2";;
    3) echo "You chose 3";;
    *) echo "Invalid choice";;
esac
```

#### **16. File Permissions**
```bash
chmod +x script.sh  # Make script executable
```

#### **17. Debugging**
```bash
bash -x script.sh  # Run with debugging
```
- **-x**: Enables debugging mode, shows each command executed.
