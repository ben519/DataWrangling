# Data Wrangling With data.table

## Intro
Note that the examples here use [data.table](https://github.com/Rdatatable/data.table) version 1.9.8. Some of the methods are NOT compatible with prior versions of data.table (e.g. non-equi joins and secondary indexing).

---

### Install the data.table package ([pandas cross reference](#))
```r
install.packages("data.table")
```

---

### Load the data.table package ([pandas cross reference](https://github.com/ben519/DataWrangling/tree/master/Python#import-the-pandas-package))
```r
library(data.table)
```

---

### Build a data.table from scratch ([pandas cross reference](https://github.com/ben519/DataWrangling/tree/master/Python#build-a-dataset-from-scratch))
```r
transactions <- data.table(
TransactionID = seq(1, 10),
TransactionDate = as.Date(c("2011-06-16", "2012-08-26", "2013-12-30", "2011-05-26", "2014-04-24", 
"2016-05-08", "2010-08-21", "2013-12-23", "2013-06-06", "2015-04-24")),
ProductID = c(3L, 2L, 4L, 4L, 2L, 4L, 2L, 5L, 4L, 4L), 
UserID = c(3L, 1L, 3L, 3L, 1L, 5L, 1L, 2L, 2L, 3L), 
Quantity = c(0L, 3L, 0L, 0L, 3L, 4L, 0L, 6L, 0L, 3L)
)
```

---

### Read data from a CSV file ([pandas cross reference](#))
```r
transactions <- fread("https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/transactions.csv")
```

---

### Meta info ([pandas cross reference](#))

##### Full summary ([pandas cross reference](#))
```r
str(transactions)
```

##### How many rows? ([pandas cross reference](#))
```r
nrow(transactions)
```

##### How many columns? ([pandas cross reference](#))
```r
ncol(transactions)
```

##### Get the row names ([pandas cross reference](#))
```r
rownames(transactions)
```

##### Get the column names ([pandas cross reference](#))
```r
colnames(transactions)
```

##### Change the name of column "Quantity" to "Quant" ([pandas cross reference](#))
```r
setnames(transactions, "Quantity", "Quant")
setnames(transactions, "Quant", "Quantity")  # change it back
```

#### Change the name of columns ProductID and UserID to PID and UID respectively ([pandas cross reference](#))
```r
setnames(transactions, c("ProductID", "UserID"), c("PID", "UID"))
setnames(transactions, c("PID", "UID"), c("ProductID", "UserID"))  # change them back
```

---

### Row subsetting ([pandas cross reference](#))

##### Subset rows 1, 3, and 6 ([pandas cross reference](#))
```r
transactions[c(1,3,6)]
```

##### Subset rows exlcuding 1, 3, and 6 ([pandas cross reference](#))
```r
transactions[!c(1,3,6)]
```

##### Subset the first 3 rows ([pandas cross reference](#))
```r
transactions[1:3]
head(transactions, 3)
```

##### Subset rows excluding the first 3 rows ([pandas cross reference](#))
```r
transactions[-1:-3]
tail(transactions, -3)
```

##### Subset the last 2 rows ([pandas cross reference](#))
```r
indices <- seq(nrow(transactions) - 1, nrow(transactions), by=1)
transactions[indices]
tail(transactions, 2)
```

##### Subset rows excluding the last 2 rows ([pandas cross reference](#))
```r
transactions[!indices]
tail(transactions, -2)
```

##### Subset rows where Quantity > 1 ([pandas cross reference](#))
```r
transactions[Quantity > 1]
```

##### Subset rows where UserID = 2 ([pandas cross reference](#))
```r
transactions[UserID == 2]
```

##### Subset rows where Quantity > 1 and UserID = 2 ([pandas cross reference](#))
```r
transactions[Quantity > 1 & UserID == 2]
```

##### Subset rows where Quantity + UserID is > 3 ([pandas cross reference](#))
```r
transactions[Quantity + UserID > 3]
```

##### Subset rows where an external vector, foo, is TRUE ([pandas cross reference](#))
```r
foo <- c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)
transactions[foo]
```

##### Subset rows where an external vector, bar, is positive ([pandas cross reference](#))
```r
bar <- c(1, -3, 2, 2, 0, -4, -4, 0, 0, 2)
transactions[sign(bar) == 1]
```

##### Subset rows where foo is TRUE or bar is negative ([pandas cross reference](#))
```r
transactions[foo | sign(bar) == -1]
```

##### Subset the rows where foo is not TRUE and bar is not negative ([pandas cross reference](#))
```r
transactions[!foo & sign(bar) > -1]
```

---

### Column subsetting ([pandas cross reference](#))

##### Subset by columns 1 and 3 ([pandas cross reference](#))
```r
transactions[, c(1, 3), with=FALSE]
```

##### Subset by columns TransactionID and TransactionDate ([pandas cross reference](#))
```r
transactions[, list(TransactionID, TransactionDate)]
transactions[, .(TransactionID, TransactionDate)]  # short-hand version of line above
```

##### Subset rows where TransactionID > 5 and subset columns by TransactionID and TransactionDate ([pandas cross reference](#))
```r
transactions[TransactionID > 5, list(TransactionID, TransactionDate)]
```

##### Subset columns defined by a vector of columm names ([pandas cross reference](#))
```r
print_cols <- c("TransactionID", "UserID", "Quantity")
transactions[, print_cols, with=FALSE]
```

##### Subset columns defined by a vector of column names ([pandas cross reference](#))
```r
print_cols <- c("TransactionID", "UserID", "Quantity")
transactions[, print_cols, with=FALSE]
```

##### Subset columns excluding a vector of column names ([pandas cross reference](#))
```r
transactions[, !print_cols, with=FALSE]
```

---

### Extracting vectors from a data.table ([pandas cross reference](#))

##### Get the 2nd column ([pandas cross reference](#))
```r
transactions[[2]]
```

##### Get the ProductID vector ([pandas cross reference](#))
```r
transactions$ProductID
```

##### Get the ProductID vector using a variable ([pandas cross reference](#))
```r
col <- "ProductID"
transactions[[col]]
```

---

### Inserting and updating values ([pandas cross reference](#))

##### Convert the TransactionDate column to type Date ([pandas cross reference](#))
```r
transactions[, TransactionDate := as.Date(TransactionDate)]
```

##### Insert a new column, Foo = UserID + ProductID ([pandas cross reference](#))
```r
transactions[, Foo := UserID + ProductID]
```

##### Subset rows where TransactionID is even and set Foo = NA ([pandas cross reference](#))
```r
transactions[TransactionID %% 2 == 0, Foo := NA]
```

##### Add 100 to each TransactionID ([pandas cross reference](#))
```r
transactions[, TransactionID := 100 + TransactionID]
transactions[, TransactionID := TransactionID - 100]  # revert to original IDs
```

##### Insert a column indicating each row number ([pandas cross reference](#))
```r
transactions[, RowIdx := .I]
```

##### Insert columns indicating the rank of each Quantity, minimum Quantity and maximum Quantity ([pandas cross reference](#))
```r
transactions[, `:=`(QuantityRk=frank(Quantity, ties.method = "average"), QuantityMin=min(Quantity), QuantityMax=max(Quantity))]
```

##### Remove column Foo ([pandas cross reference](#))
```r
transactions[, Foo := NULL]
```

##### Remove multiple columns RowIdx, QuantityRk, and RowIdx ([pandas cross reference](#))
```r
transactions[, c("RowIdx", "QuantityRk", "QuantityMin", "QuantityMax") := NULL]
```

---

### Ordering the rows of a data.table ([pandas cross reference](#))

##### Order by TransactionID descending ([pandas cross reference](#))
```r
transactions[order(-TransactionID)]
```

##### Order by UserID descending, TransactionDate descending ([pandas cross reference](#))
```r
setorderv(transactions, c("Quantity", "TransactionDate"), order=c(1, -1))
setorder(transactions, TransactionID)  # change it back
```

---

### Joining data.tables ([pandas cross reference](#))

#### Setup ([pandas cross reference](#))
```r
# Load datasets from CSV
users <- fread("https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/users.csv")
sessions <- fread("https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/sessions.csv")
products <- fread("https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/products.csv")
transactions <- transactions <- fread("https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/transactions.csv")

# Convert date columns to Date type
users[, `:=`(Registered = as.Date(Registered), Cancelled = as.Date(Cancelled))]
sessions[, SessionDate := as.Date(SessionDate)]
transactions[, TransactionDate := as.Date(TransactionDate)]
```

#### Basic Joins

##### Join users to transactions, keeping all rows from transactions and only matching rows from users (left join) ([pandas cross reference](#))
```r
users[transactions, on="UserID"]
```

##### Which transactions aren't tied to a user in users ([pandas cross reference](#))
```r
transactions[!users, on="UserID"]
```

##### Join users to transactions, keeping only rows from transactions and users that match via UserID (inner join) ([pandas cross reference](#))
```r
users[transactions, on="UserID", nomatch=0]
```

##### Join users to transactions, displaying all matching rows AND all non-matching rows (full outer join) ([pandas cross reference](#))
```r
merge(users, transactions, by="UserID", all=TRUE)
```

##### Determine which sessions occured on the same day each user registered ([pandas cross reference](#))
```r
users[sessions, on=c("UserID", "Registered" = "SessionDate"), nomatch=0]
```

##### Build a dataset with every possible (UserID, ProductID) pair (cross join) ([pandas cross reference](#))
```r
CJ(UserID=users$UserID, ProductID=products$ProductID)
```

##### Determine how much quantity of each product was purchased by each user ([pandas cross reference](#))
```r
transactions[, list(Quantity=sum(Quantity)), by=list(UserID, ProductID)][CJ(UserID=users$UserID, ProductID=products$ProductID), on=c("UserID", "ProductID")]
```

##### For each user, get each possible pair of pair transactions (TransactionID1, TransactionID2) ([pandas cross reference](#))
```r
t1 <- transactions[, list(UserID, TransactionID1=TransactionID)]
t2 <- transactions[, list(UserID, TransactionID2=TransactionID)]
t1[t2, on="UserID", allow.cartesian=TRUE]
```

##### Join each user to his/her first occuring transaction in the transactions table ([pandas cross reference](#))
```r
transactions[users, on="UserID", mult="first"]
```

#### Rolling Joins ([pandas cross reference](#))

##### Determine the ID of the last session which occured prior to (and including) the date of each transaction per user ([pandas cross reference](#))
```r
sessions[, RollDate := SessionDate]
transactions[, RollDate := TransactionDate]
setkey(sessions, "UserID", "RollDate")
setkey(transactions, "UserID", "RollDate")
sessions[transactions, roll=TRUE]
```

##### Determine the ID of the first session which occured after (and including) the date of each transaction per user ([pandas cross reference](#))
```r
sessions[, RollDate := SessionDate]
transactions[, RollDate := TransactionDate]
setkey(sessions, "UserID", "RollDate")
setkey(transactions, "UserID", "RollDate")
sessions[transactions, roll=-Inf]
```

#### Non-equi joins ([pandas cross reference](#))

##### Determine the first transaction that occured for each user prior to (and including) his/her Cancelled date ([pandas cross reference](#))
```r
setorder(transactions, "TransactionDate")
transactions[users, on=list(UserID, TransactionDate <= Cancelled), mult="first"]
```

##### Get all transactions where TransactionDate is after the user's Cancellation Date ([pandas cross reference](#))
```r
users[transactions, on=list(UserID, Cancelled < TransactionDate), nomatch=0]
```

#### Join + Update ([pandas cross reference](#))

##### Insert the price of each product in the transactions dataset (join + update) ([pandas cross reference](#))
```r
transactions[products, ProductPrice := Price, on="ProductID"]
```

##### Insert the number of transactions each user made into the users dataset ([pandas cross reference](#))
```r
users[transactions, on="UserID", Transactions := .N, by=UserID]
```

#### Setting a key and secondary indexing ([pandas cross reference](#))

##### Set the key of Transactions as UserID  () ([pandas cross reference](#))
```r
setkey(transactions, "UserID")
transactions  # notice rows are now sorted by UserID
```

##### View the key of transactions ([pandas cross reference](#))
```r
key(transactions)
```

##### Set the key of users as UserID and join to transactions, matching rows only (inner join) ([pandas cross reference](#))
```r
setkey(users, "UserID")
transactions[users, nomatch=0]
```

##### Set ProductID as the key of transactions and products without re-ordering the rows, then join matching rows only ([pandas cross reference](#))
```r
setkey(transactions, "ProductID", physical=FALSE)
setkey(products, "ProductID", physical=FALSE)
transactions[products, nomatch=0]
```

##### Set each ID column as a secondary join index ([pandas cross reference](#))
```r
setindex(transactions, "TransactionID")
setindex(transactions, "ProductID")
setindex(transactions, "UserID")
setindex(products, "ProductID")
setindex(users, "UserID")
```

##### View indices ([pandas cross reference](#))
```r
indices(transactions)
indices(products)
indices(users)
```

##### Inner join between users, transactions, and products ([pandas cross reference](#))
```r
users[transactions, on="UserID"][products, on="ProductID"]  # Note that having the pre-computed secondary indices makes this faster
```

---

### Reshaping a data.table ([pandas cross reference](#))

#### Setup ([pandas cross reference](#))
```r
# Read datasets from CSV
users <- fread("https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/users.csv")
transactions <- transactions <- fread("https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/transactions.csv")

# Convert date columns to Date type
users[, `:=`(Registered = as.Date(Registered), Cancelled = as.Date(Cancelled))]
transactions[, TransactionDate := as.Date(TransactionDate)]

# Add column TransactionWeekday as a factor with levels Saturday through Friday
transactions[, TransactionWeekday := factor(weekdays(TransactionDate), levels=c("Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"))]
```

#### Convert data from tall format to wide format ([pandas cross reference](#))

##### One-hot encode Weekday (i.e. convert data from tall to wide, where each possible weekday is a column) ([pandas cross reference](#))
```r
dcast(transactions, TransactionID ~ TransactionWeekday, value.var="TransactionWeekday", fun.aggregate=function(x) length(x))
```

#### Convert data from wide format to tall format ([pandas cross reference](#))

#####  Build a data.table with columns {UserID, ActionType, Date} where ActionType is either "Registered" or "Cancelled" and Date is the corresponding date value ([pandas cross reference](#))
```r
melt(users, id.vars="UserID", measure.vars=c("Registered", "Cancelled"), variable.name="ActionType", value.name="Date")
```
