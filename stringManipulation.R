paste("north", "south", sep = " ")
paste("north", "south", sep = " and ")


names(mtcars)
grep("wt", names(mtcars))  # searches for a specified substring pattern in a vector x of strings
mtcars[6]
mtcars[[6]]
mtcars$wt

substring("Equator",3,5) # returns the substring in the given character position range start:stop in the given string x 

strsplit("6-16-2011",split="-") 

i <- 2
sprintf("file%02d", i)  # formatted printing
j <- 3
sprintf("dir%02d/file%02d", i, j)  # formatted printing

for (i in 1:5) { 
  fname <- sprintf("q%d.pdf",i) 
  pdf(fname) 
  hist(rnorm(100,sd=i)) 
  dev.off() 
}

today <- as.Date("2016-02-25")
format(today, "%Y%m%d")

today <- Sys.Date()
fdate <- format(today, "%Y%m%d")

fname <- paste("dir/f", fdate, ".csv", sep = "" )
fname


