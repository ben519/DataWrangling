# Data

---

## Default datasets

DataWrangling uses the following four datasets to illustate data wrangling techniques:

### [products](https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/products.csv)
| ProductID|Product | Price|
|---------:|:-------|-----:|
|         1|A       | 14.16|
|         2|B       | 33.04|
|         3|C       | 10.65|
|         4|D       | 10.02|
|         5|E       | 29.66|

### [sessions](https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/sessions.csv)
| SessionID|SessionDate | UserID|
|---------:|:-----------|------:|
|         1|2010-01-05  |      2|
|         2|2010-08-01  |      2|
|         3|2010-11-25  |      2|
|         4|2011-09-21  |      5|
|         5|2011-10-19  |      4|
|         6|2012-10-23  |      4|
|         7|2012-12-21  |      3|
|         8|2013-05-22  |      4|
|         9|2013-07-17  |      4|
|        10|2016-01-11  |      4|

### [transactions](https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/transactions.csv)
| TransactionID|TransactionDate | UserID| ProductID| Quantity|
|-------------:|:---------------|------:|---------:|--------:|
|             1|2010-08-21      |      7|         2|        1|
|             2|2011-05-26      |      3|         4|        1|
|             3|2011-06-16      |      3|         3|        1|
|             4|2012-08-26      |      1|         2|        3|
|             5|2013-06-06      |      2|         4|        1|
|             6|2013-12-23      |      2|         5|        6|
|             7|2013-12-30      |      3|         4|        1|
|             8|2014-04-24      |     NA|         2|        3|
|             9|2015-04-24      |      7|         4|        3|
|            10|2016-05-08      |      3|         4|        4|

### [users](https://raw.githubusercontent.com/ben519/DataWrangling/master/Data/users.csv)
| UserID|User     |Gender |Registered |Cancelled  |
|------:|:--------|:------|:----------|:----------|
|      1|Charles  |male   |2012-12-21 |NA         |
|      2|Pedro    |male   |2010-08-01 |2010-08-08 |
|      3|Caroline |female |2012-10-23 |2016-06-07 |
|      4|Brielle  |female |2013-07-17 |NA         |
|      5|Benjamin |male   |2010-11-25 |NA         |


## Generating Big Datasets

If you'd like to test the performance of data.table/pandas, you'll need to generate bigger versions of these datasets. You can do so with [make_data.R](https://github.com/ben519/DataWrangling/blob/master/Data/make_data.R) script which provides methods for generating *products*, *sessions*, *transactions*, and *users* datasets with as many rows as you'd like.