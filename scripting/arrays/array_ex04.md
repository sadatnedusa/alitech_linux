# Some advanced examples of working with arrays in Bash, showcasing various techniques and use cases.

### Example 1: Array of Arrays

You can create an array of arrays to manage more complex data structures.

```bash
#!/bin/bash

# Declare an array of arrays
declare -a group1=("Alice" "Bob" "Charlie")
declare -a group2=("David" "Eve" "Frank")

# Create an array of arrays
groups=(group1 group2)

# Loop through each group
for group in "${groups[@]}"; do
    eval "members=(\"\${$group[@]}\")"
    echo "Members of $group:"
    for member in "${members[@]}"; do
        echo " - $member"
    done
done
```

### Example 2: Filtering Array Elements

You can filter elements based on conditions.

```bash
#!/bin/bash

# Define an array
numbers=(1 2 3 4 5 6 7 8 9 10)

# Create an empty array to hold even numbers
even_numbers=()

# Filter even numbers
for num in "${numbers[@]}"; do
    if (( num % 2 == 0 )); then
        even_numbers+=("$num")
    fi
done

# Display the even numbers
echo "Even numbers: ${even_numbers[@]}"
```

### Example 3: Using Arrays with Functions

You can pass arrays to functions and modify them.

```bash
#!/bin/bash

# Function to add elements to an array
function add_to_array {
    local -n arr=$1  # Use nameref to reference the passed array
    shift            # Shift off the first argument (the array name)

    for element in "$@"; do
        arr+=("$element")
    done
}

# Declare an array
my_array=()

# Call the function to add elements
add_to_array my_array "apple" "banana" "cherry"

# Display the array
echo "Array after addition: ${my_array[@]}"
```

### Example 4: Associative Array with Complex Data

You can store more complex data types in associative arrays.

```bash
#!/bin/bash

# Declare an associative array to hold people's details
declare -A people

# Add details
people=( ["Alice"]="25:Engineer" ["Bob"]="30:Designer" ["Charlie"]="28:Manager" )

# Loop through and display details
for person in "${!people[@]}"; do
    IFS=':' read -r age occupation <<< "${people[$person]}"
    echo "$person is $age years old and works as an $occupation."
done
```

### Example 5: Sorting an Array

You can sort an array using `sort` and process substitution.

```bash
#!/bin/bash

# Define an unsorted array
unsorted=(5 3 8 1 2)

# Sort the array
sorted=($(for i in "${unsorted[@]}"; do echo $i; done | sort -n))

# Display sorted array
echo "Sorted array: ${sorted[@]}"
```

### Example 6: Combining and Distinguishing Arrays

You can merge two arrays and find distinct elements.

```bash
#!/bin/bash

# Define two arrays
array1=(1 2 3 4 5)
array2=(4 5 6 7 8)

# Combine arrays
combined=("${array1[@]}" "${array2[@]}")

# Find distinct elements using associative array
declare -A seen
for item in "${combined[@]}"; do
    seen[$item]=1
done

# Display distinct elements
echo "Distinct elements: ${!seen[@]}"
```

### Example 7: Passing Arguments as an Array

You can pass script arguments as an array.

```bash
#!/bin/bash

# Function to display script arguments
function display_args {
    echo "Arguments passed to the script:"
    for arg in "$@"; do
        echo "$arg"
    done
}

# Call the function with all script arguments
display_args "$@"
```

### Example 8: Nested Loop with Arrays

You can use nested loops to process arrays, such as generating combinations.

```bash
#!/bin/bash

# Define two arrays
colors=(red green blue)
sizes=(small medium large)

# Generate combinations
for color in "${colors[@]}"; do
    for size in "${sizes[@]}"; do
        echo "Combination: $color $size"
    done
done
```

### Example 9: Reading Configuration from a File

You can read configuration values into an associative array from a file.

```bash
#!/bin/bash

# Declare an associative array
declare -A config

# Read key-value pairs from a file
while IFS='=' read -r key value; do
    config[$key]=$value
done < config.txt

# Display the configuration
for key in "${!config[@]}"; do
    echo "$key=${config[$key]}"
done
```

### Example 10: Using a Temporary Array

You can create a temporary array for processing.

```bash
#!/bin/bash

# Define an array
numbers=(1 2 3 4 5)

# Create a temporary array to hold squares
temp=()

# Calculate squares
for num in "${numbers[@]}"; do
    temp+=($((num * num)))
done

# Display squares
echo "Squares: ${temp[@]}"
```
