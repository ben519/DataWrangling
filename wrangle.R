#======================================================================================================
# Build dataset from scratch

products <- data.table(
  ProductID = 1:5,
  Product = c("A", "B", "C", "D", "E"),
  Price = c(53.01, 11.76, 57.45, 53.61, 21.72)
)

#======================================================================================================
# Read and write to CSV

# Read transactions from CSV
users <- fread("Data/transactions.csv", verbose=TRUE)
products <- fread("Data/products.csv")
transactions <- fread("Data/transactions.csv")

# Write transactions to CSV
fwrite(transactions, "Data/transactions.csv")

#======================================================================================================
# Meta info

# Full summary
str(transactions)

# How many rows?
nrow(transactions)

# How many columns?
ncol(transactions)

# What are the row names
rownames(transactions)

# What are the column names
colnames(transactions)

# Change the name of column "Quantity" to "Quant"
setnames(transactions, "Quantity", "Quant")
setnames(transactions, "Quant", "Quantity")  # change it back

# Change the name of columns ProductID and UserID to PID and UID respectively
setnames(transactions, c("ProductID", "UserID"), c("PID", "UID"))
setnames(transactions, c("PID", "UID"), c("ProductID", "UserID"))  # change them back


#======================================================================================================
# Row subsetting

# Display rows 1, 3, and 6
transactions[c(1,3,6)]

# Display rows exlcuding 1, 3, and 6
transactions[!c(1,3,6)]

# Display the first 3 rows
transactions[1:3]
head(transactions, 3)

# Display rows excluding the first 3 rows
transactions[-1:-3]
tail(transactions, -3)

# Display the last 2 rows
indices <- seq(nrow(transactions) - 1, nrow(transactions), by=1)
transactions[indices]
tail(transactions, 2)

# Display rows excluding the last 2 rows
transactions[!indices]
tail(transactions, -2)

# Display rows where Quantity > 1
transactions[Quantity > 1]

# Display rows where UserID = 2
transactions[UserID == 2]

# Display rows where Quantity > 1 and UserID = 2
transactions[Quantity > 1 & UserID == 2]

# Display rows where Quantity + UserID is > 3
transactions[Quantity + UserID > 3]

# Display rows where an external vector, foo, is TRUE
foo <- c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)
transactions[foo]

# Display rows where an external vector, bar, is positive
bar <- c(1, -3, 2, 2, 0, -4, -4, 0, 0, 2)
transactions[sign(bar) == 1]

# Display rows where foo is TRUE or bar is negative
transactions[foo | sign(bar) == -1]

# Display the rows where foo is not TRUE and bar is not negative
transactions[!(foo | sign(bar) == -1)]
transactions[!foo & sign(bar) > -1]


#======================================================================================================
# Column subsetting

# Subset by columns TransactionID and TransactionDate
transactions[, list(TransactionID, TransactionDate)]
transactions[, .(TransactionID, TransactionDate)]  # short-hand version of line above

# Subset rows where TransactionID > 100 and subset columns by TransactionID and TransactionDate
transactions[TransactionID > 100, list(TransactionID, TransactionDate)]

# Print columns defined by a vector of colum-names
print_cols <- c("TransactionID", "UserID", "Quantity")
transactions[, print_cols, with=FALSE]

# Print columns defined by a vector of colum-names
print_cols <- c("TransactionID", "UserID", "Quantity")
transactions[, print_cols, with=FALSE]

# Print columns excluding a vector of colum-names
transactions[, !print_cols, with=FALSE]


#======================================================================================================
# Inserting & Updating Values

# Insert a new column, Foo = UserID + ProductID
transactions[, Foo := UserID + ProductID]

# Subset rows where TransactionID is even and set Foo = NA
transactions[TransactionID %% 2 == 0, Foo := NA]


#======================================================================================================
# Ordering the rows


#======================================================================================================
# Group By & Aggregation


#======================================================================================================
# Joins


#======================================================================================================
# Reshaping

# Convert data from wide to tall

# Convert data from tall to wide


#======================================================================================================
# Miscellaneous

# Get rows which contain at least 1 NA value
# Get rows which contain at least 1 NA value within a subset of columns

# Get rows which contain all NA values
# Get rows which contain all NA values within a subset of columns

# Get the max value per row
# Get the max value per row within a subset of columns

# For each (user, transaction), determine which transaction he/she made on the prior day

# Determnine how many transactions each user made. Insert stat as field in transactions
