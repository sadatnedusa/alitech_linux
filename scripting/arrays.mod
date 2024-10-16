# Bash scripts that demonstrate different ways to work with arrays.

## Example 1: Simple Array Manipulation

```bash
#!/bin/bash

# Function to display array elements
function display_array {
    echo "Array elements are:"
    for element in "${array[@]}"; do
        echo "$element"
    done
}

# Define an array
array=(apple banana cherry)

# Add an element
array+=("date")

# Remove an element
unset array[1]  # Removes 'banana'

# Display the modified array
display_array
```

### Example 2: Associative Arrays

```bash
#!/bin/bash

# Declare an associative array
declare -A fruits

# Assign values to the array
fruits=( ["apple"]="red" ["banana"]="yellow" ["grape"]="purple" )

# Function to display key-value pairs
function display_associative_array {
    echo "Fruit colors:"
    for fruit in "${!fruits[@]}"; do
        echo "$fruit is ${fruits[$fruit]}"
    done
}

# Display the associative array
display_associative_array
```

### Example 3: Array Length and Accessing Elements

```bash
#!/bin/bash

# Define an array
colors=(red green blue yellow)

# Get the length of the array
length=${#colors[@]}
echo "The array has $length elements."

# Access elements
echo "The first color is: ${colors[0]}"
echo "The last color is: ${colors[-1]}"
```

### Example 4: Looping Through an Array with Indexes

```bash
#!/bin/bash

# Define an array
shapes=(circle square triangle)

# Loop through the array with indices
echo "Shapes and their indices:"
for index in "${!shapes[@]}"; do
    echo "Index $index: ${shapes[$index]}"
done
```

### Example 5: Passing Arrays to Functions

```bash
#!/bin/bash

# Function to sum numbers in an array
function sum_array {
    local sum=0
    for num in "$@"; do
        ((sum += num))
    done
    echo "Sum: $sum"
}

# Define an array of numbers
numbers=(10 20 30 40)

# Pass the array to the function
sum_array "${numbers[@]}"
```

Feel free to run any of these scripts by saving them to a file (e.g., `script.sh`), giving it execute permissions with `chmod +x script.sh`, and then executing it with `./script.sh`.
