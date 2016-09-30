# Data Wrangling With pandas

## Intro
Note that the examples here use [pandas](https://github.com/pydata/pandas) version 0.18.1

---

### Install numpy and pandas ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#install-datatable-pandas-cross-reference))
```python
pip install numpy
pip install pandas
```

---

### Import numpy and pandas ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#load-datatable-pandas-cross-reference))
```python
import numpy as np
import pandas as pd
```

---

### Build a DataFrame from scratch ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#build-a-datatable-from-scratch-pandas-cross-reference))
```python
transactions = pd.DataFrame({
    'TransactionID': np.arange(10)+1,
    'TransactionDate': pd.to_datetime(['2010-08-21', '2011-05-26', '2011-06-16', '2012-08-26', '2013-06-06', 
                              '2013-12-23', '2013-12-30', '2014-04-24', '2015-04-24', '2016-05-08']).date,
    'UserID': [7, 3, 3, 1, 2, 2, 3, np.nan, 7, 3],
    'ProductID': [2, 4, 3, 2, 4, 5, 4, 2, 4, 4],
    'Quantity': [1, 1, 1, 3, 1, 6, 1, 3, 3, 4]
})
```

---

### Read data from a CSV file ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#read-data-from-a-csv-file-pandas-cross-reference))

##### Load transactions ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#load-transactions-pandas-cross-reference))
```python
transactions = pd.read_csv('https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/transactions.csv')
```

---

### Meta info ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#meta-info-pandas-cross-reference))

##### Full summary ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#full-summary-pandas-cross-reference))
```python
transactions.info()
```

##### How many rows? ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#how-many-rows-pandas-cross-reference))
```python
transactions.shape[0]
```

##### How many columns? ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#how-many-columns-pandas-cross-reference))
```python
transactions.shape[1]
```

##### Get the row names ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#get-the-row-names-pandas-cross-reference))
```python
transactions.index.values
```

##### Get the column names ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#get-the-column-names-pandas-cross-reference))
```python
transactions.columns.values
```

##### Change the name of column "Quantity" to "Quant" ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#change-the-name-of-column-quantity-to-quant-pandas-cross-reference))
```python
transactions.rename(columns={'Quantity': 'Quant'})  # use argument inplace=TRUE to keep the changes
```

##### Change the name of columns ProductID and UserID to PID and UID respectively ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#change-the-name-of-columns-productid-and-userid-to-pid-and-uid-respectively-pandas-cross-reference))
```python
transactions.rename(columns={'ProductID': 'PID', 'UserID': 'UID'})  # use argument inplace=TRUE to keep the changes
```

---

### Ordering the rows of a DataFrame ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#ordering-the-rows-of-a-datatable-pandas-cross-reference))

##### Order the rows of transactions by TransactionID descending ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#order-the-rows-of-transactions-by-transactionid-descending-pandas-cross-reference))
```python
transactions.sort_values('TransactionID', ascending=False)
```

##### Order the rows of transactions by Quantity ascending, TransactionDate descending ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#order-the-rows-of-transactions-by-quantity-ascending-transactiondate-descending-pandas-cross-reference))
```python
transactions.sort_values(['Quantity', 'TransactionDate'], ascending=[True, False])
```

---

### Ordering the columns of a DataFrame ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#ordering-the-columns-of-a-datatable-pandas-cross-reference))

##### Set the column order of transactions as ProductID, Quantity, TransactionDate, TransactionID, UserID ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#set-the-column-order-of-transactions-as-productid-quantity-transactiondate-transactionid-userid-pandas-cross-reference))
```python
transactions[['ProductID', 'Quantity', 'TransactionDate', 'TransactionID', 'UserID']]
```

##### Make UserID the first column of transactions ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#make-userid-the-first-column-of-transactions-pandas-cross-reference))
```python
transactions[pd.unique(['UserID'] + transactions.columns.values.tolist()).tolist()]
```

---

### Extracting arrays from a DataFrame ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#extracting-vectors-from-a-datatable-pandas-cross-reference))

##### Get the 2nd column ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#get-the-2nd-column-pandas-cross-reference))
```python
transactions[[1]].values[:, 0]
```

##### Get the ProductID array ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#get-the-productid-vector-pandas-cross-reference))
```python
transactions.ProductID.values
```

##### Get the ProductID array using a variable ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#get-the-productid-vector-using-a-variable-pandas-cross-reference))
```python
col = "ProductID"
transactions[[col]].values[:, 0]
```

---

### Row subsetting ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#row-subsetting-pandas-cross-reference))

##### Subset rows 1, 3, and 6 ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-rows-1-3-and-6-pandas-cross-reference))
```python
transactions.iloc[[0,2,5]]
```

##### Subset rows exlcuding 1, 3, and 6 ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-rows-exlcuding-1-3-and-6-pandas-cross-reference))
```python
transactions.drop([0,2,5], axis=0)
```

##### Subset the first 3 rows ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-the-first-3-rows-pandas-cross-reference))
```python
transactions[:3]
transactions.head(3)
```

##### Subset rows excluding the first 3 rows ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-rows-excluding-the-first-3-rows-pandas-cross-reference))
```python
transactions[3:]
transactions.tail(-3)
```

##### Subset the last 2 rows ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-the-last-2-rows-pandas-cross-reference))
```python
transactions.tail(2)
```

##### Subset rows excluding the last 2 rows ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-rows-excluding-the-last-2-rows-pandas-cross-reference))
```python
transactions.tail(-2)
```

##### Subset rows where Quantity > 1 ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-rows-where-quantity--1-pandas-cross-reference))
```python
transactions[transactions.Quantity > 1]
```

##### Subset rows where UserID = 2 ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-rows-where-userid--2-pandas-cross-reference))
```python
transactions[transactions.UserID == 2]
```

##### Subset rows where Quantity > 1 and UserID = 2 ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-rows-where-quantity--1-and-userid--2-pandas-cross-reference))
```python
transactions[(transactions.Quantity > 1) & (transactions.UserID == 2)]
```

##### Subset rows where Quantity + UserID is > 3 ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-rows-where-quantity--userid-is--3-pandas-cross-reference))
```python
transactions[transactions.Quantity + transactions.UserID > 3]
```

##### Subset rows where an external array, foo, is True ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-rows-where-an-external-vector-foo-is-true-pandas-cross-reference))
```python
foo = np.array([True, False, True, False, True, False, True, False, True, False])
transactions[foo]
```

##### Subset rows where an external array, bar, is positive ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-rows-where-an-external-vector-bar-is-positive-pandas-cross-reference))
```python
bar = np.array([1, -3, 2, 2, 0, -4, -4, 0, 0, 2])
transactions[bar > 0]
```

##### Subset rows where foo is TRUE or bar is negative ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-rows-where-foo-is-true-or-bar-is-negative-pandas-cross-reference))
```python
transactions[foo | (bar < 0)]
```

##### Subset the rows where foo is not TRUE and bar is not negative ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-the-rows-where-foo-is-not-true-and-bar-is-not-negative-pandas-cross-reference))
```python
transactions[~foo & (bar >= 0)]
```

---

### Column subsetting ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#column-subsetting-pandas-cross-reference))

##### Subset by columns 1 and 3 ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-by-columns-1-and-3-pandas-cross-reference))
```python
transactions.iloc[:, [0, 2]]
```

##### Subset by columns TransactionID and TransactionDate ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-by-columns-transactionid-and-transactiondate-pandas-cross-reference))
```python
transactions[['TransactionID', 'TransactionDate']]
```

##### Subset rows where TransactionID > 5 and subset columns by TransactionID and TransactionDate ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-rows-where-transactionid--5-and-subset-columns-by-transactionid-and-transactiondate-pandas-cross-reference))
```python
transactions.loc[transactions.TransactionID > 5, ['TransactionID', 'TransactionDate']]
```

##### Subset columns by a list of columm names ["TransactionID", "UserID", "Quantity"] ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-columns-by-a-vector-of-columm-names-ctransactionid-userid-quantity-pandas-cross-reference))
```python
print_cols = ["TransactionID", "UserID", "Quantity"]
transactions[print_cols]
```

##### Subset columns excluding a list of column names ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-columns-excluding-a-vector-of-column-names-ctransactionid-userid-quantity-pandas-cross-reference))
```python
transactions.drop(print_cols, axis=1)
```

---

### Inserting and updating values ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#inserting-and-updating-values-pandas-cross-reference))

##### Convert the TransactionDate column to type Date ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#convert-the-transactiondate-column-to-type-date-pandas-cross-reference))
```python
transactions['TransactionDate'] = pd.to_datetime(transactions.TransactionDate)
```

##### Insert a new column, Foo = UserID + ProductID ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#insert-a-new-column-foo--userid--productid-pandas-cross-reference))
```python
transactions['Foo'] = transactions.UserID + transactions.ProductID
```

##### Subset rows where TransactionID is even and set Foo = NA ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#subset-rows-where-transactionid-is-even-and-set-foo--na-pandas-cross-reference))
```python
transactions.loc[transactions.TransactionID % 2 == 0, 'Foo'] = np.nan ([data.table cross reference](#))
```

##### Add 100 to each TransactionID ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#add-100-to-each-transactionid-pandas-cross-reference))
```python
transactions.TransactionID = transactions.TransactionID + 100
transactions.TransactionID = transactions.TransactionID - 100  # revert to original IDs
```

##### Insert a column indicating each row number ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#insert-a-column-indicating-each-row-number-pandas-cross-reference))
```python
transactions['RowIdx'] = np.arange(transactions.shape[0])
```

##### Insert columns indicating the rank of each Quantity, minimum Quantity and maximum Quantity ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#insert-columns-indicating-the-rank-of-each-quantity-minimum-quantity-and-maximum-quantity-pandas-cross-reference))
```python
transactions['QuantityRk'] = transactions.Quantity.rank(method='average')
transactions['QuantityMin'] = transactions.Quantity.min()
transactions['QuantityMax'] = transactions.Quantity.max()
```

##### Remove column Foo ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#remove-column-foo-pandas-cross-reference))
```python
transactions.drop('Foo', axis=1, inplace=True)
```

##### Remove multiple columns RowIdx, QuantityRk, and RowIdx ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#remove-multiple-columns-rowidx-quantityrk-and-rowidx-pandas-cross-reference))
```python
transactions.drop(['QuantityRk', 'QuantityMin', 'QuantityMax'], axis=1, inplace=True)
```

---

### Joining DataFrames ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#joining-datatables-pandas-cross-reference))

#### Setup ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#setup-pandas-cross-reference))
```python
# Load datasets from CSV
users = pd.read_csv('https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/users.csv')
sessions = pd.read_csv('https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/sessions.csv')
products = pd.read_csv('https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/products.csv')
transactions = pd.read_csv('https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/transactions.csv')

# Convert date columns to Date type
users['Registered'] = pd.to_datetime(users.Registered)
users['Cancelled'] = pd.to_datetime(users.Cancelled)
transactions['TransactionDate'] = pd.to_datetime(transactions.TransactionDate)
```

#### Basic Joins ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#basic-joins-pandas-cross-reference))

##### Join users to transactions, keeping all rows from transactions and only matching rows from users (left join) ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#join-users-to-transactions-keeping-all-rows-from-transactions-and-only-matching-rows-from-users-left-join-pandas-cross-reference))
```python
transactions.merge(users, how='left', on='UserID')
```

##### Which transactions aren't tied to a user in users? (anti join) ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#which-transactions-arent-tied-to-a-user-in-users-anti-join-pandas-cross-reference))
```python
# TODO
```

##### Join users to transactions, keeping only rows from transactions and users that match via UserID (inner join) ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#join-users-to-transactions-keeping-only-rows-from-transactions-and-users-that-match-via-userid-inner-join-pandas-cross-reference))
```python
transactions.merge(users, how='inner', on='UserID')
```

##### Join users to transactions, displaying all matching rows AND all non-matching rows (full outer join) ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#join-users-to-transactions-displaying-all-matching-rows-and-all-non-matching-rows-full-outer-join-pandas-cross-reference))
```python
transactions.merge(users, how='outer', on='UserID')
```

##### Determine which sessions occured on the same day each user registered ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#determine-which-sessions-occured-on-the-same-day-each-user-registered-pandas-cross-reference))
```python
# TODO
```

##### Build a dataset with every possible (UserID, ProductID) pair (cross join) ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#build-a-dataset-with-every-possible-userid-productid-pair-cross-join-pandas-cross-reference))
```python
# TODO
```

##### Determine how much quantity of each product was purchased by each user ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#determine-how-much-quantity-of-each-product-was-purchased-by-each-user-pandas-cross-reference))
```python
# TODO
```

##### For each user, get each possible pair of pair transactions (TransactionID1, TransactionID2) ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#for-each-user-get-each-possible-pair-of-pair-transactions-transactionid1-transactionid2-pandas-cross-reference))
```python
# TODO
```

##### Join each user to his/her first occuring transaction in the transactions table ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#join-each-user-to-hisher-first-occuring-transaction-in-the-transactions-table-pandas-cross-reference))
```python
# TODO
```

#### Rolling Joins ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#rolling-joins-pandas-cross-reference))

##### Determine the ID of the last session which occured prior to (and including) the date of each transaction per user ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#determine-the-id-of-the-last-session-which-occured-prior-to-and-including-the-date-of-each-transaction-per-user-pandas-cross-reference))
```python
# TODO
```

##### Determine the ID of the first session which occured after (and including) the date of each transaction per user ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#determine-the-id-of-the-first-session-which-occured-after-and-including-the-date-of-each-transaction-per-user-pandas-cross-reference))
```python
# TODO
```

#### Non-equi joins ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#non-equi-joins-pandas-cross-reference))

##### Determine the first transaction that occured for each user prior to (and including) his/her Cancelled date ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#determine-the-first-transaction-that-occured-for-each-user-prior-to-and-including-hisher-cancelled-date-pandas-cross-reference))
```python
# TODO
```

##### Get all transactions where TransactionDate is after the user's Cancellation Date ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#get-all-transactions-where-transactiondate-is-after-the-users-cancellation-date-pandas-cross-reference))
```python
# TODO
```

#### Join + Update ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#join--update-pandas-cross-reference))

##### Insert the price of each product in the transactions dataset (join + update) ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#insert-the-price-of-each-product-in-the-transactions-dataset-join--update-pandas-cross-reference))
```python
# TODO
```

##### Insert the number of transactions each user made into the users dataset ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#insert-the-number-of-transactions-each-user-made-into-the-users-dataset-pandas-cross-reference))
```python
# TODO
```

#### Setting indexes ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#setting-a-key-and-secondary-indexing-pandas-cross-reference))

##### Set the index of Transactions as UserID ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#set-the-key-of-transactions-as-userid-pandas-cross-reference))
```python
# TODO
```

##### View the index of transactions ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#view-the-key-of-transactions-pandas-cross-reference))
```python
# TODO
```

##### Set the index of users as UserID and join to transactions, matching rows only (inner join) ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#set-the-key-of-users-as-userid-and-join-to-transactions-matching-rows-only-inner-join-pandas-cross-reference))
```python
# TODO
```

##### Set ProductID as the index of transactions and products without re-ordering the rows, then join matching rows only ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#set-productid-as-the-key-of-transactions-and-products-without-re-ordering-the-rows-then-join-matching-rows-only-pandas-cross-reference))
```python
# TODO
```

##### Set each ID column as a secondary join index ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#set-each-id-column-as-a-secondary-join-index-pandas-cross-reference))
```python
# TODO
```

##### View indices ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#view-indices-pandas-cross-reference))
```python
# TODO
```

##### Inner join between users, transactions, and products ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#inner-join-between-users-transactions-and-products-pandas-cross-reference))
```python
# TODO
```

---

### Reshaping a DataFrame ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#reshaping-a-datatable-pandas-cross-reference))

#### Setup ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#setup-pandas-cross-reference-1))
```python
# Read datasets from CSV
users = pd.read_csv('https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/users.csv')
transactions = pd.read_csv('https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/transactions.csv')

# Convert date columns to Date type
users['Registered'] = pd.to_datetime(users.Registered)
users['Cancelled'] = pd.to_datetime(users.Cancelled)
transactions['TransactionDate'] = pd.to_datetime(transactions.TransactionDate)

# Add column TransactionWeekday as Categorical type with categories Sunday through Saturday
transactions['TransactionWeekday'] = pd.Categorical(transactions.TransactionDate.dt.weekday_name, categories=['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'])
```

#### Convert data from tall format to wide format ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#convert-data-from-tall-format-to-wide-format-pandas-cross-reference))

##### One-hot encode Weekday (i.e. convert data from tall to wide, where each possible weekday is a column) ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#one-hot-encode-weekday-ie-convert-data-from-tall-to-wide-where-each-possible-weekday-is-a-column-pandas-cross-reference))
```python
# TODO
```

#### Convert data from wide format to tall format ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#convert-data-from-wide-format-to-tall-format-pandas-cross-reference))

#####  Build a DataFrame with columns {UserID, ActionType, Date} where ActionType is either "Registered" or "Cancelled" and Date is the corresponding date value ([data.table cross reference](https://github.com/ben519/DataWrangling/blob/master/R/README.md#build-a-datatable-with-columns-userid-actiontype-date-where-actiontype-is-either-registered-or-cancelled-and-date-is-the-corresponding-date-value-pandas-cross-reference))
```python
# TODO
```
