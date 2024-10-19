# Introduction to `awk`

- `awk` is a powerful programming language designed for text processing and data extraction. It operates on a line-by-line basis, allowing you to manipulate and analyze text files easily.
## Here’s a structured guide to learning `awk`, from fundamental concepts to more advanced usage, including notes and examples.

### 1. **Basic Syntax**

The general syntax for `awk` is:

```bash
awk 'pattern { action }' file
```

- **pattern**: Specifies when to execute the action (e.g., matching a string).
- **action**: Commands to be executed when the pattern is matched (e.g., printing a field).

### 2. **Field and Record Handling**

- **Fields**: By default, `awk` splits each line into fields using whitespace as a separator. Fields can be accessed using `$1`, `$2`, etc.
- **Records**: Each line of input is treated as a record, which can be accessed using `$0`.

### 3. **Basic Examples**

#### Example 1: Print the Entire Line
```bash
awk '{ print $0 }' file.txt
```

#### Example 2: Print Specific Fields
```bash
awk '{ print $1, $3 }' file.txt  # Prints the first and third fields
```

#### Example 3: Change Field Separator
To change the field separator (e.g., for a CSV file):
```bash
awk -F',' '{ print $1, $2 }' data.csv  # Uses comma as the separator
```

### 4. **Pattern Matching**

You can specify conditions to match specific lines.

#### Example 4: Print Lines Matching a Pattern
```bash
awk '/pattern/ { print $0 }' file.txt  # Prints lines containing "pattern"
```

#### Example 5: Numeric Conditions
```bash
awk '$2 > 30 { print $1 }' file.txt  # Prints names of people older than 30
```

### 5. **Built-in Variables**

`awk` has several built-in variables:

- `NR`: Number of records (lines) processed.
- `NF`: Number of fields in the current record.
- `$0`: The entire current record.
- `$1`, `$2`, ...: Individual fields.

#### Example 6: Using Built-in Variables
```bash
awk '{ print "Line:", NR, "has", NF, "fields." }' file.txt
```

### 6. **Control Structures**

You can use control structures like `if`, `for`, and `while` in `awk`.

#### Example 7: Using `if` Statements
```bash
awk '{ if ($2 > 30) print $1 " is older than 30." }' file.txt
```

#### Example 8: Looping Through Fields
```bash
awk '{ for (i = 1; i <= NF; i++) print $i }' file.txt  # Prints each field on a new line
```

### 7. **Functions**

`awk` has built-in functions for string manipulation, arithmetic operations, and more.

#### Example 9: Using String Functions
```bash
awk '{ print toupper($1) }' file.txt  # Converts the first field to uppercase
```

#### Example 10: Using Arithmetic Functions
```bash
awk '{ sum += $2 } END { print "Total:", sum }' file.txt  # Sums the values in the second field
```

### 8. **BEGIN and END Blocks**

- **BEGIN**: Code inside this block runs before any input is processed.
- **END**: Code inside this block runs after all input has been processed.

#### Example 11: Using BEGIN and END
```bash
awk 'BEGIN { print "Name\tAge" } { print $1, $2 } END { print "End of report" }' file.txt
```

### 9. **Writing to Files**

You can direct `awk` output to files using redirection.

#### Example 12: Output to a File
```bash
awk '{ print $1, $2 }' file.txt > output.txt  # Writes output to output.txt
```

### 10. **Advanced Features**

#### Example 13: Using Arrays
```bash
awk '{ count[$1]++ } END { for (name in count) print name, count[name] }' file.txt  # Count occurrences of names
```

#### Example 14: Combining Multiple Conditions
```bash
awk '$2 > 30 && $3 == "Engineer" { print $1 }' file.txt  # Print names of engineers older than 30
```

### 11. **Regular Expressions**

You can use regular expressions for more advanced pattern matching.

#### Example 15: Match Lines with a Regex
```bash
awk '/^A/ { print $0 }' file.txt  # Prints lines starting with "A"
```

### Summary

- **Learn the Basics**: Understand syntax, field/record handling, and basic commands.
- **Practice Pattern Matching**: Use conditions to filter data.
- **Explore Built-in Variables and Control Structures**: Enhance your scripts with logic.
- **Experiment with Functions and Blocks**: Use built-in functions and control the flow of your scripts.
- **Write to Files**: Learn to direct output to files effectively.
- **Dive into Advanced Features**: Explore arrays and regular expressions for more complex tasks.

### Resources for Further Learning

