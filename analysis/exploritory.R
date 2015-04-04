
# Explore the two filtered and cleaned datasets
# They can be downloaded from google drive:
# 


setwd("~/personal/octanner/raw_data")

data = read.csv("fact_recognition-cleaned-37cols_deduped.csv")
emp = read.csv("dim_user_deduped.csv")


#### USERS

# how many companies are there?
companies = table(emp$company)
length( companies )
# 150 companies

# how many employees in each company?
companies_employee_count = table( emp[!duplicated(emp[,c("sysID","company")]),"company"] )
companies_employee_count_top_20 = sort(companies_employee_count, decreasing=T)[1:20]
barplot(companies_employee_count_top_20, main="Top 20 Companies by Count of Employees")

# how many business units in each company?
companies_bu_count = table( emp[!duplicated(emp[,c("busUnit","company")]),"company"] )
barplot(sort(companies_bu_count, decreasing=T)[1:20], main="Top 20 Companies by Count of BU")





#### RECOGNITIONS

# number of recognitions per month
recs_per_day = table(substr(data$recognition_date_key,1,6))
day = paste(names(recs_per_day),"01")
date = as.Date(day, "%Y%m%d")
plot(date,recs_per_day,type="l", main="Global Count of Recognitions Per Month")

# number of recognitions per month by company
cl <- rainbow(20)
for (i in 1:20 ){
  
  ith_company = names(companies_employee_count_top_20)[i]
  # only this company's list of employees
  list_of_employees = emp[ emp$company %in% ith_company, "sysID"]
  list_of_employees = unique( list_of_employees )
  
  # only this company's recognitions
  this_companies_recs = data[ data$RECEIVER_USER_KEY %in% list_of_employees, ]
  
  # plot recs per company on graph
  recs_per_day = table(substr(this_companies_recs$recognition_date_key,1,6))
  day = paste(names(recs_per_day),"01")
  date = as.Date(day, "%Y%m%d")
  
  plot(date,recs_per_day, main="Count of Recognitions Per Month by Company",
       ylim = c(0,max(recs_per_day)),type = "n", ylab="Count Recs per Month", sub=paste("Company number", ith_company))
  lines(date,recs_per_day,col = cl[i])
}








