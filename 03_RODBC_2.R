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

#���̺��� �� �����Ǿ������� Ȯ���غ���
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
test.df <- sqlQuery(hdb, " select * from COMP_MST ")
odbcClose(hdb)


#2. DB ���̺��� ������ insert
#�����͸� insert �ϴ� ������� �ΰ����� �ִ�.
#���� sqlSave�Լ��� ����Ͽ� �����͸� Insert�ϴ� ����� sqlQuery�Լ��� ����Ͽ� Insert�ϴ� ����� �ִ�.

#sqlSave�Լ��� ����Ͽ� Insert
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
sqlSave(hdb,Sample.df, "COMP_MST", append = TRUE, rownames = FALSE)
odbcClose(hdb)

#���̺��� �����Ͱ� �� ������ Ȯ���� ����
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
test.df <- sqlQuery(hdb, " select * from COMP_MST ")
odbcClose(hdb)

#sqlQuery�Լ��� ����Ͽ� Insert
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
query.x <- "insert into COMP_MST(COMPANY, COMP_GROUP, NAMES, AGE, PHONE_NUM) values('Begas', 'Group1', 'jangeunhi', 28, '01099990000')"
sqlQuery(hdb, query.x)
odbcClose(hdb)

#���̺��� �����Ͱ� �� ������ Ȯ���� ����
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
test.df <- sqlQuery(hdb, " select * from COMP_MST ")
odbcClose(hdb)


#3. DB ���̺� ������ ����
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
sqlClear(hdb, "COMP_MST", errors = TRUE)  
odbcClose(hdb)

#���̺��� �����Ͱ� �� �����Ǿ����� Ȯ���� ����
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
test.df <- sqlQuery(hdb, " select * from COMP_MST ")
odbcClose(hdb)

#4. ���̺� ������Ʈ
#�����͸� update �ϴ� ������� �ΰ����� �ִ�.
#���� sqlUpdate�Լ��� ����Ͽ� �����͸� update�ϴ� ����� sqlQuery�Լ��� ����Ͽ� update�ϴ� ����� �ִ�.

#sqlQuery�Լ��� ����Ͽ� update
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
query.x <- "update COMP_MST set COMP_GROUP = 'GROUP1', AGE = 27 where NAMES = 'jangeunhi'"
sqlQuery(hdb, query.x)
odbcClose(hdb)

#���̺��� �����Ͱ� �� update�Ǿ����� Ȯ���� ����
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
test.df <- sqlQuery(hdb, " select * from COMP_MST ")
odbcClose(hdb)

#sqlUpdate�Լ��� ����Ͽ� update
#���� �Լ��� ���� �׽�Ʈ �� �� �� �����Ѵ�.


#5. DB ���̺� ����
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
sqlDrop(hdb, "COMP_MST")
odbcClose(hdb)

#���̺��� ���� �Ǿ����� Ȯ���� ����
hdb    <- odbcConnect(dsn = "orcl", uid = "scott", pwd = "tiger", believeNRows = FALSE)
Result.x <- sqlQuery(hdb, " select * from tab ")
odbcClose(hdb)

