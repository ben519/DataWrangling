# Wrangling with data.table

## Intro
Note that the examples here use [data.table](https://github.com/Rdatatable/data.table) version 1.9.8 which you can install from CRAN via `install.packages(data.table)`.  Many of the methods are NOT compatible with prior versoins of data.table (e.g. non-equi joins and secondary indexing).

---

### Load the data.table package
```r
library(data.table)
```

---

### Build a dataset from scratch
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

Full summary
```r
str(transactions)
```

How many rows?
```r
nrow(transactions)
```

How many columns?
```r
ncol(transactions)
```

Get the row names
```r
rownames(transactions)
```

Get the column names
```r
colnames(transactions)
```
