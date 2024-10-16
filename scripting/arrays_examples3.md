# How to declare arrays, use them effectively, and work with dynamic arrays in Bash.

### 1. Declaring Arrays

**Indexed Arrays:**
You can declare an indexed array using parentheses:

```bash
# Declare and initialize an indexed array
fruits=("apple" "banana" "cherry")

# Declare an empty array
empty_array=()
```

**Associative Arrays:**
Associative arrays (key-value pairs) require the `declare -A` syntax:

```bash
# Declare an associative array
declare -A capitals

# Initialize with key-value pairs
capitals=( ["USA"]="Washington, D.C." ["France"]="Paris" )
```

### 2. Using Arrays Effectively

**Accessing Elements:**
Access elements using the index (for indexed arrays) or the key (for associative arrays):

```bash
echo "First fruit: ${fruits[0]}"       # Outputs: apple
echo "Capital of France: ${capitals[France]}"  # Outputs: Paris
```

**Modifying Elements:**
You can modify existing elements:

```bash
fruits[1]="blueberry"  # Changes 'banana' to 'blueberry'
capitals[Germany]="Berlin"  # Adds Germany with its capital
```

**Iterating Over Arrays:**
You can use loops to iterate through arrays:

```bash
# For indexed array
for fruit in "${fruits[@]}"; do
    echo "$fruit"
done

# For associative array
for country in "${!capitals[@]}"; do
    echo "$country: ${capitals[$country]}"
done
```

**Array Length:**
Get the length of an array using:

```bash
length=${#fruits[@]}
echo "Number of fruits: $length"
```

### 3. Working with Dynamic Arrays

Dynamic arrays can be managed by appending and removing elements. Here's how you can do that:

**Appending Elements:**
You can add elements using the `+=` operator:

```bash
fruits+=("date")  # Adds 'date' to the array
```

**Removing Elements:**
Use `unset` to remove elements:

```bash
unset fruits[2]  # Removes 'cherry'
```

**Creating a Dynamic Array from User Input:**

You can read user input into an array using `readarray` (or `mapfile`):

```bash
echo "Enter fruits (Ctrl+D to end):"
readarray fruits  # Reads multiple lines into the array

# Display the entered fruits
echo "Fruits you entered:"
for fruit in "${fruits[@]}"; do
    echo "$fruit"
done
```

**Expanding an Array Dynamically:**

Here's an example of building an array dynamically in a loop:

```bash
#!/bin/bash

# Initialize an empty array
dynamic_array=()

# Read numbers until the user enters a non-number
echo "Enter numbers (Ctrl+D to finish):"
while read -r number; do
    if [[ $number =~ ^[0-9]+$ ]]; then
        dynamic_array+=("$number")  # Append the number
    else
        echo "Invalid input, exiting."
        break
    fi
done

# Display the dynamic array
echo "You entered: ${dynamic_array[@]}"
```

### Summary

- **Declare arrays** using parentheses for indexed arrays or `declare -A` for associative arrays.
- **Use arrays effectively** by accessing, modifying, and iterating through elements.
- **Create dynamic arrays** by appending elements, removing them, and reading user input into the arrays.

These techniques will help you effectively manage arrays in your Bash scripts!
