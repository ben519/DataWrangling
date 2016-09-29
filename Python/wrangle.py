import numpy as np
import pandas as pd

#======================================================================================================
# Build dataset from scratch


#======================================================================================================
# Read and write to CSV

# Write transactions to CSV

# Read transactions from CSV

#======================================================================================================
# Meta info

# Full summary

# How many rows?

# How many columns?

# What are the row names

# What are the column names

# Change the name of column "Quantity" to "Quant"

# Change the name of columns ProductID and UserID to PID and UID respectively

#======================================================================================================
# Row subsetting

# Display rows 1, 3, and 6

# Display rows exlcuding 1, 3, and 6

# Display the first 3 rows

# Display rows excluding the first 3 rows

# Display the last 2 rows

# Display rows excluding the last 2 rows

# Display rows where Quantity > 1

# Display rows where UserID = 2

# Display rows where Quantity > 1 and UserID = 2

# Display rows where Quantity + UserID is > 3

# Display rows where an external vector, foo, is TRUE

# Display rows where an external vector, bar, is positive

# Display rows where foo is TRUE or bar is negative

# Display the rows where foo is not TRUE and bar is not negative


#======================================================================================================
# Column subsetting

# Get columns 1 and 3

# Subset by columns TransactionID and TransactionDate

# Subset rows where TransactionID > 5 and subset columns by TransactionID and TransactionDate

# Print columns defined by a vector of colum-names

# Get columns defined by a vector of colum-names

# Get columns excluding a vector of colum-names


#======================================================================================================
# Extract a vector

# Get the 2nd column

# Get the ProductID vector

# Get the ProductID vector using a variable

#======================================================================================================
# Inserting & Updating Values

# Convert the TransactionDate column to type Date

# Insert a new column, Foo = UserID + ProductID

# Subset rows where TransactionID is even and set Foo = NA

# Add 100 to each TransactionID

# Insert a column indicating each row number

# Insert columns indicating the rank of each Quantity, minimum Quantity and maximum Quantity

# Remove column Foo

# Remove multiple columns RowIdx, QuantityRk, and RowIdx

#======================================================================================================
# Ordering the rows

# Order by TransactionID descending

# Order by UserID descending, TransactionDate descending

#======================================================================================================
# Group By & Aggregation

# Count the number of transactions per user

# Count the number of transactions & average Quantity per user

# Count the transactions per year

# Count the transactions per (user, year) pair

# Count the number of unique users which made a transaction per year (this is called chaining)

# For each user in transactions, get the date of the transaction which had the most quantity

# Insert a column in transactions indicating the number of transactions per user

# Insert columns in transactions indicating the first transaction date and last transaction date per user


#======================================================================================================
# Joins

#--------------------------------------------------
# Basic Joins

# Read datasets from CSV (to clear existing )

# Set the first UserID to NA

# Convert date columns to date type

# Join users to transactions, keeping all rows from transactions and only matching rows from users (left join)

# Which transactions aren't tied to a user in users

# Join users to transactions, keeping only rows from transactions and users that match via UserID (inner join)

# Join users to transactions, displaying all matching rows AND all non-matching rows (full outer join)

# Determine which transactions each user made on the same day he/she registered

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


#--------------------------------------------------
# Join + Update

# Insert the price of each product in the transactions dataset (join + update)

#--------------------------------------------------
# setkey and secondary indexing



#======================================================================================================
# Reshaping

# Convert data from wide to tall

# Convert data from tall to wide


#======================================================================================================
# Miscellaneous

# Pick out the first row per group

# Get rows which contain at least 1 NA value
# Get rows which contain at least 1 NA value within a subset of columns

# Get rows which contain all NA values
# Get rows which contain all NA values within a subset of columns

# Get the max value per row
# Get the max value per row within a subset of columns

# For each (user, transaction), determine which transaction he/she made on the prior day

# Determnine how many transactions each user made. Insert stat as field in transactions
