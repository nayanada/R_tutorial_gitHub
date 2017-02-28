#-----------------------------------------------------------------------------------
#Title : CSV File Import
#Csv File Import할때 data.table을 사용하자.
#기존 read.csv()함수를 사용할 때 보다 속도가 빠르다.
#다른거 할 시간도 부족한데 데이터 호출 하는 시간을 많이 빼먹으면 나중에 고생이다.
#테스트 컴퓨터 환경은 windows 7 64bit memory 8GB
#테스트 Result : fread > read.table >  read.csv.ffdf > read.csv.sql > read.csv
#package : sqldf, data.table, ff
#참고 : 32bit 컴퓨터에서는 ff package가 사용이 안될수 있음
#-----------------------------------------------------------------------------------


# 먼저 테스트할 Sample 데이터 생성하자.
n=1e6
DT = data.table( a=sample(1:1000,n,replace=TRUE),
                 b=sample(1:1000,n,replace=TRUE),
                 c=rnorm(n),
                 d=sample(c("foo","bar","baz","qux","quux"),n,replace=TRUE),
                 e=rnorm(n),
                 f=sample(1:1000,n,replace=TRUE) )
DT[2,b:=NA_integer_]
DT[4,c:=NA_real_]
DT[3,d:=NA_character_]
DT[5,d:=""]
DT[2,e:=+Inf]
DT[3,e:=-Inf]

# 생성되어진 File을 CSV File로 저장
write.table(DT,"c:\\Rproject\\test.csv",sep=",",row.names=FALSE,quote=FALSE)
cat("File size (MB):", round(file.info("c:\\Rproject\\test.csv")$size/1024^2),"\n")
# 50 MB (1e6 rows x 6 columns)

#Test1 : read.csv()로 csv file import
system.time(DF1 <-read.csv("c:\\Rproject\\test.csv",stringsAsFactors=FALSE))
#사용자  시스템 elapsed 
#12.87    0.05   12.92 
# 13 sec (first time in fresh R session)

#한번 호출한 이후에 다시 같은 이름으로 호출하면 약간의 속도 감소 효과가 있다.
#하지만 한번 호출한 데이터를 다시 호출할 경우가 있을까?
system.time(DF1 <- read.csv("c:\\Rproject\\test.csv",stringsAsFactors=FALSE))
#사용자  시스템 elapsed 
#11.88    0.06   11.96
# 12 sec (immediate repeat is faster, varies)

#Test2 : read.table()로 csv file import
system.time(DF2 <- read.table("c:\\Rproject\\test.csv",header=TRUE,sep=",",quote="",
                              stringsAsFactors=FALSE,comment.char="",nrows=n,
                              colClasses=c("integer","integer","numeric",
                                           "character","numeric","integer")))
#사용자  시스템 elapsed 
#6.07    0.06    6.13
# 6 sec (consistently). All known tricks and known nrows, see references.

#Test3 : fread()로 csv file import
#data.frame형식으로 데이터를 호출할 때 read.csv, read.table을 사용시 6 ~ 13초 걸렸다.
#그럼 이번에는 data.table package에서 제공하는 fread()함수를 사용하여 데이터를 호출해보자.
system.time(DT1 <- fread("c:\\Rproject\\test.csv"))
#사용자  시스템 elapsed 
#2.14    0.00    2.14
#  2 sec (faster and friendlier)
#기존의 사용한 방법보다 최소 3배에서 최대 6배이상의 속도차이를 보여주고 있다.

#Test4: read.csv.sql()로 csv file import
require(sqldf)
system.time(SQLDF <- read.csv.sql("c:\\Rproject\\test.csv",dbname=NULL))
#사용자  시스템 elapsed 
#7.80    0.11    7.93 
# 8 sec (friendly too, good defaults)
#기존방법보다는 같거나 좀더 빠른 속도를 보여주고 있지만 fread보다는 3배이상의 속도 차이를 보이고 있다.

#Test5: read.csv.ffdf()로 csv file import
install.packages('ff')
require(ff)
system.time(FFDF <- read.csv.ffdf(file="c:\\Rproject\\test.csv",nrows=n))
#사용자  시스템 elapsed 
#6.71    0.11    6.82
# 6.82 sec (friendly too, good defaults)
#ff package를 사용하여 데이터를 호출하는 속도는 기존방법보다 같거나 좀더 빠른 속도를 보여줬지만, 우리가 자주 사용하는 데이터 형식이 아니다.
head(FFDF)

#Test6: 500MB csv file Import Test
# 그럼 이번에는 좀더 큰 Size 데이터를 가지고 테스트를 해보자
#좀전에 데이터보다 10배 큰 데이터이다.
l = vector("list",10)
for (i in 1:10) l[[i]] = DT
DTbig = rbindlist(l)
tables()
write.table(DTbig,"c:\\Rproject\\testbig.csv",sep=",",row.names=FALSE,quote=FALSE)
# 500MB (10 million rows x 6 columns)
gc(reset = T)

#그럼 평상시에 자주사용하던 방법으로 csv File을 호출해 보자.
system.time(DF3 <- read.table("c:\\Rproject\\testbig.csv",header=TRUE,sep=",",         
                             quote="",stringsAsFactors=FALSE,comment.char="",nrows=1e7,                     
                             colClasses=c("integer","integer","numeric",
                                          "character","numeric","integer")))
#사용자  시스템 elapsed 
#60.31    0.69   61.00 
# 61초 결렸다. 요즘에는 1GB이상의 데이터도 호출할 일이 많은데.. 
gc(reset = T)

#그럼 이번에는 fread로 csv File을 호출해보자.
system.time(DT3 <- fread("c:\\Rproject\\testbig.csv"))
#사용자  시스템 elapsed 
#21.53    0.11   21.67
# 21초 걸렸다. 기존방법중 가장 빠른 방법보다. 3배이상의 속도차이를 보이고 있다.

#그럼 우리가 csv file을 호출할 때 가장 많이 쓰는 read.csv()함수로 테스트를 해보자. 얼마나 걸릴까?
system.time(DF4 <- read.csv("c:\\Rproject\\testbig.csv",stringsAsFactors=FALSE))
#사용자  시스템 elapsed 
#78.03    1.11   79.45
#80초 정도 소요되어지고 있다.

#그럼 두데이터 형식이 같을까? 한번 확인해 보자.
all(mapply(all.equal, DF3, DT3))
#결과는 TRUE로 나왔다.


