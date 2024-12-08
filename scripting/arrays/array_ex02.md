# Bash script introduce concepts related to arrays, starting from the basics and moving to more advanced topics.

### Example 1: Basic Array Creation and Access

```bash
#!/bin/bash

# Creating a simple array
fruits=(apple banana cherry)

# Accessing elements
echo "First fruit: ${fruits[0]}"
echo "Second fruit: ${fruits[1]}"
echo "Third fruit: ${fruits[2]}"
```

### Example 2: Array Length

```bash
#!/bin/bash

# Define an array
numbers=(1 2 3 4 5)

# Get the length of the array
length=${#numbers[@]}
echo "The array has $length elements."
```

### Example 3: Iterating Over an Array

```bash
#!/bin/bash

# Define an array
colors=(red green blue yellow)

# Iterate over the array
echo "Colors:"
for color in "${colors[@]}"; do
    echo "$color"
done
```

### Example 4: Modifying Array Elements

```bash
#!/bin/bash

# Define an array
animals=(cat dog bird)

# Modify an element
animals[1]="fish"  # Change 'dog' to 'fish'

# Display modified array
echo "Modified animals: ${animals[@]}"
```

### Example 5: Adding and Removing Elements

```bash
#!/bin/bash

# Define an array
names=(Alice Bob Charlie)

# Add elements
names+=("David")
names+=("Eve")

# Remove an element (Bob)
unset names[1]

# Display final array
echo "Names: ${names[@]}"
```

### Example 6: Using Associative Arrays

```bash
#!/bin/bash

# Declare an associative array
declare -A capitals

# Assign values
capitals=( ["USA"]="Washington, D.C." ["France"]="Paris" ["Japan"]="Tokyo" )

# Display the capital of France
echo "The capital of France is ${capitals[France]}."
```

### Example 7: Looping Through Associative Arrays

```bash
#!/bin/bash

# Declare an associative array
declare -A countries
countries=( ["USA"]="Washington, D.C." ["France"]="Paris" ["Japan"]="Tokyo" )

# Loop through the associative array
echo "Countries and their capitals:"
for country in "${!countries[@]}"; do
    echo "$country: ${countries[$country]}"
done
```

### Example 8: Passing Arrays to Functions

```bash
#!/bin/bash

# Function to print array elements
function print_array {
    echo "Array elements:"
    for element in "$@"; do
        echo "$element"
    done
}

# Define an array
my_array=(one two three four)

# Pass the array to the function
print_array "${my_array[@]}"
```

### Example 9: Finding Maximum Value in an Array

```bash
#!/bin/bash

# Function to find the maximum number in an array
function find_max {
    max=$1  # Assume the first element is the largest
    for num in "${@:2}"; do
        if (( num > max )); then
            max=$num
        fi
    done
    echo "Maximum value: $max"
}

# Define an array of numbers
numbers=(10 20 5 40 15)

# Call the function
find_max "${numbers[@]}"
```

### Example 10: Merging Two Arrays

```bash
#!/bin/bash

# Define two arrays
array1=(1 2 3)
array2=(4 5 6)

# Merge arrays
merged=("${array1[@]}" "${array2[@]}")

# Display merged array
echo "Merged array: ${merged[@]}"
```

### Example 11: Sorting an Array

```bash
#!/bin/bash

# Define an array
unsorted=(5 3 8 1 2)

# Sort the array
sorted=($(for i in "${unsorted[@]}"; do echo $i; done | sort -n))

# Display sorted array
echo "Sorted array: ${sorted[@]}"
```

### Example 12: Using `readarray` to Read Input into an Array

```bash
#!/bin/bash

# Read lines into an array
echo "Enter names (Ctrl+D to finish):"
readarray names

# Display the names
echo "You entered:"
for name in "${names[@]}"; do
    echo "$name"
done
```

### Example 13: Complex Data Structures (Array of Associative Arrays)

```bash
#!/bin/bash

# Declare an array of associative arrays
declare -A person1=( ["name"]="Alice" ["age"]=30 )
declare -A person2=( ["name"]="Bob" ["age"]=25 )
people=( ["p1"]=person1 ["p2"]=person2 )

# Accessing data
for key in "${!people[@]}"; do
    eval "declare -A person=\${people[$key]}"
    echo "${person[name]} is ${person[age]} years old."
done
```

These examples should give you a comprehensive understanding of how to work with arrays in Bash, from basic operations to more advanced techniques. You can save each example in a separate file and execute them to see how they work!