- **Official `awk` Documentation**: Check online for GNU `awk` or `gawk` documentation.
- **Books**: "The AWK Programming Language" by Aho, Kernighan, and Weinberger is a classic.
- **Practice**: Use real datasets and practice various operations to solidify your understanding.

---

## Section 2

 - `awk` examples that cover basic to advanced features, along with explanations for each.

### Basic Examples

#### Example 1: Print Entire File
```bash
awk '{ print }' file.txt
```
This prints each line of the file.

#### Example 2: Print Specific Fields
```bash
awk '{ print $1, $3 }' file.txt
```
This prints the first and third fields of each line.

#### Example 3: Change Field Separator
```bash
awk -F',' '{ print $1, $2 }' data.csv
```
This uses a comma as the field separator for a CSV file.

#### Example 4: Print Lines Matching a Pattern
```bash
awk '/pattern/ { print }' file.txt
```
This prints lines that contain "pattern".

#### Example 5: Numeric Conditions
```bash
awk '$2 > 30 { print $1 }' file.txt
```
This prints the first field of lines where the second field is greater than 30.

### Intermediate Examples

#### Example 6: Using Built-in Variables
```bash
awk '{ print "Line:", NR, "has", NF, "fields." }' file.txt
```
This prints the line number and the number of fields for each line.

#### Example 7: Conditional Statements
```bash
awk '{ if ($2 > 30) print $1 " is older than 30." }' file.txt
```
This checks if the second field is greater than 30 and prints a message.

#### Example 8: Looping Through Fields
```bash
awk '{ for (i = 1; i <= NF; i++) print $i }' file.txt
```
This prints each field of every line on a new line.

#### Example 9: String Manipulation
```bash
awk '{ print toupper($1) }' file.txt
```
This converts the first field to uppercase.

#### Example 10: Calculate Sum of a Column
```bash
awk '{ sum += $2 } END { print "Total:", sum }' file.txt
```
This sums the values in the second field and prints the total.

### Advanced Examples

#### Example 11: Using Arrays
```bash
awk '{ count[$1]++ } END { for (name in count) print name, count[name] }' file.txt
```
This counts occurrences of each name in the first field.

#### Example 12: Multiple Conditions
```bash
awk '$2 > 30 && $3 == "Engineer" { print $1 }' file.txt
```
This prints names where the second field is greater than 30 and the third field is "Engineer".

#### Example 13: BEGIN and END Blocks
```bash
awk 'BEGIN { print "Name\tAge" } { print $1, $2 } END { print "End of report" }' file.txt
```
This adds a header at the beginning and a footer at the end of the output.

#### Example 14: Regular Expressions
```bash
awk '/^A/ { print }' file.txt
```
This prints lines that start with the letter "A".

#### Example 15: Writing to Files
```bash
awk '{ print $1, $2 }' file.txt > output.txt
```
This writes the first and second fields to `output.txt`.

#### Example 16: Using `gsub` for Substitution
```bash
awk '{ gsub(/old/, "new"); print }' file.txt
```
This replaces all occurrences of "old" with "new" and prints the modified lines.

#### Example 17: Field Separator in the Middle of a Line
If you have a file with mixed delimiters (spaces and commas):
```bash
echo "Alice,30 Engineer" | awk -F'[ ,]' '{ print $1, $2 }'
```
This treats both commas and spaces as field separators.

### Summary

These examples showcase the power and versatility of `awk` for text processing. 
You can manipulate fields, perform calculations, use control structures, and even write output to files, all with concise commands. 
As you practice, try to combine features and create more complex scripts to enhance your understanding!

---
## Section 3

## Some advanced `awk` examples along with sample data, showcasing various features and techniques.

- Each example includes a description of what it does.

### Sample Data

We'll use the following sample data in a file called `employees.txt`:

```
Name,Age,Department,Salary
Alice,30,Engineering,70000
Bob,25,Marketing,50000
Charlie,35,Engineering,80000
David,28,Sales,60000
Eve,40,Marketing,75000
Frank,32,Engineering,90000
Grace,29,Sales,62000
```

### Example 1: Calculating Average Salary by Department

This example calculates the average salary for each department.

```bash
awk -F',' '
BEGIN {
    print "Department\tAverage Salary"
}
{
    dept[$3] += $4;    # Sum salaries by department
    count[$3]++;       # Count employees in each department
}
END {
    for (d in dept) {
        avg = dept[d] / count[d];  # Calculate average
        printf "%s\t%.2f\n", d, avg;  # Print department and average salary
    }
}' employees.txt
```

### Example 2: Filtering and Formatting Output

This example prints employees earning more than $60,000, formatted nicely.

