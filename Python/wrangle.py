# Wrangle Data With pandas

#======================================================================================================
# Install numpy and pandas

pip install numpy
pip install pandas

#======================================================================================================
# Import numpy and pandas

import numpy as np
import pandas as pd

#======================================================================================================
# Build DataFrame from scratch

transactions = pd.DataFrame({
    'TransactionID': np.arange(10)+1,
    'TransactionDate': pd.to_datetime(['2010-08-21', '2011-05-26', '2011-06-16', '2012-08-26', '2013-06-06', 
                              '2013-12-23', '2013-12-30', '2014-04-24', '2015-04-24', '2016-05-08']).date,
    'UserID': [7, 3, 3, 1, 2, 2, 3, np.nan, 7, 3],
    'ProductID': [2, 4, 3, 2, 4, 5, 4, 2, 4, 4],
    'Quantity': [1, 1, 1, 3, 1, 6, 1, 3, 3, 4]
})

#======================================================================================================
# Read data from a CSV file

# Load transactions
transactions = pd.read_csv('https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/transactions.csv')

#======================================================================================================
# Meta info

# Full summary
transactions.info()

# How many rows?
transactions.shape[0]

# How many columns?
transactions.shape[1]

# Get the row names
transactions.index.values

# Get the column names
transactions.columns.values

# Change the name of column "Quantity" to "Quant"
transactions.rename(columns={'Quantity': 'Quant'})  # use argument inplace=TRUE to keep the changes

# Change the name of columns ProductID and UserID to PID and UID respectively
transactions.rename(columns={'ProductID': 'PID', 'UserID': 'UID'})  # use argument inplace=TRUE to keep the changes

#======================================================================================================
# Ordering the rows of a DataFrame

# Order the rows of transactions by TransactionID descending
transactions.sort_values('TransactionID', ascending=False)

# Order the rows of transactions by Quantity ascending, TransactionDate descending
transactions.sort_values(['Quantity', 'TransactionDate'], ascending=[True, False])

#======================================================================================================
# Ordering the columns of a DataFrame

# Set the column order of transactions as ProductID, Quantity, TransactionDate, TransactionID, UserID
transactions[['ProductID', 'Quantity', 'TransactionDate', 'TransactionID', 'UserID']]

# Make UserID the first column of transactions
transactions[pd.unique(['UserID'] + transactions.columns.values.tolist()).tolist()]

#======================================================================================================
# Extracting arrays from a DataFrame

# Get the 2nd column
transactions[[1]].values[:, 0]

# Get the ProductID array
transactions.ProductID.values

# Get the ProductID array using a variable
col = "ProductID"
transactions[[col]].values[:, 0]

#======================================================================================================
# Row subsetting

# Subset rows 1, 3, and 6
transactions.iloc[[0,2,5]]

# Subset rows exlcuding 1, 3, and 6
transactions.drop([0,2,5], axis=0)

# Subset the first 3 rows
transactions[:3]
transactions.head(3)

# Subset rows excluding the first 3 rows
transactions[3:]
transactions.tail(-3)

# Subset the last 2 rows
transactions.tail(2)

# Subset rows excluding the last 2 rows
transactions.tail(-2)

# Subset rows where Quantity > 1
transactions[transactions.Quantity > 1]

# Subset rows where UserID = 2
transactions[transactions.UserID == 2]

# Subset rows where Quantity > 1 and UserID = 2
transactions[(transactions.Quantity > 1) & (transactions.UserID == 2)]

# Subset rows where Quantity + UserID is > 3
transactions[transactions.Quantity + transactions.UserID > 3]

# Subset rows where an external array, foo, is True
foo = np.array([True, False, True, False, True, False, True, False, True, False])
transactions[foo]

# Subset rows where an external array, bar, is positive
bar = np.array([1, -3, 2, 2, 0, -4, -4, 0, 0, 2])
transactions[bar > 0]

# Subset rows where foo is TRUE or bar is negative
transactions[foo | (bar < 0)]

# Subset the rows where foo is not TRUE and bar is not negative
transactions[~foo & (bar >= 0)]

#======================================================================================================
# Column subsetting

# Subset by columns 1 and 3
transactions.iloc[:, [0, 2]]

# Subset by columns TransactionID and TransactionDate
transactions[['TransactionID', 'TransactionDate']]

# Subset rows where TransactionID > 5 and subset columns by TransactionID and TransactionDate
transactions.loc[transactions.TransactionID > 5, ['TransactionID', 'TransactionDate']]

