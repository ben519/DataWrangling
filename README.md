# DataWrangling

> Data science is 90% cleaning the data and 10% complaining about cleaning the data. 

In the realm of data wrangling, [data.table](https://github.com/Rdatatable/data.table) from R and [pandas](https://github.com/pydata/pandas) from Python dominate. This repo is meant to be a comprehensive, easy to use reference guide on how to do common operations with data.table *and* pandas, including a cross-reference between them as well as speed comparisons.

## Files & Data
This repo consists of three primary directories: 

- [Data](https://github.com/ben519/DataWrangling/tree/master/Data)
- [Python](https://github.com/ben519/DataWrangling/tree/master/Python)
- [R](https://github.com/ben519/DataWrangling/tree/master/R)

The Python and R directories each contain three similarly structured files: 

- [wrangle.py](https://github.com/ben519/DataWrangling/blob/master/Python/wrangle.py) / [wrangle.R](https://github.com/ben519/DataWrangling/blob/master/R/wrangle.R) - has objectives *and* answers
- [wrangle_blank.py](https://github.com/ben519/DataWrangling/blob/master/Python/wrangle_blank.py) / [wrangle_blank.R](https://github.com/ben519/DataWrangling/blob/master/R/wrangle_blank.R)  - has objectives *only*
- [README.md (R)](https://github.com/ben519/DataWrangling/blob/master/R/README.md) / [README.md (Python)](https://github.com/ben519/DataWrangling/blob/master/Python/README.md) - has objectives, answers, and pandas-data.table cross reference

The wrangle files make use of four datasets in the Data directory: 

- [products.csv](https://github.com/ben519/DataWrangling/blob/master/Data/products.csv)

| ProductID|Product | Price|
|---------:|:-------|-----:|
|         1|A       | 53.01|
|         2|B       | 11.76|
|         3|C       | 57.45|
|         4|D       | 53.61|
|         5|E       | 21.72|

- [sessions.csv](https://github.com/ben519/DataWrangling/blob/master/Data/sessions.csv)

| SessionID| UserID|SessionDate |
|---------:|------:|:-----------|
|         1|      5|2010-05-28  |
|         2|      2|2011-05-05  |
|         3|      2|2011-02-24  |
|         4|      3|2014-06-19  |
|         5|      5|2012-07-01  |
|         6|      2|2015-01-02  |
|         7|      5|2013-03-27  |
|         8|      5|2014-08-31  |
|         9|      4|2016-06-11  |
|        10|      4|2012-06-21  |

- [transactions.csv](https://github.com/ben519/DataWrangling/blob/master/Data/transactions.csv)

| TransactionID|TransactionDate | ProductID| UserID| Quantity|
|-------------:|:---------------|---------:|------:|--------:|
|             1|2011-06-16      |         3|      3|        0|
|             2|2012-08-26      |         2|      1|        3|
|             3|2013-12-30      |         4|      3|        0|
|             4|2011-05-26      |         4|      3|        0|
|             5|2014-04-24      |         2|      1|        3|
|             6|2016-05-08      |         4|      5|        4|
|             7|2010-08-21      |         2|      1|        0|
|             8|2013-12-23      |         5|      2|        6|
|             9|2013-06-06      |         4|      2|        0|
|            10|2015-04-24      |         4|      3|        3|

- [users.csv](https://github.com/ben519/DataWrangling/blob/master/Data/users.csv)

| UserID|Gender |User     |Registered |Cancelled  |
|------:|:------|:--------|:----------|:----------|
|      1|female |Sumayo   |2014-03-27 |NA         |
|      2|male   |Randy    |2013-09-09 |2014-05-27 |
|      3|male   |Nicklaus |2010-09-28 |2014-05-11 |
|      4|female |Malia    |2013-11-15 |NA         |
|      5|male   |Hansen   |2012-04-30 |NA         |

These datasets are small for illustrative purposes. If you'd like to test speed comparisons between pandas and data.table, you can use the [make_data.R](https://github.com/ben519/DataWrangling/blob/master/Data/make_data.R) file to generate large versions of these datasets.

## Call for contribution
I'd like to encourage contribution for this project - it's well suited for it. Also note that I'm much more comfortable using data.table than pandas, so it's likely I've done some suboptimal wrangling in pandas.

## Contact
If you'd like to contact me regarding bugs, questions, or general consulting, feel free to drop me a line - bgorman519@gmail.com