#======================================================================================================
# Load the data.table package


#======================================================================================================
# Build the transactions dataset from scratch
# dataset should have the following 5 columns

# TransactionID: type 'int' with values {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
# TransactionDate: type 'Date' with values {"2011-06-16", "2012-08-26", "2013-12-30", "2011-05-26", "2014-04-24", "2016-05-08", "2010-08-21", "2013-12-23", "2013-06-06", "2015-04-24"}
# ProductID: type 'int' with values {3, 2, 4, 4, 2, 4, 2, 5, 4, 4}
# UserID: type 'int' with values {3, 1, 3, 3, 1, 5, 1, 2, 2, 3}
# Quantity: type 'int' with values {0, 3, 0, 0, 3, 4, 0, 6, 0, 3}

#======================================================================================================
# Meta info

# Print a summary of transactions (i.e. print the structure)
str(transactions)

# How many rows does transactions have?

# How many columns does transactions have?