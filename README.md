#### Anxious to start?
[*Wrangle data with pandas! (Python)*](https://github.com/ben519/DataWrangling/blob/master/Python/README.md)

[*Wrangle data with data.table! (R)*](https://github.com/ben519/DataWrangling/blob/master/R/README.md)

# DataWrangling

> Data science is 90% cleaning the data and 10% complaining about cleaning the data. 

In the realm of data wrangling, [data.table](https://github.com/Rdatatable/data.table) from R and [pandas](https://github.com/pydata/pandas) from Python dominate. This repo is meant to be a comprehensive, easy to use reference guide on how to do common operations with data.table *and* pandas, including a cross-reference between them as well as speed comparisons.

## Files & Data
This repo consists of three primary directories: 

- [Data](https://github.com/ben519/DataWrangling/tree/master/Data)
- [Python](https://github.com/ben519/DataWrangling/tree/master/Python)
- [R](https://github.com/ben519/DataWrangling/tree/master/R)

The Python and R directories each contain three similarly structured files: 

- [wrangle.py](https://github.com/ben519/DataWrangling/blob/master/Python/wrangle.py) / [wrangle.R](https://github.com/ben519/DataWrangling/blob/master/R/wrangle.R) - has objectives *and* answers (for learning)
- [wrangle_blank.py](https://github.com/ben519/DataWrangling/blob/master/Python/wrangle_blank.py) / [wrangle_blank.R](https://github.com/ben519/DataWrangling/blob/master/R/wrangle_blank.R)  - has objectives *only* (for testing your skills)
- [README.md (Python)](https://github.com/ben519/DataWrangling/blob/master/Python/README.md) / [README.md (R)](https://github.com/ben519/DataWrangling/blob/master/R/README.md) - has objectives, answers, and pandas-data.table cross references

The wrangle files make use of four datasets in the [Data](https://github.com/ben519/DataWrangling/tree/master/Data) directory: 

- [products.csv](https://github.com/ben519/DataWrangling/blob/master/Data/products.csv)
- [sessions.csv](https://github.com/ben519/DataWrangling/blob/master/Data/sessions.csv)
- [transactions.csv](https://github.com/ben519/DataWrangling/blob/master/Data/transactions.csv)
- [users.csv](https://github.com/ben519/DataWrangling/blob/master/Data/users.csv)

These datasets are small for illustrative purposes. If you'd like to test speed comparisons between pandas and data.table, you can use the [make_data.R](https://github.com/ben519/DataWrangling/blob/master/Data/make_data.R) file to generate large versions of these datasets.

## Call for contributions
I'd like to encourage contributions for this project - it's well suited for it. Also note that I'm much more comfortable using data.table than pandas, so it's likely I've done some suboptimal wrangling in pandas.

## Contact
If you'd like to contact me regarding bugs, questions, or general consulting, feel free to drop me a line - bgorman519@gmail.com