```bash
awk -F',' '
BEGIN {
    print "Employees with Salary > 60000:"
    printf "%-10s %-5s %-12s %-7s\n", "Name", "Age", "Department", "Salary"
}
$4 > 60000 {
    printf "%-10s %-5d %-12s %-7.2f\n", $1, $2, $3, $4
}' employees.txt
```

### Example 3: Finding the Highest Salary in Each Department

This example identifies the highest salary in each department.

```bash
awk -F',' '
{
    if ($4 > max[$3]) {
        max[$3] = $4;      # Store max salary for department
        emp[$3] = $1;      # Store employee name corresponding to max salary
    }
}
END {
    print "Highest Salary by Department:"
    for (d in max) {
        print emp[d], "in", d, "with salary", max[d];
    }
}' employees.txt
```

### Example 4: Sorting Employees by Age

This example sorts employees by age and prints them.

```bash
awk -F',' 'NR > 1 { print $0 | "sort -t, -k2n" }' employees.txt
```

### Example 5: Grouping Employees by Age Ranges

This example groups employees by age ranges and counts how many fall into each range.

```bash
awk -F',' '
NR > 1 {
    if ($2 < 30) {
        age_group["Under 30"]++;
    } else if ($2 >= 30 && $2 < 40) {
        age_group["30-39"]++;
    } else {
        age_group["40 and above"]++;
    }
}
END {
    print "Age Group\tCount"
    for (group in age_group) {
        print group, age_group[group];
    }
}' employees.txt
```

### Example 6: Merging and Summarizing Data from Multiple Files

If you had another file (`sales.txt`) with sales data:

```
Employee,Sales
Alice,5000
Bob,7000
Charlie,3000
David,8000
Eve,9000
```

You can merge and summarize data from both files:

```bash
awk -F',' '
NR == FNR { sales[$1] = $2; next }  # Read sales data
{
    total_salary[$1] = $4;  # Store salary for each employee
    total_sales[$1] = sales[$1];  # Store corresponding sales
}
END {
    print "Employee\tSalary\tSales"
    for (e in total_salary) {
        printf "%s\t%.2f\t%.2f\n", e, total_salary[e], total_sales[e];
    }
}' sales.txt employees.txt
```

### Example 7: Nested Arrays

In this example, we'll use nested arrays to store salaries by department.

```bash
awk -F',' '
{
    dept[$3][NR] = $4;  # Store salary by department
}
END {
    for (d in dept) {
        sum = 0;
        count = 0;
        for (i in dept[d]) {
            sum += dept[d][i];
            count++;
        }
        avg = sum / count;
        print "Average salary in", d, "is", avg;
    }
}' employees.txt
```

### Example 8: Report Generation with BEGIN and END Blocks

This example generates a formatted report with headers and footers.

```bash
awk -F',' '
BEGIN {
    print "Employee Report"
    print "================="
}
{
    printf "%-10s %-5d %-12s %-7.2f\n", $1, $2, $3, $4
}
END {
    print "================="
    print "Total Employees:", NR-1;
}' employees.txt
```

### Summary

These examples demonstrate the versatility of `awk` for text processing, including:

- Calculating averages and totals.
- Formatting output.
- Using control structures.
- Grouping data.
- Merging data from multiple sources.
- Generating reports.


---
# Section 4

- Here are advanced to expert-level `awk` examples, showcasing complex features and techniques. 
- These examples cover various scenarios, from data analysis to advanced text processing.

### Sample Data

We'll use the following sample data in a file called `sales_data.txt`:

```
Date,Product,Sales,Profit
2024-01-01,WidgetA,1000,200
2024-01-01,WidgetB,1500,300
2024-01-02,WidgetA,1200,250
2024-01-02,WidgetB,1700,400
2024-01-03,WidgetC,1300,350
2024-01-03,WidgetA,900,150
```

### Example 1: Calculate Daily Total Sales and Profit

This example computes the total sales and profit for each day.

```bash
awk -F',' '
NR > 1 {
    sales[$1] += $3;    # Sum sales by date
    profit[$1] += $4;   # Sum profit by date
}
END {
    print "Date\tTotal Sales\tTotal Profit"
    for (date in sales) {
        printf "%s\t%.2f\t%.2f\n", date, sales[date], profit[date];
    }
}' sales_data.txt
```

### Example 2: Find Best-Selling Product

This example identifies the best-selling product overall.

