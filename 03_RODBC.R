#RODBC �������

#����-----------------------------------------------------------------------------------------------------------------
#RODBC Package�� ����Ͽ� DB�� �ִ� �����͸� Import �Ǵ� Export�ϴ� ����� �˾ƺ���� ����
#
#
#---------------------------------------------------------------------------------------------------------------------

#Step1 : library Install----------------------------------------------------------------------------------------------
#RODBC library install
#RODBC�� ����ϱ� ���ؼ��� CRAN���� RODBC package�� �������ͼ� ��ġ�Ͽ��� �Ѵ�.
install.packages('RODBC')
library(RODBC)
#---------------------------------------------------------------------------------------------------------------------

#Step99 : Tip----------------------------------------------------------------------------------------------------------

#Windows 64bit ���� Error ��ó���
#R���� RODBC ��Ű���� �̿��Ͽ� Oracle Database�� �����Ͽ� �����͸� ������ �� ���� ������ �� �� �ֽ��ϴ�.
#�̷� ��찡 �߻��ϴ� ���� Windows 64bit ������ Oracle ODBC Driver�� ����� �� �Դϴ�.

#���� ��� �����ϰڽ��ϴ�.


# ��Ű�� �ҷ�����
library(RODBC)

# Database ���� ����
odbc.dsn <- "ORCL"
odbc.uid <- "scott"
odbc.pwd <- "tiger"

# SQL �ۼ�
select.x <- "SELECT TNAME"
from.x <- "FROM tab"
sql.x <- paste(select.x, from.x, sep = " ")

# DB ����
db.connect <- odbcConnect(dsn = odbc.dsn, uid = odbc.uid, pwd = odbc.pwd)
# ������ ��������
import.tb.list <- sqlQuery(db.connect, sql.x, stringsAsFactors = FALSE)

#> import.tb.list <- sqlQuery(db.connect, sql.x, stringsAsFactors = FALSE)
#������ ����.Call(C_RODBCFetchRows, attr(channel, "handle_ptr"), max, buffsize,  : 
#  ���� ������ ���ʹ� ������ �ʽ��ϴ�

# �������� ����
odbcClose(db.connect)


#=> �̷� ��� odbcConnect �Լ��� believeNRows �ƱԸ�Ʈ ���� FALSE�� �ٲٸ� �������� ����˴ϴ�.

# DB ���� : DB ���� �� ODBC ������ ������ �ʿ���
db.connect <- odbcConnect(dsn = odbc.dsn, uid = odbc.uid, pwd = odbc.pwd, believeNRows=FALSE)
# ������ ��������
import.tb.list <- sqlQuery(db.connect, sql.x, stringsAsFactors = FALSE)

#> import.tb.list
#     TNAME
#1    BONUS
#2     DEPT
#3      EMP
#4 SALGRADE

# �������� ����
odbcClose(db.connect)

#DB Table ������ ����(���̺��� ���� ����)
hdb  <- odbcConnect("LFEP;UID=ORASP;PWD=lgfsp9999") #DB connect
sqlClear(hdb, "BUF_RP_INIT_PLAN", errors = TRUE) #DB ������ ����
odbcClose(hdb)

#R ������ DB�� ����
hdb  <- odbcConnect("LFEP;UID=ORASP;PWD=lgfsp9999") #DB connect
sqlSave(hdb,OUTPUT, "BUF_RP_INIT_PLAN", append = TRUE, rownames = FALSE) 
odbcClose(hdb)


#---------------------------------------------------------------------------------------------------------------------
?odbcClose