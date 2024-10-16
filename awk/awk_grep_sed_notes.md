# Section 1

## Let's dive into `awk`, `grep`, and `sed`, covering their functionalities and providing detailed examples for each.

## 1. `grep`

`grep` is a command-line utility for searching plain-text data sets for lines that match a regular expression. 

### Basic Syntax
```bash
grep [options] pattern [file...]
```

### Common Options
- `-i`: Ignore case.
- `-v`: Invert the match (show lines that do not match).
- `-r`: Recursively search directories.
- `-n`: Show line numbers.
- `-l`: List only filenames with matching lines.

### Examples

#### Example 1: Simple Search
```bash
grep "hello" file.txt
```

#### Example 2: Case-Insensitive Search
```bash
grep -i "hello" file.txt
```

#### Example 3: Show Line Numbers
```bash
grep -n "hello" file.txt
```

#### Example 4: Invert Match
```bash
grep -v "hello" file.txt
```

#### Example 5: Recursive Search
```bash
grep -r "hello" /path/to/directory
```

#### Example 6: Count Matches
```bash
grep -c "hello" file.txt
```

---

## 2. `sed`

`sed` (Stream Editor) is used for parsing and transforming text from a data stream or a file.

### Basic Syntax
```bash
sed [options] 'command' file
```

### Common Commands
- `s/pattern/replacement/`: Substitute text.
- `d`: Delete lines.
- `p`: Print lines.
- `-n`: Suppress automatic printing.

### Examples

#### Example 1: Substitute Text
```bash
sed 's/old/new/' file.txt
```

#### Example 2: Substitute Text Globally
```bash
sed 's/old/new/g' file.txt
```

#### Example 3: Delete Lines
```bash
sed '2d' file.txt  # Deletes the second line
```

#### Example 4: Print Specific Lines
```bash
sed -n '1,3p' file.txt  # Print lines 1 to 3
```

#### Example 5: In-Place Editing
```bash
sed -i 's/old/new/g' file.txt  # Modify the file directly
```

#### Example 6: Insert a Line
```bash
sed '2i\This is a new line' file.txt  # Insert a line before line 2
```

---

## 3. `awk`

`awk` is a programming language designed for text processing. It works on records (lines) and fields (columns).

### Basic Syntax
```bash
awk 'pattern { action }' file
```

### Common Features
- **Field Separator**: By default, `awk` uses whitespace as a field separator. You can change it using `-F`.
- **Built-in Variables**:
  - `$0`: Entire line.
  - `$1`, `$2`, ...: Individual fields.
  - `NR`: Current record number.
  - `NF`: Number of fields in the current record.

### Examples

#### Example 1: Print the First Column
```bash
awk '{ print $1 }' file.txt
```

#### Example 2: Print Specific Columns
```bash
awk '{ print $1, $3 }' file.txt
```

#### Example 3: Use a Different Field Separator
```bash
awk -F',' '{ print $1 }' file.csv  # Use comma as field separator
```

#### Example 4: Print Lines Matching a Pattern
```bash
awk '/pattern/ { print $0 }' file.txt
```

#### Example 5: Conditional Actions
```bash
awk '$3 > 50 { print $1, $2 }' file.txt  # Print first two columns where the third column is greater than 50
```

#### Example 6: Calculate Sum of a Column
```bash
awk '{ sum += $2 } END { print sum }' file.txt  # Sum values in the second column
```

---

### Combining `grep`, `sed`, and `awk`

These tools can be combined to perform complex text processing tasks. For example:

#### Example: Extract and Modify Data
Suppose you have a CSV file (`data.csv`):
```
Name, Age, Occupation
Alice, 30, Engineer
Bob, 25, Designer
Charlie, 35, Manager
```

You can extract names of people older than 30 and replace "Charlie" with "Chuck":

```bash
grep "^[^#]" data.csv | awk -F', ' '$2 > 30 { print $1 }' | sed 's/Charlie/Chuck/'
```

### Summary

- **`grep`**: Great for searching and filtering lines based on patterns.
- **`sed`**: Ideal for text transformation and basic text processing.
- **`awk`**: Powerful for structured data processing and analysis.