```bash
awk -F',' '
NR > 1 {
    sales[$2] += $3;  # Sum sales by product
}
END {
    max_sales = 0;
    best_product = "";
    for (product in sales) {
        if (sales[product] > max_sales) {
            max_sales = sales[product];
            best_product = product;
        }
    }
    print "Best-selling product:", best_product, "with total sales:", max_sales;
}' sales_data.txt
```

### Example 3: Generate Monthly Sales Report

This example generates a report of total sales and profit by month.

```bash
awk -F',' '
NR > 1 {
    split($1, date_parts, "-");  # Split date into components
    month = date_parts[1] "-" date_parts[2];  # Get month
    sales[month] += $3;           # Sum sales by month
    profit[month] += $4;          # Sum profit by month
}
END {
    print "Month\tTotal Sales\tTotal Profit"
    for (month in sales) {
        printf "%s\t%.2f\t%.2f\n", month, sales[month], profit[month];
    }
}' sales_data.txt
```

### Example 4: Advanced Pattern Matching with Regular Expressions

This example filters out and processes lines with a specific product pattern.

```bash
awk -F',' '
NR > 1 && $2 ~ /Widget/ {  # Only process lines where product name contains "Widget"
    total_sales += $3;    # Sum sales for matched products
}
END {
    print "Total Sales for Widget products:", total_sales;
}' sales_data.txt
```

### Example 5: Create a Histogram of Sales

This example generates a histogram of sales for each product.

```bash
awk -F',' '
NR > 1 {
    sales[$2] += $3;  # Sum sales by product
}
END {
    print "Product\tSales Histogram"
    for (product in sales) {
        printf "%s\t", product;
        for (i = 0; i < sales[product] / 100; i++) {
            printf "#";  # Print "#" for each 100 in sales
        }
        print "";  # New line after each product
    }
}' sales_data.txt
```

### Example 6: Nested Arrays for Grouping Data

This example uses nested arrays to group sales data by product and date.

```bash
awk -F',' '
NR > 1 {
    sales[$1][$2] += $3;  # sales[date][product]
}
END {
    print "Date\tProduct\tSales"
    for (date in sales) {
        for (product in sales[date]) {
            printf "%s\t%s\t%.2f\n", date, product, sales[date][product];
        }
    }
}' sales_data.txt
```

### Example 7: Merge and Analyze Data from Multiple Files

If you have a second file (`returns_data.txt`):

```
Date,Product,Returns
2024-01-01,WidgetA,100
2024-01-01,WidgetB,50
2024-01-02,WidgetA,200
```

You can merge data from both files to calculate net sales.

```bash
awk -F',' '
NR == FNR {
    returns[$2] += $3;  # Read returns data
    next;
}
NR > 1 {
    net_sales[$2] = $3 - (returns[$2] ? returns[$2] : 0);  # Calculate net sales
}
END {
    print "Product\tNet Sales"
    for (product in net_sales) {
        printf "%s\t%.2f\n", product, net_sales[product];
    }
}' returns_data.txt sales_data.txt
```

### Example 8: Data Validation and Error Handling

This example checks for invalid entries (e.g., negative sales or profits) and reports them.

```bash
awk -F',' '
NR > 1 {
    if ($3 < 0 || $4 < 0) {
        print "Invalid entry:", $0;  # Report invalid entries
    } else {
        sales[$2] += $3;  # Sum sales by product
    }
}
END {
    print "Total Valid Sales:"
    for (product in sales) {
        printf "%s: %.2f\n", product, sales[product];
    }
}' sales_data.txt
```

### Example 9: Time Series Analysis with Moving Averages

This example computes a simple moving average of sales for the last three days.

```bash
awk -F',' '
NR > 1 {
    sales[NR - 1] = $3;  # Store sales in an array (1-based index)
}
END {
    print "Date\t3-Day Moving Average Sales"
    for (i = 3; i <= NR - 1; i++) {
        avg = (sales[i - 2] + sales[i - 1] + sales[i]) / 3;  # Compute average
        printf "%s\t%.2f\n", sales[i - 1, 1], avg;  # Print date and average
    }
}' sales_data.txt
```

### Example 10: Custom Report Generation with User Input

You can create a script that generates custom reports based on user input. For example, generating a report for a specific product.

```bash
awk -F',' -v product="WidgetA" '
NR > 1 && $2 == product {
    printf "Date: %s, Sales: %.2f, Profit: %.2f\n", $1, $3, $4;
}' sales_data.txt
```

### Summary

These advanced `awk` examples demonstrate its powerful capabilities in:

- Data aggregation and analysis.
- Conditional processing and error handling.
- Regular expression matching for filtering data.
- Merging data from multiple files.
- Creating visual representations like histograms.
