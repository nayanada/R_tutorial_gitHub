#RODBC 기술문서

#서론-----------------------------------------------------------------------------------------------------------------
#RODBC Package를 사용하여 DB에 있는 데이터를 Import 또는 Export하는 기능을 알아보기로 하자
#
#
#---------------------------------------------------------------------------------------------------------------------

#Step1 : library Install----------------------------------------------------------------------------------------------
#RODBC library install
#RODBC를 사용하기 위해서는 CRAN에서 RODBC package를 가지고와서 설치하여야 한다.
install.packages('RODBC')
library(RODBC)
#---------------------------------------------------------------------------------------------------------------------

#Step99 : Tip----------------------------------------------------------------------------------------------------------

#Windows 64bit 사용시 Error 대처방안
#R에서 RODBC 패키지를 이용하여 Oracle Database를 접속하여 데이터를 가져올 때 가끔 에러가 날 수 있습니다.
#이런 경우가 발생하는 것은 Windows 64bit 버전의 Oracle ODBC Driver를 사용할 때 입니다.

#예를 들어 설명하겠습니다.


# 패키지 불러오기
library(RODBC)

# Database 접속 정보
odbc.dsn <- "ORCL"
odbc.uid <- "scott"
odbc.pwd <- "tiger"

# SQL 작성
select.x <- "SELECT TNAME"
from.x <- "FROM tab"
sql.x <- paste(select.x, from.x, sep = " ")

# DB 접속
db.connect <- odbcConnect(dsn = odbc.dsn, uid = odbc.uid, pwd = odbc.pwd)
# 데이터 가져오기
import.tb.list <- sqlQuery(db.connect, sql.x, stringsAsFactors = FALSE)

#> import.tb.list <- sqlQuery(db.connect, sql.x, stringsAsFactors = FALSE)
#다음에 오류.Call(C_RODBCFetchRows, attr(channel, "handle_ptr"), max, buffsize,  : 
#  음수 길이의 벡터는 허용되지 않습니다

# 접속정보 해제
odbcClose(db.connect)


#=> 이럴 경우 odbcConnect 함수에 believeNRows 아규먼트 값을 FALSE로 바꾸면 에러없이 수행됩니다.

# DB 접속 : DB 접속 및 ODBC 설정이 사전에 필요함
db.connect <- odbcConnect(dsn = odbc.dsn, uid = odbc.uid, pwd = odbc.pwd, believeNRows=FALSE)
# 데이터 가져오기
import.tb.list <- sqlQuery(db.connect, sql.x, stringsAsFactors = FALSE)

#> import.tb.list
#     TNAME
#1    BONUS
#2     DEPT
#3      EMP
#4 SALGRADE

# 접속정보 해제
odbcClose(db.connect)

#DB Table 데이터 삭제(테이블은 남아 있음)
hdb  <- odbcConnect("LFEP;UID=ORASP;PWD=lgfsp9999") #DB connect
sqlClear(hdb, "BUF_RP_INIT_PLAN", errors = TRUE) #DB 데이터 삭제
odbcClose(hdb)

#R 데이터 DB에 적재
hdb  <- odbcConnect("LFEP;UID=ORASP;PWD=lgfsp9999") #DB connect
sqlSave(hdb,OUTPUT, "BUF_RP_INIT_PLAN", append = TRUE, rownames = FALSE) 
odbcClose(hdb)


#---------------------------------------------------------------------------------------------------------------------
?odbcClose
