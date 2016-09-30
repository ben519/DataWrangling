# Data Wrangling With data.table

## Intro
Note that the examples here use [data.table](https://github.com/Rdatatable/data.table) version 1.9.8. Some of the methods are NOT compatible with prior versions of data.table (e.g. non-equi joins and secondary indexing).

---

### Install data.table ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#install-numpy-and-pandas-datatable))
```r
install.packages("data.table")
```

---

### Load data.table ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#import-numpy-and-pandas-datatable))
```r
library(data.table)
```

---

### Build a data.table from scratch ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#build-a-dataframe-from-scratch-datatable))
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

### Read data from a CSV file ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#read-data-from-a-csv-file-datatable))

##### Load transactions ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#load-transactions-datatable))
```r
transactions <- fread("https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/transactions.csv")
```

---

### Meta info ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#meta-info-datatable))

##### Full summary ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#full-summary-datatable))
```r
str(transactions)
```

##### How many rows? ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#how-many-rows-datatable))
```r
nrow(transactions)
```

##### How many columns? ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#how-many-columns-datatable))
```r
ncol(transactions)
```

##### Get the row names ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#get-the-row-names-datatable))
```r
rownames(transactions)
```

##### Get the column names ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#get-the-column-names-datatable))
```r
colnames(transactions)
```

##### Change the name of column "Quantity" to "Quant" ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#change-the-name-of-column-quantity-to-quant-datatable))
```r
setnames(transactions, "Quantity", "Quant")
setnames(transactions, "Quant", "Quantity")  # change it back
```

#### Change the name of columns ProductID and UserID to PID and UID respectively ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#change-the-name-of-columns-productid-and-userid-to-pid-and-uid-respectively-datatable))
```r
setnames(transactions, c("ProductID", "UserID"), c("PID", "UID"))
setnames(transactions, c("PID", "UID"), c("ProductID", "UserID"))  # change them back
```

---

### Ordering the rows of a data.table ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#ordering-the-rows-of-a-dataframe-datatable))

##### Order the rows of transactions by TransactionID descending ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#order-the-rows-of-transactions-by-transactionid-descending-datatable))
```r
transactions[order(-TransactionID)]
```

##### Order the rows of transactions by Quantity ascending, TransactionDate descending ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#order-the-rows-of-transactions-by-quantity-ascending-transactiondate-descending-datatable))
```r
setorderv(transactions, c("Quantity", "TransactionDate"), order=c(1, -1))
setorder(transactions, TransactionID)  # change it back
```

---

### Ordering the columns of a data.table ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#ordering-the-columns-of-a-dataframe-datatable))

#####  Set the column order of transactions as ProductID, Quantity, TransactionDate, TransactionID, UserID ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#set-the-column-order-of-transactions-as-productid-quantity-transactiondate-transactionid-userid-datatable))
```r
setcolorder(transactions, c("ProductID", "Quantity", "TransactionDate", "TransactionID", "UserID"))
setcolorder(transactions, c("TransactionID", "TransactionDate", "UserID", "ProductID", "Quantity"))  # reset the column order
```

#####  Make UserID the first column of transactions ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#make-userid-the-first-column-of-transactions-datatable))
```r
setcolorder(transactions, unique(c("UserID", colnames(transactions))))
setcolorder(transactions, c("TransactionID", "TransactionDate", "UserID", "ProductID", "Quantity"))  # reset the column order
```

---

### Extracting vectors from a data.table ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#extracting-arrays-from-a-dataframe-datatable))

##### Get the 2nd column ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#get-the-2nd-column-datatable))
```r
transactions[[2]]
```

##### Get the ProductID vector ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#get-the-productid-array-datatable))
```r
transactions$ProductID
```

##### Get the ProductID vector using a variable ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#get-the-productid-array-using-a-variable-datatable))
```r
col <- "ProductID"
transactions[[col]]
```

---

### Row subsetting ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#row-subsetting-datatable))

##### Subset rows 1, 3, and 6 ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-rows-1-3-and-6-datatable))
```r
transactions[c(1,3,6)]
```

##### Subset rows exlcuding 1, 3, and 6 ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-rows-exlcuding-1-3-and-6-datatable))
```r
transactions[-c(1,3,6)]
transactions[!c(1,3,6)]
```

##### Subset the first 3 rows ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-the-first-3-rows-datatable))
```r
transactions[1:3]
head(transactions, 3)
```

##### Subset rows excluding the first 3 rows ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-rows-excluding-the-first-3-rows-datatable))
```r
transactions[-1:-3]
tail(transactions, -3)
```

##### Subset the last 2 rows ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-the-last-2-rows-datatable))
```r
tail(transactions, 2)
```

##### Subset rows excluding the last 2 rows ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-rows-excluding-the-last-2-rows-datatable))
```r
tail(transactions, -2)
```

##### Subset rows where Quantity > 1 ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-rows-where-quantity--1-datatable))
```r
transactions[Quantity > 1]
```

##### Subset rows where UserID = 2 ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-rows-where-userid--2-datatable))
```r
transactions[UserID == 2]
```

##### Subset rows where Quantity > 1 and UserID = 2 ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-rows-where-quantity--1-and-userid--2-datatable))
```r
transactions[Quantity > 1 & UserID == 2]
```

##### Subset rows where Quantity + UserID is > 3 ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-rows-where-quantity--userid-is--3-datatable))
```r
transactions[Quantity + UserID > 3]
```

##### Subset rows where an external vector, foo, is TRUE ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-rows-where-an-external-array-foo-is-true-datatable))
```r
foo <- c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)
transactions[foo]
```

##### Subset rows where an external vector, bar, is positive ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-rows-where-an-external-array-bar-is-positive-datatable))
```r
bar <- c(1, -3, 2, 2, 0, -4, -4, 0, 0, 2)
transactions[sign(bar) == 1]
```

##### Subset rows where foo is TRUE or bar is negative ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-rows-where-foo-is-true-or-bar-is-negative-datatable))
```r
transactions[foo | sign(bar) == -1]
```

##### Subset the rows where foo is not TRUE and bar is not negative ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-the-rows-where-foo-is-not-true-and-bar-is-not-negative-datatable))
```r
transactions[!foo & sign(bar) > -1]
```

---

### Column subsetting ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#column-subsetting-datatable))

##### Subset by columns 1 and 3 ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-by-columns-1-and-3-datatable))
```r
transactions[, c(1, 3), with=FALSE]
```

##### Subset by columns TransactionID and TransactionDate ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-by-columns-transactionid-and-transactiondate-datatable))
```r
transactions[, list(TransactionID, TransactionDate)]
transactions[, .(TransactionID, TransactionDate)]  # short-hand version of line above
```

##### Subset rows where TransactionID > 5 and subset columns by TransactionID and TransactionDate ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-rows-where-transactionid--5-and-subset-columns-by-transactionid-and-transactiondate-datatable))
```r
transactions[TransactionID > 5, list(TransactionID, TransactionDate)]
```

##### Subset columns by a variable vector of columm names ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-columns-by-a-variable-list-of-columm-names-datatable))
```r
cols <- c("TransactionID", "UserID", "Quantity")
transactions[, cols, with=FALSE]
```

##### Subset columns excluding a variable vector of column names ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-columns-excluding-a-variable-list-of-column-names-datatable))
```r
cols <- c("TransactionID", "UserID", "Quantity")
transactions[, !cols, with=FALSE]
```

---

### Inserting and updating values ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#inserting-and-updating-values-datatable))

##### Convert the TransactionDate column to type Date ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#convert-the-transactiondate-column-to-type-date-datatable))
```r
transactions[, TransactionDate := as.Date(TransactionDate)]
```

##### Insert a new column, Foo = UserID + ProductID ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#insert-a-new-column-foo--userid--productid-datatable))
```r
transactions[, Foo := UserID + ProductID]
```

##### Subset rows where TransactionID is even and set Foo = NA ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#subset-rows-where-transactionid-is-even-and-set-foo--na-datatable))
```r
transactions[TransactionID %% 2 == 0, Foo := NA]
```

##### Add 100 to each TransactionID ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#add-100-to-each-transactionid-datatable))
```r
transactions[, TransactionID := TransactionID + 100L]
transactions[, TransactionID := TransactionID - 100L]  # revert to original IDs
```

##### Insert a column indicating each row number ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#insert-a-column-indicating-each-row-number-datatable))
```r
transactions[, RowIdx := .I]
```

##### Insert columns indicating the rank of each Quantity, minimum Quantity and maximum Quantity ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#insert-columns-indicating-the-rank-of-each-quantity-minimum-quantity-and-maximum-quantity-datatable))
```r
transactions[, `:=`(QuantityRk=frank(Quantity, ties.method = "average"), QuantityMin=min(Quantity), QuantityMax=max(Quantity))]
```

##### Remove column Foo ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#remove-column-foo-datatable))
```r
transactions[, Foo := NULL]
```

##### Remove multiple columns RowIdx, QuantityRk, and RowIdx ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#remove-multiple-columns-rowidx-quantityrk-and-rowidx-datatable))
```r
transactions[, c("RowIdx", "QuantityRk", "QuantityMin", "QuantityMax") := NULL]
```

---

### Grouping the rows of a data.table ([pandas](#))

#### Group By + Aggregate ([pandas](#))

##### Group the transations per user, measuring the number of transactions per user ([pandas](#))
```r
transactions[, list(Transactions = .N), by=UserID]
```

##### Group the transactions per user, measuring the transactions and average quantity per user ([pandas](#))
```r
transactions[, list(Transactions = .N, QuantityAvg = mean(Quantity)), by=UserID]
```

##### Group the transactions per year of the transaction date, measuring the number of transactions per year ([pandas](#))
```r
transactions[, list(Transactions = .N), by=year(TransactionDate)]
```

##### Group the transactions per (user, transaction-year) pair, measuring the number of transactions per group ([pandas](#))
```r
transactions[, list(Transactions = .N), by=list(UserID, TransactionYear=year(TransactionDate))]
```

##### Group the transactions per user, measuring the max quantity each user made for a single transaction and the date of that transaction ([pandas](#))
```r
transactions[, list(MaxTransactionQuantityDate=TransactionDate[which.max(Quantity)], MaxQuantity=max(Quantity)), by=UserID]
```

##### Group the transactions per (user, transaction-year), and then group by transaction-year to get the number of users who made a transaction each year ([pandas](#))
```r
transactions[, list(Transactions = .N), by=list(UserID, TransactionYear=year(TransactionDate))][, list(Users=.N), by=TransactionYear]
```

#### Group By + Update ([pandas](#))

##### Insert a column in transactions indicating the number of transactions per user ([pandas](#))
```r
transactions[, UserTransactions := .N, by=UserID]
```

##### Insert columns in transactions indicating the first transaction date and last transaction date per user ([pandas](#))
```r
transactions[, `:=`(FirstTransactionDate=min(TransactionDate), LastTransactionDate=max(TransactionDate)), by=UserID]
```

##### For each transaction, get the date of the previous transaction made by the same user ([pandas](#))
```r
setorder(transactions, "UserID", "TransactionDate")
transactions[, PrevTransactionDate := c(as.Date(NA), head(TransactionDate, -1)), by=UserID]
```

---

### Joining data.tables ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#joining-dataframes-datatable))

#### Setup ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#setup-datatable))
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

#### Basic Joins ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#basic-joins))

##### Join users to transactions, keeping all rows from transactions and only matching rows from users (left join) ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#join-users-to-transactions-keeping-all-rows-from-transactions-and-only-matching-rows-from-users-left-join-datatable))
```r
users[transactions, on="UserID"]
```

##### Which transactions aren't tied to a user in users? (anti join) ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#which-transactions-arent-tied-to-a-user-in-users-anti-join-datatable))
```r
transactions[!users, on="UserID"]
```

##### Join users to transactions, keeping only rows from transactions and users that match via UserID (inner join) ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#join-users-to-transactions-keeping-only-rows-from-transactions-and-users-that-match-via-userid-inner-join-datatable))
```r
users[transactions, on="UserID", nomatch=0]
```

##### Join users to transactions, displaying all matching rows AND all non-matching rows (full outer join) ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#join-users-to-transactions-displaying-all-matching-rows-and-all-non-matching-rows-full-outer-join-datatable))
```r
merge(users, transactions, by="UserID", all=TRUE)
```

##### Determine which sessions occured on the same day each user registered ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#determine-which-sessions-occured-on-the-same-day-each-user-registered-datatable))
```r
users[sessions, on=c("UserID", "Registered" = "SessionDate"), nomatch=0]
```

##### Build a dataset with every possible (UserID, ProductID) pair (cross join) ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#build-a-dataset-with-every-possible-userid-productid-pair-cross-join-datatable))
```r
CJ(UserID=users$UserID, ProductID=products$ProductID)
```

##### Determine how much quantity of each product was purchased by each user ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#determine-how-much-quantity-of-each-product-was-purchased-by-each-user-datatable))
```r
transactions[, list(Quantity=sum(Quantity)), by=list(UserID, ProductID)][CJ(UserID=users$UserID, ProductID=products$ProductID), on=c("UserID", "ProductID")]
```

##### For each user, get each possible pair of pair transactions (TransactionID1, TransactionID2) ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#for-each-user-get-each-possible-pair-of-pair-transactions-transactionid1-transactionid2-datatable))
```r
t1 <- transactions[, list(UserID, TransactionID1=TransactionID)]
t2 <- transactions[, list(UserID, TransactionID2=TransactionID)]
t1[t2, on="UserID", allow.cartesian=TRUE]
```

##### Join each user to his/her first occuring transaction in the transactions table ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#join-each-user-to-hisher-first-occuring-transaction-in-the-transactions-table-datatable))
```r
transactions[users, on="UserID", mult="first"]
```

#### Rolling Joins ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#rolling-joins-datatable))

##### Determine the ID of the last session which occured prior to (and including) the date of each transaction per user ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#determine-the-id-of-the-last-session-which-occured-prior-to-and-including-the-date-of-each-transaction-per-user-datatable))
```r
sessions[, RollDate := SessionDate]
transactions[, RollDate := TransactionDate]
setkey(sessions, "UserID", "RollDate")
setkey(transactions, "UserID", "RollDate")
sessions[transactions, roll=TRUE]
```

##### Determine the ID of the first session which occured after (and including) the date of each transaction per user ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#determine-the-id-of-the-first-session-which-occured-after-and-including-the-date-of-each-transaction-per-user-datatable))
```r
sessions[, RollDate := SessionDate]
transactions[, RollDate := TransactionDate]
setkey(sessions, "UserID", "RollDate")
setkey(transactions, "UserID", "RollDate")
sessions[transactions, roll=-Inf]
```

#### Non-equi joins ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#non-equi-joins-datatable))

##### Determine the first transaction that occured for each user prior to (and including) his/her Cancelled date ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#determine-the-first-transaction-that-occured-for-each-user-prior-to-and-including-hisher-cancelled-date-datatable))
```r
setorder(transactions, "TransactionDate")
transactions[users, on=list(UserID, TransactionDate <= Cancelled), mult="first"]
```

##### Get all transactions where TransactionDate is after the user's Cancellation Date ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#get-all-transactions-where-transactiondate-is-after-the-users-cancellation-date-datatable))
```r
users[transactions, on=list(UserID, Cancelled < TransactionDate), nomatch=0]
```

#### Join + Update ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#join--update-datatable))

##### Insert the price of each product in the transactions dataset (join + update) ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#insert-the-price-of-each-product-in-the-transactions-dataset-join--update-datatable))
```r
transactions[products, ProductPrice := Price, on="ProductID"]
```

##### Insert the number of transactions each user made into the users dataset ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#insert-the-number-of-transactions-each-user-made-into-the-users-dataset-datatable))
```r
users[transactions, on="UserID", Transactions := .N, by=UserID]
```

#### Setting a key and secondary indexing ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#setting-indexes-datatable))

##### Set the key of Transactions as UserID ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#set-the-index-of-transactions-as-userid-datatable))
```r
setkey(transactions, "UserID")  # notice rows are now sorted by UserID
```

##### View the key of transactions ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#view-the-index-of-transactions-datatable))
```r
key(transactions)
```

##### Set the key of users as UserID and join to transactions, matching rows only (inner join) ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#set-the-index-of-users-as-userid-and-join-to-transactions-matching-rows-only-inner-join-datatable))
```r
setkey(users, "UserID")
transactions[users, nomatch=0]
```

##### Set ProductID as the key of transactions and products without re-ordering the rows, then join matching rows only ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#set-productid-as-the-index-of-transactions-and-products-without-re-ordering-the-rows-then-join-matching-rows-only-datatable))
```r
setkey(transactions, "ProductID", physical=FALSE)
setkey(products, "ProductID", physical=FALSE)
transactions[products, nomatch=0]
```

##### Set each ID column as a secondary join index ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#set-each-id-column-as-a-secondary-join-index-datatable))
```r
setindex(transactions, "TransactionID")
setindex(transactions, "ProductID")
setindex(transactions, "UserID")
setindex(products, "ProductID")
setindex(users, "UserID")
```

##### View indices ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#view-indices-datatable))
```r
indices(transactions)
indices(products)
indices(users)
```

##### Inner join between users, transactions, and products ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#inner-join-between-users-transactions-and-products-datatable))
```r
users[transactions, on="UserID"][products, on="ProductID"]  # Note that having the pre-computed secondary indices makes this faster
```

---

### Reshaping a data.table ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#reshaping-a-dataframe-datatable))

#### Setup ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#setup-datatable-1))
```r
# Read datasets from CSV
users <- fread("https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/users.csv")
transactions <- transactions <- fread("https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/transactions.csv")

# Convert date columns to Date type
users[, `:=`(Registered = as.Date(Registered), Cancelled = as.Date(Cancelled))]
transactions[, TransactionDate := as.Date(TransactionDate)]

# Add column TransactionWeekday as a factor with levels Sunday through Saturday
transactions[, TransactionWeekday := factor(weekdays(TransactionDate), levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))]
```

#### Convert data from tall format to wide format ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#convert-data-from-tall-format-to-wide-format-datatable))

##### One-hot encode Weekday (i.e. convert data from tall to wide, where each possible weekday is a column) ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#one-hot-encode-weekday-ie-convert-data-from-tall-to-wide-where-each-possible-weekday-is-a-column-datatable))
```r
dcast(transactions, TransactionID ~ TransactionWeekday, value.var="TransactionWeekday", fun.aggregate=function(x) length(x))
```

#### Convert data from wide format to tall format ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#convert-data-from-wide-format-to-tall-format-datatable))

#####  Build a data.table with columns {UserID, ActionType, Date} where ActionType is either "Registered" or "Cancelled" and Date is the corresponding date value ([pandas](https://github.com/ben519/DataWrangling/tree/master/Python#build-a-dataframe-with-columns-userid-actiontype-date-where-actiontype-is-either-registered-or-cancelled-and-date-is-the-corresponding-date-value-datatable))
```r
melt(users, id.vars="UserID", measure.vars=c("Registered", "Cancelled"), variable.name="ActionType", value.name="Date")
```
