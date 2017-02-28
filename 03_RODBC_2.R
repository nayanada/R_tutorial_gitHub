require(DBI)
require(RODBC)

hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)

test.df <- sqlQuery(hdb, " select * from tab ")

odbcClose(hdb)

#1. Table Create 
Sample.df <- data.frame(COMPANY = "Begas", COMP_GROUP = "GROUP1", NAMES = "ohwonki", AGE = 34, PHONE_NUM = "0104119501")

hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
query.x <- "create table COMP_MST(COMPANY varchar2(20), COMP_GROUP varchar2(20), NAMES varchar2(20), AGE number(10), PHONE_NUM varchar2(20));"
sqlQuery(hdb, query.x)
odbcClose(hdb)

#테이블이 잘 생성되어졌는지 확인해보자
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
test.df <- sqlQuery(hdb, " select * from COMP_MST ")
odbcClose(hdb)


#2. DB 테이블에 데이터 insert
#데이터를 insert 하는 방법에는 두가지가 있다.
#먼저 sqlSave함수를 사용하여 데이터를 Insert하는 방법과 sqlQuery함수를 사용하여 Insert하는 방법이 있다.

#sqlSave함수를 사용하여 Insert
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
sqlSave(hdb,Sample.df, "COMP_MST", append = TRUE, rownames = FALSE)
odbcClose(hdb)

#테이블에 데이터가 잘 들어갔는지 확인해 보자
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
test.df <- sqlQuery(hdb, " select * from COMP_MST ")
odbcClose(hdb)

#sqlQuery함수를 사용하여 Insert
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
query.x <- "insert into COMP_MST(COMPANY, COMP_GROUP, NAMES, AGE, PHONE_NUM) values('Begas', 'Group1', 'jangeunhi', 28, '01099990000')"
sqlQuery(hdb, query.x)
odbcClose(hdb)

#테이블에 데이터가 잘 들어갔는지 확인해 보자
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
test.df <- sqlQuery(hdb, " select * from COMP_MST ")
odbcClose(hdb)


#3. DB 테이블 데이터 삭제
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
sqlClear(hdb, "COMP_MST", errors = TRUE)  
odbcClose(hdb)

#테이블에 데이터가 잘 삭제되었는지 확인해 보자
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
test.df <- sqlQuery(hdb, " select * from COMP_MST ")
odbcClose(hdb)

#4. 테이블 업데이트
#데이터를 update 하는 방법에는 두가지가 있다.
#먼저 sqlUpdate함수를 사용하여 데이터를 update하는 방법과 sqlQuery함수를 사용하여 update하는 방법이 있다.

#sqlQuery함수를 사용하여 update
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
query.x <- "update COMP_MST set COMP_GROUP = 'GROUP1', AGE = 27 where NAMES = 'jangeunhi'"
sqlQuery(hdb, query.x)
odbcClose(hdb)

#테이블에 데이터가 잘 update되었는지 확인해 보자
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
test.df <- sqlQuery(hdb, " select * from COMP_MST ")
odbcClose(hdb)

#sqlUpdate함수를 사용하여 update
#위의 함수는 좀더 테스트 한 후 에 진행한다.


#5. DB 테이블 삭제
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
sqlDrop(hdb, "COMP_MST")
odbcClose(hdb)

#테이블이 삭제 되었는지 확인해 보자
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
Result.x <- sqlQuery(hdb, " select * from tab ")
odbcClose(hdb)