# Subset columns by a variable list of columm names
cols = ["TransactionID", "UserID", "Quantity"]
transactions[cols]

# Subset columns excluding a variable list of column names
cols = ["TransactionID", "UserID", "Quantity"]
transactions.drop(cols, axis=1)

#======================================================================================================
# Inserting and updating values

# Convert the TransactionDate column to type Date
transactions['TransactionDate'] = pd.to_datetime(transactions.TransactionDate)

# Insert a new column, Foo = UserID + ProductID
transactions['Foo'] = transactions.UserID + transactions.ProductID

# Subset rows where TransactionID is even and set Foo = NA
transactions.loc[transactions.TransactionID % 2 == 0, 'Foo'] = np.nan

# Add 100 to each TransactionID
transactions.TransactionID = transactions.TransactionID + 100
transactions.TransactionID = transactions.TransactionID - 100  # revert to original IDs

# Insert a column indicating each row number
transactions['RowIdx'] = np.arange(transactions.shape[0])

# Insert columns indicating the rank of each Quantity, minimum Quantity and maximum Quantity
transactions['QuantityRk'] = transactions.Quantity.rank(method='average')
transactions['QuantityMin'] = transactions.Quantity.min()
transactions['QuantityMax'] = transactions.Quantity.max()

# Remove column Foo
transactions.drop('Foo', axis=1, inplace=True)

# Remove multiple columns RowIdx, QuantityRk, and RowIdx
transactions.drop(['QuantityRk', 'QuantityMin', 'QuantityMax'], axis=1, inplace=True)

#======================================================================================================
# Grouping the rows of a DataFrame

#--------------------------------------------------
# Group By + Aggregate

# Group the transations per user, measuring the number of transactions per user
transactions.groupby('UserID').TransactionDate.count().reset_index()

# Group the transactions per user, measuring the transactions and average quantity per user
(transactions.groupby('UserID')
             .agg({'Quantity': 'mean', 'TransactionDate': 'count'})
             .rename(columns = {'Quantity': 'QuantityAvg','TransactionDate': 'Transactions'})
             .reset_index())

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
# Joining DataFrames

# Load datasets from CSV
users = pd.read_csv('https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/users.csv')
sessions = pd.read_csv('https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/sessions.csv')
products = pd.read_csv('https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/products.csv')
transactions = pd.read_csv('https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/transactions.csv')

# Convert date columns to Date type
users['Registered'] = pd.to_datetime(users.Registered)
users['Cancelled'] = pd.to_datetime(users.Cancelled)
transactions['TransactionDate'] = pd.to_datetime(transactions.TransactionDate)

#--------------------------------------------------
# Basic Joins

# Join users to transactions, keeping all rows from transactions and only matching rows from users (left join)
transactions.merge(users, how='left', on='UserID')

# Which transactions aren't tied to a user in users? (anti join)

# Join users to transactions, keeping only rows from transactions and users that match via UserID (inner join)
transactions.merge(users, how='inner', on='UserID')

# Join users to transactions, displaying all matching rows AND all non-matching rows (full outer join)
transactions.merge(users, how='outer', on='UserID')

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
users = pd.read_csv('https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/users.csv')
transactions = pd.read_csv('https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/transactions.csv')

# Convert date columns to Date type
users['Registered'] = pd.to_datetime(users.Registered)
users['Cancelled'] = pd.to_datetime(users.Cancelled)
transactions['TransactionDate'] = pd.to_datetime(transactions.TransactionDate)

# Add column TransactionWeekday as Categorical type with categories Sunday through Saturday
transactions['TransactionWeekday'] = pd.Categorical(transactions.TransactionDate.dt.weekday_name, categories=['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'])

#--------------------------------------------------
# Convert data from tall format to wide format

# One-hot encode Weekday (i.e. convert data from tall to wide, where each possible weekday is a column)

#--------------------------------------------------
# Convert data from wide format to tall format

# Build a data.table with columns {UserID, ActionType, Date} where ActionType is either "Registered" or "Cancelled" and Date is the corresponding date value

#======================================================================================================
# To Do

# Get rows which contain at least 1 NA value
# Get rows which contain at least 1 NA value within a subset of columns

# Get rows which contain all NA values
# Get rows which contain all NA values within a subset of columns

# Get the max value per row
# Get the max value per row within a subset of columns
