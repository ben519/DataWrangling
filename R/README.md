# Data Wrangling With data.table</h1>

## Intro
Note that the examples here use [data.table](https://github.com/Rdatatable/data.table) version 1.9.8. Many of the methods are NOT compatible with prior versoins of data.table (e.g. non-equi joins and secondary indexing).

---

### Install the data.table package
[pandas cross reference](#)
```r
install.packages("data.table")
```

---

### Load the data.table package
[pandas cross reference](https://github.com/ben519/DataWrangling/tree/master/Python#import-the-pandas-package)
```r
library(data.table)
```

---

### Build a dataset from scratch
[pandas cross reference](https://github.com/ben519/DataWrangling/tree/master/Python#build-a-dataset-from-scratch)
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

### Meta info
[pandas cross reference](#)

##### Full summary
[pandas cross reference](#)
```r
str(transactions)
```

##### How many rows?
[pandas cross reference](#)
```r
nrow(transactions)
```

##### How many columns?
[pandas cross reference](#)
```r
ncol(transactions)
```

##### Get the row names
[pandas cross reference](#)
```r
rownames(transactions)
```

##### Get the column names
[pandas cross reference](#)
```r
colnames(transactions)
```

##### Change the name of column "Quantity" to "Quant"
[pandas cross reference](#)
```r
setnames(transactions, "Quantity", "Quant")
setnames(transactions, "Quant", "Quantity")  # change it back
```

#### Change the name of columns ProductID and UserID to PID and UID respectively
[pandas cross reference](#)
```r
setnames(transactions, c("ProductID", "UserID"), c("PID", "UID"))
setnames(transactions, c("PID", "UID"), c("ProductID", "UserID"))  # change them back
```
