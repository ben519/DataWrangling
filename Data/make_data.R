library(data.table)
library(babynames)

# Get possible boy and girl names
possible_names <- data.table(babynames)[year==2014, list(name, sex, n)][order(-n)]
boy_names <- possible_names[sex=="M"]
girl_names <- possible_names[sex=="F"]

getUsers <- function(n=10, minDate=as.Date("2010-1-1"), maxDate=as.Date("2016-6-30"), seed=0){
  # Build a data.table of users
  
  set.seed(seed)
  users <- data.table(UserID = seq(1, n))
  users[, Gender := sample(c("male", "female"), size=.N, replace=TRUE)]
  users[Gender=="male", User := sample(boy_names$name, size=.N, replace=TRUE, prob=boy_names$n)]
  users[Gender=="female", User := sample(girl_names$name, size=.N, replace=TRUE, prob=girl_names$n)]
  users[, Registered := minDate + sample(as.integer(maxDate-minDate), size=.N, replace=TRUE)]
  users[, Cancelled := Registered + sample(5000, size=.N, replace=TRUE)]
  users[Cancelled > maxDate, Cancelled := NA]
  
  # Fix the column order
  setcolorder(users, c("UserID", "User", "Gender", "Registered", "Cancelled"))
  
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

getTransactions <- function(n=100, products, users, minDate=as.Date("2010-1-1"), maxDate=as.Date("2016-6-30"), 
                            orphanUsers=0, naUsers=0, seed=0){
  # Build a data.table of users
  # orphanUsers and naUsers should be in the range [0, 1] s.t. orphanUsers + naUsers <= 1
  # If orphanUsers > 0, transactions will set the specified portion UserIDs to some IDs not in the users dataset
  # If naUsers > 0, transactions will set the specified portion UserIDs to NA
  
  set.seed(seed)
  transactions <- data.table(TransactionID = seq(1, n))
  transactions[, ProductID := sample(products$ProductID, size=.N, replace=TRUE)]
  transactions[, UserID := sample(users$UserID, size=.N, replace=TRUE)]
  transactions[, TransactionDate := minDate + sample(as.integer(maxDate-minDate), size=.N, replace=TRUE)]
  transactions[, Quantity := pmax(1L, rnbinom(n=.N, size=5, prob=.8))]
  
  # Helper function (see ?sample)
  resample <- function(x, ...) x[sample.int(length(x), ...)] 
  
  # Insert orphan users
  orphanUsersMap <- transactions[sample(.N, round(orphanUsers * .N)), list(TransactionID)]
  potentialNewUsers <- nrow(users) + sample(nrow(users), ceiling(orphanUsers * nrow(users)))
  orphanUsersMap[, NewUserID := resample(potentialNewUsers, .N, replace=TRUE)]
  transactions[orphanUsersMap, UserID := NewUserID, on="TransactionID"]
  
  # Insert naUsers
  naUsersMap <- transactions[!orphanUsersMap, on="TransactionID"][sample(.N, round(naUsers * nrow(transactions))), list(TransactionID)]
  transactions[naUsersMap, UserID := NA_integer_, on="TransactionID"]
  
  # Reset the TransactionIDs to match the transaction dates
  setorder(transactions, "TransactionDate")
  transactions[, TransactionID := .I]
  
  # Fix the column order
  setcolorder(transactions, c("TransactionID", "TransactionDate", "UserID", "ProductID", "Quantity"))
  
  return(transactions[])
}

getSessions <- function(n=100, users, minDate=as.Date("2010-1-1"), maxDate=as.Date("2016-6-30"), seed=0){
  # Build a data.table of users
  
  set.seed(seed)
  sessions <- data.table(SessionID = seq(1, n))
  sessions[, UserID := sample(users$UserID, size=.N, replace=TRUE)]
  sessions[, SessionDate := minDate + sample(as.integer(maxDate-minDate), size=.N, replace=TRUE)]
  
  # Reset the SessionID to match the session dates
  setorder(sessions, "SessionDate")
  sessions[, SessionID := .I]
  
  # Fix the column order
  setcolorder(sessions, c("SessionID", "SessionDate", "UserID"))
  
  return(sessions[])
}

users <- getUsers(5, seed=14)
products <- getProducts(5, seed=0)
transactions <- getTransactions(10, products, users, orphanUsers=.1, naUsers=.1, seed=0)
sessions <- getSessions(10, users, seed=0)

#--------------------------------------------------
# Check for good instructional data

getGoodData <- function(){
  
  for(i in 1:100){
    print(i)
    
    users <- getUsers(5, seed=i)
    products <- getProducts(5, seed=i)
    transactions <- getTransactions(10, products, users, orphanUsers=.1, naUsers=.1, seed=i)
    sessions <- getSessions(10, users, seed=i)
    
    # Are some users not in transactions?
    test1 <- nrow(users[!transactions, on="UserID"]) > 0
    
    # Is there an instance of a user who has a session on the same day he registered?
    test2 <- nrow(users[sessions, on=c("UserID", "Registered" = "SessionDate"), nomatch=0]) > 1
    
    if(test1 == TRUE & test2 == TRUE){
      users <<- users
      products <<- products
      transactions <<- transactions
      sessions <<- sessions
      print(paste("Good key:", i))
      
      break
    }
  }
}

getGoodData()

#--------------------------------------------------
# Save results to CSV

write.csv(users, "Data/users.csv", row.names=FALSE)
write.csv(products, "Data/products.csv", row.names=FALSE)
write.csv(transactions, "Data/transactions.csv", row.names=FALSE)
write.csv(sessions, "Data/sessions.csv", row.names=FALSE)

