library(data.table)
library(babynames)

possible_names <- data.table(babynames)[year==2014, list(name, sex, n)][order(-n)]
boy_names <- possible_names[sex=="M"]
girl_names <- possible_names[sex=="F"]

users <- data.table(
  UserID=c(1L, 2L, 3L, 4L, 5L),
  User=c("Bob", "Sue", "Jane", "John", "Clark"), 
  Gender=c("male", "female", "female", "male", "male"),
  Registered=as.Date(c("2014-3-1", "2013-12-20", "2013-12-11", "2015-4-17", "2016-5-1")),
  Cancelled=as.Date(c("2014-3-15", NA, NA, NA, "2016-5-1"))
)

products <- data.table(
  ProductID=c(1L, 2L, 3L, 4L),
  Product=c("football", "baseball", "football helmet", "frisby"),
  Price=c(30, 5, 45, 12),
  Description=c("NCAA regulation football", "MLB replica baseball", "NCAA regulation football helmet", "Ultimate Frisby (yellow)")
)

transactions <- data.table(
  TransactionID=c(104L, 66L, 37L, 181L, 99L, 72L),
  TransactionDate=as.Date(c("2014-5-3", "2016-7-11", "2013-8-9", "2013-11-15", "2015-12-6", "2016-2-2")),
  UserID=c(5L, 3L, 2L, 2L, 1L, 1L),
  ProductID=c(4L, 2L, 5L, 5L, 3L, 1L),
  Quantity=c(2L, 2L, 3L, 1L, 1L, 5L)
)

getUsers <- function(n=10, seed=0){
  # Build a data.table of users
  
  set.seed(seed)
  users <- data.table(UserID = seq(1, n))
  users[, Gender := sample(c("male", "female"), size=.N, replace=TRUE)]
  users[Gender=="male", User := sample(boy_names$name, size=.N, replace=TRUE, prob=boy_names$n)]
  users[Gender=="female", User := sample(girl_names$name, size=.N, replace=TRUE, prob=girl_names$n)]
  users[, Registered := as.Date("2010-1-1") + sample(2372, size=.N, replace=TRUE)]
  users[, Cancelled := Registered + sample(5000, size=.N, replace=TRUE)]
  users[Cancelled > as.Date("2016-6-30"), Cancelled := NA]
  
  return(users[])
}

getProducts <- function(n=10, seed=0){
  # Build a data.table of products
  
  if(n <= 26){
    product_names <- CJ(LETTERS)[, Product := paste0(V1)]
  } else if(n <= 26^2){
    product_names <- CJ(LETTERS, LETTERS)[, Product := paste0(V1, V2)]
  } else if(n <= 26^3){
    product_names <- CJ(LETTERS, LETTERS, LETTERS)[, Product := paste0(V1, V2, V3)]
  } else if(n <= 26^4){
    product_names <- CJ(LETTERS, LETTERS, LETTERS, LETTERS)[, Product := paste0(V1, V2, V3, V4)]
  } else if(n <= 26^5){
    product_names <- CJ(LETTERS, LETTERS, LETTERS, LETTERS, LETTERS)[, Product := paste0(V1, V2, V3, V4, V5)]
  } else if(n <= 26^6){
    product_names <- CJ(LETTERS, LETTERS, LETTERS, LETTERS, LETTERS, LETTERS)[, Product := paste0(V1, V2, V3, V4, V5, V6)]
  } else{
    stop("n too large")
  }
  
  set.seed(seed)
  products <- data.table(ProductID = seq(1, n))
  products[, Product := product_names$Product[1:n]]
  products[, Price := round(exp(rlnorm(n=n, meanlog=1, sdlog=.3)), 2)]
  
  return(products[])
}

getTransactions <- function(n=100, products, users, seed=0){
  # Build a data.table of users
  
  set.seed(seed)
  transactions <- data.table(TransactionID = seq(1, n))
  transactions[, ProductID := sample(products$ProductID, size=.N, replace=TRUE)]
  transactions[, UserID := sample(users$UserID, size=.N, replace=TRUE)]
  transactions[, TransactionDate := as.Date("2010-1-1") + sample(2372, size=.N, replace=TRUE)]
  transactions[, Quantity := rnbinom(n=.N, size=5, prob=.8)]
  
  return(transactions[])
}

getSessions <- function(n=100, users, seed=0){
  # Build a data.table of users
  
  set.seed(seed)
  sessions <- data.table(SessionID = seq(1, n))
  sessions[, UserID := sample(users$UserID, size=.N, replace=TRUE)]
  sessions[, SessionDate := as.Date("2010-1-1") + sample(2372, size=.N, replace=TRUE)]
  
  return(sessions[])
}

users <- getUsers(5, seed=10)
products <- getProducts(5, seed=0)
transactions <- getTransactions(10, products, users, seed=8)
sessions <- getSessions(10, users, 0)
users[!transactions, on="UserID"]


# # Define a dataset of user sessions
# sessions <- data.table(
#   SessionID = 1:13,
#   UserID = c(1L, 1L, 1L, 2L, 2L, 3L, 3L, 3L, 3L, 4L, 4L, 5L, 5L),
#   SessionDate = c(as.Date(c("2010-03-27", "2014-04-24", "2016-12-12", 
#                             "2013-09-09", "2014-05-27", 
#                             "2010-09-28", "2010-9-29", "2014-05-11", "2013-09-09",
#                             "2010-05-05", "2013-11-15", 
#                             "2012-04-30", "2016-04-30")))
# )

write.csv(users, "Data/users.csv", row.names=FALSE)
write.csv(products, "Data/products.csv", row.names=FALSE)
write.csv(transactions, "Data/transactions.csv", row.names=FALSE)
write.csv(sessions, "Data/sessions.csv", row.names=FALSE)
