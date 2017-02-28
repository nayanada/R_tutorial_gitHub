#sqldf �������

#����-----------------------------------------------------------------------------------------------------------------
#sqldf Package�� ����Ͽ� DB���� ����ϴ� sql���� R���� ����ϴ� ����� �˾ƺ���� ����.
#sql���� �˰������� R�� ������ �ڵ鸵 ��ų�� �����Ͽ��� ����� Ŀ���� �� �ִ�.
#
#---------------------------------------------------------------------------------------------------------------------

#Step1 : library Install----------------------------------------------------------------------------------------------
#sqldf library install
#sqldf ����ϱ� ���ؼ��� CRAN���� sqldf package�� �������ͼ� ��ġ�Ͽ��� �Ѵ�.
#install.packages('sqldf')
library(sqldf)
#---------------------------------------------------------------------------------------------------------------------
?sqldf

#Step2 : sqldf package �ѷ����� �� Ȱ��--------------------------------------------------------------------------------
#sqldf package���� ������ ���� 3���� �Լ��� �����Ѵ�.

#read.csv.sql : csv file�� ȣ���ϴ� �Լ�
#csv file�� ��ü �� ������ �ü��� ������ sql���� Ȱ���Ͽ� �����͸� ������ �ü� ����
#read.csv.sql(file, sql = "select * from file", header = TRUE, sep = ",", row.names, eol, skip, 
#             filter, nrows, field.types, comment.char, dbname = tempfile(), drv = "SQLite", ...)

#���� iris�����͸� csv file�� ������
#��δ� c:\Rproject\EXAM�� iris.csv file�� ����
#���� ��� ������ ������ ���� ���� ���� ������ �����ϵ���.
write.csv(iris, "c:\\Rproject\\EXAM\\iris.csv", quote = FALSE, row.names = FALSE)
iris1 <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv")
head(iris1)
#���� ���� ����ϸ� sql���� ������ ���� �����̴�. select * from file
#file : c:\\Rproject\\EXAM\\iris.csv

#�׷� sql���� Ȱ���Ͽ� Sepal.Length�� ���̰� 5���� ū �����͸� ȣ���ϴ°��� �غ���.
iris2 <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv", 
                      sql = "select * from file where Sepal.Length > 5")
#���� ���� �Ͽ��� ���� ������ ���� Error�� ���´�.
#Error in sqliteExecStatement(con, statement, bind.data) : 
#  RS-DBI driver: (error in statement: no such column: Sepal.Length)

#�׷� �ɼǿ��� eol = "\n"�� ����ؼ� �����غ���.
#Error in sqliteExecStatement(con, statement, bind.data) : 
#  RS-DBI driver: (error in statement: no such column: Sepal.Length)
iris2 <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv", 
                      sql = "select * from file where Sepal.Length > 5", eol = "\n")
#���� ���� �Ͽ��� ���� ������ ���� Error�� ���´�. �ֱ׷���?
#Error in sqliteExecStatement(con, statement, bind.data) : 
#  RS-DBI driver: (error in statement: no such column: Sepal.Length)
#ó���� ȣ���� ������ iris1 �÷����� Ȯ���غ���. 
names(iris1)
#[1] "Sepal_Length" "Sepal_Width"  "Petal_Length" "Petal_Width"  "Species" 
#�÷����� �ٸ���. "_"�� �Ǿ��ֳ�? "."�� �ƴϰ�.. csv file�� ���� ���� ���� ".'�� �Ǿ��ִµ�.
#�׷� where Sepal.Length > 5 -> where Sepal_Length > 5 �� �����ؼ� �Ͽ��� ���� ��� Ȯ���� ����.
iris2 <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv", 
                      sql = "select * from file where Sepal_Length > 5")
#�������� �߳��´�.
#�׷� ������ ���� �Ͽ��� ����?
iris3 <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv", 
                      sql = "select * from file where Sepal_Length > 5", eol = "\n")
#�߳����� �ִ�.

#�׷� ����� �������� Ȯ���� ����.
tail(iris2)
tail(iris3)
#iris3�� ����� �������� \r�� �ٴ´�. �ֱ׷���?
#�ɼǿ��� eol = "\n"�� ����ؼ� �׷��� ������ �߸𸣰ڴ�.
#Ȥ�� ������ �÷��� ���ڿ��� �׷���?
#�׷� ������ �÷��� �����ϰ� �ѹ� �ٽ� ȣ���غ���.
#������ �÷��� ������ �����͸��� iris2.csv�� �ϰڴ�.
iris4 <- read.csv.sql("c:\\Rproject\\EXAM\\iris2.csv", 
                      sql = "select * from file where Sepal_Length > 5")

iris5 <- read.csv.sql("c:\\Rproject\\EXAM\\iris2.csv", 
                      sql = "select * from file where Sepal_Length > 5", eol = "\n")

tail(iris4)
tail(iris5)
str(iris4)
str(iris5)
#����� �����ϰ� ���Դ�. �ᱹ ������ �÷��� ���ڿ��� �׷� ����� ���°ǰ�?
#Ȥ�� ���� �ٸ� �����͸� ���� ȣ���غ����� ����.
#��� �÷��� ���ڷ� �Ǿ��ִ°�����
TestDf <- data.frame(AA = letters[1:10], BB = letters[5:14], CC = LETTERS[1:10])
write.csv(TestDf, "c:\\Rproject\\EXAM\\TestDf.csv", quote = FALSE, row.names = FALSE)
TestDf1 <- read.csv.sql("c:\\Rproject\\EXAM\\TestDf.csv", 
                      sql = "select * from file", eol = "\n")
