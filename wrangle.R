library(data.table)

#======================================================================================================
# Build dataset from scratch

transactions <- data.table(
  TransactionID = seq(1, 10),
  TransactionDate = as.Date(c("2011-06-16", "2012-08-26", "2013-12-30", "2011-05-26", "2014-04-24", 
                              "2016-05-08", "2010-08-21", "2013-12-23", "2013-06-06", "2015-04-24")),
  ProductID = c(3L, 2L, 4L, 4L, 2L, 4L, 2L, 5L, 4L, 4L), 
  UserID = c(3L, 1L, 3L, 3L, 1L, 5L, 1L, 2L, 2L, 3L), 
  Quantity = c(0L, 3L, 0L, 0L, 3L, 4L, 0L, 6L, 0L, 3L)
)

#======================================================================================================
# Read and write to CSV

# Write transactions to CSV
write.csv(transactions, "Data/transactions.csv", row.names=FALSE)

# Read transactions from CSV
transactions <- fread("Data/transactions.csv")

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
transactions[!foo & sign(bar) > -1]


#======================================================================================================
# Column subsetting

# Get columns 1 and 3
transactions[, c(1, 3), with=FALSE]

# Subset by columns TransactionID and TransactionDate
transactions[, list(TransactionID, TransactionDate)]
transactions[, .(TransactionID, TransactionDate)]  # short-hand version of line above

# Subset rows where TransactionID > 100 and subset columns by TransactionID and TransactionDate
transactions[TransactionID > 100, list(TransactionID, TransactionDate)]

# Print columns defined by a vector of colum-names
print_cols <- c("TransactionID", "UserID", "Quantity")
transactions[, print_cols, with=FALSE]

# Get columns defined by a vector of colum-names
print_cols <- c("TransactionID", "UserID", "Quantity")
transactions[, print_cols, with=FALSE]

# Get columns excluding a vector of colum-names
transactions[, !print_cols, with=FALSE]


#======================================================================================================
# Extract a vector

# Get the 2nd column
transactions[[2]]

# Get the ProductID vector
transactions$ProductID

# Get the ProductID vector using a variable
col <- "ProductID"
transactions[[col]]

#======================================================================================================
# Inserting & Updating Values

# Convert the TransactionDate column to type Date
transactions[, TransactionDate := as.Date(TransactionDate)]

# Insert a new column, Foo = UserID + ProductID
transactions[, Foo := UserID + ProductID]

# Subset rows where TransactionID is even and set Foo = NA
transactions[TransactionID %% 2 == 0, Foo := NA]

# Add 100 to each TransactionID
transactions[, TransactionID := 100 + TransactionID]
transactions[, TransactionID := TransactionID - 100]  # revert to original IDs

# Insert a column indicating each row number
transactions[, RowIdx := .I]

# Insert columns indicating the rank of each Quantity, minimum Quantity and maximum Quantity
transactions[, `:=`(QuantityRk=frank(Quantity, ties.method = "average"), QuantityMin=min(Quantity), QuantityMax=max(Quantity))]

# Remove column Foo
transactions[, Foo := NULL]

# Remove multiple columns RowIdx, QuantityRk, and RowIdx
transactions[, c("RowIdx", "QuantityRk", "QuantityMin", "QuantityMax") := NULL]

#======================================================================================================
# Ordering the rows

# Order by TransactionID descending
transactions <- transactions[order(-TransactionID)]
transactions <- transactions[order(TransactionID)]  # change it back

# Order by UserID descending, TransactionDate descending
setorderv(transactions, c("Quantity", "TransactionDate"), order=c(1, -1))
setorder(transactions, TransactionID)  # change it back

#======================================================================================================
# Group By & Aggregation

# Count the number of transactions per user
transactions[, list(Transactions = .N), by=UserID]

# Count the number of transactions & average Quantity per user
transactions[, list(Transactions = .N, QuantityAvg = mean(Quantity)), by=UserID]

# Count the transactions per year
transactions[, list(Transactions = .N), by=year(TransactionDate)]

# Count the transactions per (user, year) pair
transactions[, list(Transactions = .N), by=list(UserID, TransactionYear=year(TransactionDate))]

# Count the number of unique users which made a transaction per year (this is called chaining)
transactions[, list(Transactions = .N), by=list(UserID, TransactionYear=year(TransactionDate))][, list(Users=.N), by=TransactionYear]

# For each user in transactions, get the date of the transaction which had the most quantity
transactions[, list(TargetDate=TransactionDate[which.min(Quantity)], MinQuantity=min(Quantity)), by=UserID]

# Insert a column in transactions indicating the number of transactions per user
transactions[, UserTransactions := .N, by=UserID]

# Insert columns in transactions indicating the first transaction date and last transaction date per user
transactions[, `:=`(FirstTransactionDate=min(TransactionDate), LastTransactionDate=max(TransactionDate)), by=UserID]


#======================================================================================================
# Joins

# Read datasets from CSV (to clear existing )
users <- fread("Data/users.csv")
products <- fread("Data/products.csv")
transactions <- fread("Data/transactions.csv")

# Set the first UserID to NA
transactions[1, UserID := NA]

# Join users to transactions, keeping all rows from transactions and only matching rows from users (left join)
users[transactions, on="UserID"]

# Which transactions aren't tied to a user in users
transactions[!users, on="UserID"]

# Join users to transactions, keeping only rows from transactions and users that match via UserID (inner join)
users[transactions, on="UserID", nomatch=0]

# Join users to transactions, displaying all matching rows AND all non-matching rows (full outer join)
merge(users, transactions, by="UserID", all=TRUE)

# Determine which transactions each user made on the same day he/she registered
transactions[users, on=c("UserID", "TransactionDate"="Registered")]

# Build a dataset with every possible (UserID, ProductID) pair (cross join)
CJ(UserID=users$UserID, ProductID=products$ProductID)

# Determine how much quantity of each product was purchased by each user
transactions[, list(Quantity=sum(Quantity)), by=list(UserID, ProductID)][CJ(UserID=users$UserID, ProductID=products$ProductID), on=c("UserID", "ProductID")]

# For each user, get each possible pair of pair transactions (TransactionID1, TransactionID2)
t1 <- transactions[, list(UserID, TransactionID1=TransactionID)]
t2 <- transactions[, list(UserID, TransactionID2=TransactionID)]
t1[t2, on="UserID", allow.cartesian=TRUE]

# Join each user to his/her first occuring transaction in the transactions table
transactions[users, on="UserID", mult="first"]

# Insert the price of each product in the transactions dataset (join + update)
transactions[products, ProductPrice := Price, on="ProductID"]


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