These examples should give you a solid understanding of how to use `grep`, `sed`, and `awk` effectively. 


# Section 2

## When using `awk` with a custom field separator, you can specify any character or string to separate fields.
- Below are examples using different word-based separators.

### Example 1: Using a Space as a Field Separator

Suppose you have a text file (`data.txt`) with the following content:

```
Alice 30 Engineer
Bob 25 Designer
Charlie 35 Manager
```

To separate fields based on spaces, you can use:

```bash
awk -F' ' '{ print $1, $2 }' data.txt
```

This command prints the first and second columns (names and ages).

### Example 2: Using a Comma as a Field Separator

If your data is comma-separated (CSV format), like this (`data.csv`):

```
Alice,30,Engineer
Bob,25,Designer
Charlie,35,Manager
```

You can specify the comma as the field separator:

```bash
awk -F',' '{ print $1, $2 }' data.csv
```

This will print the names and ages.

### Example 3: Using a Custom Word as a Field Separator

If you have a file (`data.txt`) where fields are separated by the word "and", like this:

```
Alice and 30 and Engineer
Bob and 25 and Designer
Charlie and 35 and Manager
```

You can use the word "and" as the field separator:

```bash
awk -F' and ' '{ print $1, $2 }' data.txt
```

### Output
This will output:

```
Alice 30
Bob 25
Charlie 35
```

### Example 4: Using a Pipe as a Field Separator

For a file with pipe-separated values (`data.txt`):

```
Alice|30|Engineer
Bob|25|Designer
Charlie|35|Manager
```

You can use:

```bash
awk -F'|' '{ print $1, $3 }' data.txt
```

This command prints the names and occupations.

### Example 5: Multiple Field Separators

If your data uses both spaces and commas (e.g., `data.txt`):

```
Alice,30 Engineer
Bob,25 Designer
Charlie,35 Manager
```

You can define multiple field separators using regular expressions:

```bash
awk -F'[ ,]' '{ print $1, $2 }' data.txt
```

This will treat both commas and spaces as separators, allowing you to extract the fields correctly.

### Summary

Using `awk -F` allows you to specify any character or string as a field separator, enabling you to process and extract data from various formatted text files effectively.

---
# Section 3
### Example 1: Basic Output to a File

Suppose you have a text file (`data.txt`) with the following content:

```
Alice 30 Engineer
Bob 25 Designer
Charlie 35 Manager
```

If you want to extract names and ages and write them to a new file (`output.txt`), you can do:

```bash
awk '{ print $1, $2 }' data.txt > output.txt
```

This command writes the first and second columns (names and ages) into `output.txt`.

### Example 2: Appending to a File

If you want to append the output instead of overwriting the file, you can use `>>`:

```bash
awk '{ print $1, $2 }' data.txt >> output.txt
```

This will add the names and ages to the end of `output.txt`.

### Example 3: Writing Conditional Output

You can also write conditionally. For instance, if you only want to write names of people older than 30:

```bash
awk '$2 > 30 { print $1 }' data.txt > output.txt
```

This command will write only the names of people older than 30 to `output.txt`.

### Example 4: Formatting Output

You can format the output before writing it to a file. For example, adding a custom message:

```bash
awk '{ print "Name:", $1, "Age:", $2 }' data.txt > output.txt
```

### Example 5: Writing Multiple Fields

You can write multiple fields and format them in a more structured way. For example, to write names and occupations:

```bash
awk '{ print "Name:", $1, "is a", $3 }' data.txt > output.txt
```

### Example 6: Using `BEGIN` and `END` Blocks

You can also use `BEGIN` and `END` blocks to add headers or footers when writing to a file:

```bash
awk 'BEGIN { print "Name\tAge\tOccupation" }
     { print $1, $2, $3 }
     END { print "End of report" }' data.txt > output.txt
```

### Summary

- You can use `awk` to write output directly to files using `>` for overwriting and `>>` for appending.
- You can format the output and include conditional logic to write specific data.
- Using `BEGIN` and `END` blocks allows you to customize the output further by adding headers or footers.

These techniques will help you effectively use `awk` to manage and write output data as needed!
