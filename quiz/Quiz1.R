# Quiz 1:


# Initialize Text Data
con1 <- file("en_US.twitter.txt", "r")
con2 <- file("en_US.blogs.txt", "r")
con3 <- file("en_US.news.txt", "r")
RawTwitterText <- readLines(con1)
RawBlogsText <- readLines(con2)
RawNewsText <- readLines(con3)

# Question 1
x <- file.info("en_US.blogs.txt")
x$size/1024^2

# Answer:
# 200.4242 Megabytes 

# Question 2
con1 <- file("en_US.twitter.txt", "r")
length(RawTwitterText)
# Answer:
# 2360148 Lines (Over 2 Million)

# Question 3
TwitterLine <- max(nchar(RawTwitterText)) 
BlogsLine <- max(nchar(RawBlogsText)) 
NewsLine <- max(nchar(RawNewsText)) 
LongestLines <- c(TwitterLine, BlogsLine, NewsLine)
which.max(LongestLines)
LongestLines[2]

# Answer:
# 40835 in Blogs

# Question 4
love <- length(grep("love", RawTwitterText))
hate <- length(grep("hate", RawTwitterText))
love/hate

# Answer:
# 4.1

# Question 5
con1 <- file("en_US.twitter.txt", "r")
RawTwitterText <- readLines(con1)
grep("biostats", RawTwitterText)

# Answer:
# They haven't studied for their biostats exam

# Question 6
grep("A computer once beat me at chess, but it was no match for me at kickboxing", RawTwitterText)

# Answer:
# 3 Tweets
# 519059 835824 2283423

close(con1, con2, con3)
