#======================================================================================================
# Install data.table package

#======================================================================================================
# Load data.table package

#======================================================================================================
# Build data.table from scratch

# TransactionID TransactionDate UserID ProductID Quantity
# 1:             1      2010-08-21      7         2        1
# 2:             2      2011-05-26      3         4        1
# 3:             3      2011-06-16      3         3        1
# 4:             4      2012-08-26      1         2        3
# 5:             5      2013-06-06      2         4        1
# 6:             6      2013-12-23      2         5        6
# 7:             7      2013-12-30      3         4        1
# 8:             8      2014-04-24     NA         2        3
# 9:             9      2015-04-24      7         4        3
# 10:            10      2016-05-08      3         4        4

#======================================================================================================
# Read data from a CSV file

# Load transactions from https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/transactions.csv

#======================================================================================================
# Meta info

# Full summary

# How many rows?

# How many columns?

# Get the row names

# Get the column names

# Change the name of column "Quantity" to "Quant"

# Change the name of columns ProductID and UserID to PID and UID respectively

#======================================================================================================
# Ordering the rows of a data.table

# Order the rows of transactions by TransactionID descending

# Order the rows of transactions by Quantity ascending, TransactionDate descending

#======================================================================================================
# Ordering the columns of a data.table

# Set the column order of transactions as ProductID, Quantity, TransactionDate, TransactionID, UserID

# Make UserID the first column of transactions

#======================================================================================================
# Extracting vectors from a data.table

# Get the 2nd column

# Get the ProductID vector

# Get the ProductID vector using a variable

#======================================================================================================
# Row subsetting

# Subset rows 1, 3, and 6

# Subset rows exlcuding 1, 3, and 6

# Subset the first 3 rows

# Subset rows excluding the first 3 rows

# Subset the last 2 rows

# Subset rows excluding the last 2 rows

# Subset rows where Quantity > 1

# Subset rows where UserID = 2

# Subset rows where Quantity > 1 and UserID = 2

# Subset rows where Quantity + UserID is > 3

# Subset rows where an external vector, foo, is TRUE

# Subset rows where an external vector, bar, is positive

# Subset rows where foo is TRUE or bar is negative

# Subset the rows where foo is not TRUE and bar is not negative

#======================================================================================================
# Column subsetting

# Subset by columns 1 and 3

# Subset by columns TransactionID and TransactionDate

# Subset rows where TransactionID > 5 and subset columns by TransactionID and TransactionDate

# Subset columns by a vector of columm names c("TransactionID", "UserID", "Quantity")

# Subset columns excluding a vector of column names c("TransactionID", "UserID", "Quantity")

#======================================================================================================
# Inserting and updating values

# Convert the TransactionDate column to type Date

# Insert a new column, Foo = UserID + ProductID

# Subset rows where TransactionID is even and set Foo = NA

# Add 100 to each TransactionID

# Insert a column indicating each row number

# Insert columns indicating the rank of each Quantity, minimum Quantity and maximum Quantity

# Remove column Foo

# Remove multiple columns RowIdx, QuantityRk, and RowIdx

#======================================================================================================
# Grouping the rows of a data.table

#--------------------------------------------------
# Group By + Aggregate

# Group the transations per user, measuring the number of transactions per user

# Group the transactions per user, measuring the transactions and average quantity per user

# Group the transactions per year of the transaction date, measuring the number of transactions per year

# Group the transactions per (user, transaction-year) pair, measuring the number of transactions per group

# Group the transactions per user, measuring the max quantity each user made for a single transaction and the date of that transaction

# Group the transactions per (user, transaction-year), and then group by transaction-year to get the number of users who made a transaction each year

#--------------------------------------------------
# Group By + Update

# Insert a column in transactions indicating the number of transactions per user

# Insert columns in transactions indicating the first transaction date and last transaction date per user

# For each transaction, get the date of the previous transaction made by the same user

#======================================================================================================
# Joining data.tables

# Load datasets from CSV
# https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/users.csv
# https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/sessions.csv
# https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/products.csv")
# https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/transactions.csv

# Convert all date columns to Date type

#--------------------------------------------------
# Basic Joins

# Join users to transactions, keeping all rows from transactions and only matching rows from users (left join)

# Which transactions aren't tied to a user in users

# Join users to transactions, keeping only rows from transactions and users that match via UserID (inner join)

# Join users to transactions, displaying all matching rows AND all non-matching rows (full outer join)

# Determine which sessions occured on the same day each user registered

# Build a dataset with every possible (UserID, ProductID) pair (cross join)

# Determine how much quantity of each product was purchased by each user

# For each user, get each possible pair of pair transactions (TransactionID1, TransactionID2)

# Join each user to his/her first occuring transaction in the transactions table

#--------------------------------------------------
# Rolling Joins

# Determine the ID of the last session which occured prior to (and including) the date of each transaction per user

# Determine the ID of the first session which occured after (and including) the date of each transaction per user

#--------------------------------------------------
# Non-equi joins

# Determine the first transaction that occured for each user prior to (and including) his/her Cancelled date

# Get all transactions where TransactionDate is after the user's Cancellation Date

#--------------------------------------------------
# Join + Update

# Insert the price of each product in the transactions dataset (join + update)

# Insert the number of transactions each user made into the users dataset

#--------------------------------------------------
# Setting a key and secondary indexing

# Set the key of Transactions as UserID

# View the key of transactions

# Set the key of users as UserID and join to transactions, matching rows only (inner join)

# Set ProductID as the key of transactions and products without re-ordering the rows, then join matching rows only

# Set each ID column as a secondary join index

# View indices

# Inner join between users, transactions, and products

#======================================================================================================
# Reshaping a data.table

# Read datasets from CSV
# https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/users.csv
# https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/transactions.csv

# Convert all date columns to Date type

# Add column TransactionWeekday as a factor with levels Saturday through Friday

#--------------------------------------------------
# Convert data from tall format to wide format

# One-hot encode Weekday (i.e. convert data from tall to wide, where each possible weekday is a column)

#--------------------------------------------------
# Convert data from wide format to tall format

# Build a data.table with columns {UserID, ActionType, Date} where ActionType is either "Registered" or "Cancelled" and Date is the corresponding date value