TestDf2 <- read.csv.sql("c:\\Rproject\\EXAM\\TestDf.csv", 
                        sql = "select * from file")
#���ó� ������ ����� �������� �ִ�.
#help�� �������� eol = "\n"�� ��µ� �� �׷��� �𸣰ڴ�. �츮�� eol = "\n"�ɼ��� ������� �ʰ� ��������.


#read.csv2.sql : csv file�� ȣ���ϴ� �Լ�
#csv file�� ��ü �� ������ �ü��� ������ sql���� Ȱ���Ͽ� �����͸� ������ �ü� ����
read.csv2.sql(file, sql = "select * from file", header = TRUE, sep = ";", row.names, eol, skip, 
              filter, nrows, field.types, comment.char, dbname = tempfile(), drv = "SQLite", ...)
TestDf1 <- read.csv2.sql("c:\\Rproject\\EXAM\\TestDf.csv", 
                        sql = "select * from file", eol = "\n")
TestDf2 <- read.csv2.sql("c:\\Rproject\\EXAM\\TestDf.csv", 
                        sql = "select * from file")
#read.csv2.sql�� ���� ���� �����ϸ� �ϳ��� �÷��� �پ ����� ���´�.
#sep ����Ʈ �ɼ��� ";"�� �Ǿ� �ֱ� �����̴�.
#�ᱹ csv file�����ڰ� ","�� �Ǿ�������, read.csv.sql�� ����ϰ� ";"�� �Ǿ������� read.csv2.sql�� �������.

#�׷� �����͸� ������ �ö� summary�� �ؼ� ������ �ͺ���.
Summary_iris <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv", 
                      sql = "select Species, avg(Sepal_Length) as Mean_Sepal_Length from file group by Species")
#������ ���� ����� ���Դ�.
#Species Mean_Sepal_Length
#1     setosa             5.006
#2 versicolor             5.936
#3  virginica             6.588

#read.csv.sql, read.csv2.sql �Լ��� ����Ҷ��� csv file���� ������ �ɾ ����� �� ����������, ��� �����͸� ����Ҷ���
#���� ����� �ʿ�� ���� �� ����. �ٸ� �Լ��� ����ص� �����ϰ�. data.table package���� ����ϴ� fread�Լ��� ����ϸ�
#���� ���� �ӵ��� �����͸� ȣ���� �� �ִ�.

#sqldf : sql���� ����Ͽ� R data�� �ڵ鸵 �� �� �ִ� �Լ�
#�׷� ���� �����ϰ� ����� �� �ִ� sqldf �Լ��� ���Ͽ� �˾ƺ���.
#������ �ڵ鸵 �Ҷ� sql���� �˰� �־ �����͸� �ڵ鸵 �� �� �ִ�.
#?sqldf
#sqldf(x, stringsAsFactors = FALSE,
#      row.names = FALSE, envir = parent.frame(), 
#      method = getOption("sqldf.method"),
#      file.format = list(), dbname, drv = getOption("sqldf.driver"), 
#      user, password = "", host = "localhost", port,
#      dll = getOption("sqldf.dll"), connection = getOption("sqldf.connection"),
#      verbose = isTRUE(getOption("sqldf.verbose")))

#��ü �����Ϳ��� 5���� �̾Ƽ� ���� head() �� ������ ����� ���δ�.
#�׷��� ���� �Ʒ��� ���� ����� �ʿ䰡 ������? head()�Լ��� ���� �Ǵµ�..
sqldf("select * from iris1 limit 5")

#������ summary �ϴ� ����� ���Ͽ� �˾ƺ����� ����.
query.select <- "select Species, avg(Sepal_Length) as Mean_Sepal_Length, min(Sepal_Length) as Min_Sepal_Length, max(Sepal_Length) as Max_Sepal_Length"
query.from <- "from iris1"
query.group <- "group by Species"
query.x <- paste(query.select, query.from, query.group)
summary_iris <- sqldf(query.x)
#���Ͱ��� �׷캰 ���� ��跮 ���� ���� �� �ִ�.

#������ ���Ŀ� ���Ͽ� �˾ƺ����� ����. ����Ʈ�� ���������̴�.
query.x <- "select * from iris1 order by Sepal_Length" #���� ����
sqldf(query.x)
#���������� �ϱ� ���ؼ��� ������ ���� ����ϸ� �ȴ�.
query.x <- "select * from iris1 order by Sepal_Length desc" #���� ����
sqldf(query.x)

#������ join�ϴ� ����� ���Ͽ� �˾ƺ����� ����.
query.x <- "select a.*, b.* from iris1 as a, summary_iris as b where a.Species = b.Species"
Result_df <- sqldf(query.x)
#���� ���� ����ϸ� ��Ī�ϴ� �÷��� �ΰ��� �����Ǿ�����.
#�׷��Ƿ� select ������ ������ �÷��� �������ִ°� ����.

#DB���� ����ϴ� sql �������� ���� �ϰ� ����� �� �����Ƿ� inner join outer join, full join �� �پ��� join�� ����� �� �ִ�.
#�پ��� �����͸� ����Ͽ� �׽�Ʈ �غ��� �ٶ���.

#�߰������� ������ reshape�ϴ� ����� ���Ͽ� �˾ƺ����� ����.
DF <- data.frame(g = rep(1:2, each = 5), t = rep(1:5, 2), v = 1:10)
a16s <- sqldf("select g, sum((t == 1) * v) t_1, sum((t == 2) * v) t_2, sum((t == 3) * v) t_3, sum((t == 4) * v) t_4, sum((t == 5) * v) t_5 from DF group by g")

#---------------------------------------------------------------------------------------------------------------------