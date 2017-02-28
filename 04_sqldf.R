#sqldf 기술문서

#서론-----------------------------------------------------------------------------------------------------------------
#sqldf Package를 사용하여 DB에서 사용하는 sql문을 R에서 사용하는 방법을 알아보기로 하자.
#sql문만 알고있으면 R의 데이터 핸들링 스킬이 부족하여도 충분히 커버할 수 있다.
#
#---------------------------------------------------------------------------------------------------------------------

#Step1 : library Install----------------------------------------------------------------------------------------------
#sqldf library install
#sqldf 사용하기 위해서는 CRAN에서 sqldf package를 가지고와서 설치하여야 한다.
#install.packages('sqldf')
library(sqldf)
#---------------------------------------------------------------------------------------------------------------------
?sqldf

#Step2 : sqldf package 둘러보기 및 활용--------------------------------------------------------------------------------
#sqldf package에는 다음과 같이 3가지 함수가 존재한다.

#read.csv.sql : csv file을 호출하는 함수
#csv file을 전체 다 가지고 올수도 있으며 sql문을 활용하여 데이터를 가지고 올수 있음
#read.csv.sql(file, sql = "select * from file", header = TRUE, sep = ",", row.names, eol, skip, 
#             filter, nrows, field.types, comment.char, dbname = tempfile(), drv = "SQLite", ...)

#먼저 iris데이터를 csv file로 만들자
#경로는 c:\Rproject\EXAM에 iris.csv file로 생성
#예시 경로 폴더가 없으면 먼저 위와 같이 폴더를 생성하도록.
write.csv(iris, "c:\\Rproject\\EXAM\\iris.csv", quote = FALSE, row.names = FALSE)
iris1 <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv")
head(iris1)
#위와 같이 사용하면 sql문은 다음과 같은 형식이다. select * from file
#file : c:\\Rproject\\EXAM\\iris.csv

#그럼 sql문을 활용하여 Sepal.Length의 길이가 5보다 큰 데이터만 호출하는것을 해보자.
iris2 <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv", 
                      sql = "select * from file where Sepal.Length > 5")
#위와 같이 하였을 때는 다음과 같이 Error가 나온다.
#Error in sqliteExecStatement(con, statement, bind.data) : 
#  RS-DBI driver: (error in statement: no such column: Sepal.Length)

#그럼 옵션에서 eol = "\n"을 사용해서 실행해보자.
#Error in sqliteExecStatement(con, statement, bind.data) : 
#  RS-DBI driver: (error in statement: no such column: Sepal.Length)
iris2 <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv", 
                      sql = "select * from file where Sepal.Length > 5", eol = "\n")
#위와 같이 하였을 떄도 다음과 같이 Error가 나온다. 왜그럴까?
#Error in sqliteExecStatement(con, statement, bind.data) : 
#  RS-DBI driver: (error in statement: no such column: Sepal.Length)
#처음에 호출한 데이터 iris1 컬럼명을 확인해보자. 
names(iris1)
#[1] "Sepal_Length" "Sepal_Width"  "Petal_Length" "Petal_Width"  "Species" 
#컬럼명이 다르다. "_"로 되어있네? "."가 아니고.. csv file을 열어 봤을 때도 ".'로 되어있는데.
#그럼 where Sepal.Length > 5 -> where Sepal_Length > 5 로 변경해서 하였을 때는 어떨지 확인해 보자.
iris2 <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv", 
                      sql = "select * from file where Sepal_Length > 5")
#문제없이 잘나온다.
#그럼 다음과 같이 하였을 때는?
iris3 <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv", 
                      sql = "select * from file where Sepal_Length > 5", eol = "\n")
#잘나오고 있다.

#그럼 결과가 동일한지 확인해 보자.
tail(iris2)
tail(iris3)
#iris3의 결과는 마지막에 \r이 붙는다. 왜그럴까?
#옵션에서 eol = "\n"을 사용해서 그런거 같은데 잘모르겠다.
#혹시 마지막 컬럼이 문자여서 그런가?
#그럼 마지막 컬럼을 삭제하고 한번 다시 호출해보자.
#마지막 컬럼을 삭제한 데이터명은 iris2.csv로 하겠다.
iris4 <- read.csv.sql("c:\\Rproject\\EXAM\\iris2.csv", 
                      sql = "select * from file where Sepal_Length > 5")

iris5 <- read.csv.sql("c:\\Rproject\\EXAM\\iris2.csv", 
                      sql = "select * from file where Sepal_Length > 5", eol = "\n")

tail(iris4)
tail(iris5)
str(iris4)
str(iris5)
#결과가 동일하게 나왔다. 결국 마지막 컬럼이 문자여서 그런 결과가 나온건가?
#혹시 몰라서 다른 데이터를 만들어서 호출해보도록 하자.
#모든 컬럼이 문자로 되어있는것으로
TestDf <- data.frame(AA = letters[1:10], BB = letters[5:14], CC = LETTERS[1:10])
write.csv(TestDf, "c:\\Rproject\\EXAM\\TestDf.csv", quote = FALSE, row.names = FALSE)
TestDf1 <- read.csv.sql("c:\\Rproject\\EXAM\\TestDf.csv", 
                      sql = "select * from file", eol = "\n")
TestDf2 <- read.csv.sql("c:\\Rproject\\EXAM\\TestDf.csv", 
                        sql = "select * from file")
#역시나 동일한 결과를 내보내고 있다.
#help문 예제에는 eol = "\n"을 썼는데 왜 그런지 모르겠다. 우리는 eol = "\n"옵션을 사용하지 않고 실행하자.


#read.csv2.sql : csv file을 호출하는 함수
#csv file을 전체 다 가지고 올수도 있으며 sql문을 활용하여 데이터를 가지고 올수 있음
read.csv2.sql(file, sql = "select * from file", header = TRUE, sep = ";", row.names, eol, skip, 
              filter, nrows, field.types, comment.char, dbname = tempfile(), drv = "SQLite", ...)
TestDf1 <- read.csv2.sql("c:\\Rproject\\EXAM\\TestDf.csv", 
                        sql = "select * from file", eol = "\n")
TestDf2 <- read.csv2.sql("c:\\Rproject\\EXAM\\TestDf.csv", 
                        sql = "select * from file")
#read.csv2.sql을 위와 같이 실행하면 하나의 컬럼에 붙어서 결과가 나온다.
#sep 디폴트 옵션이 ";"로 되어 있기 때문이다.
#결국 csv file구분자가 ","로 되어있으면, read.csv.sql을 사용하고 ";"로 되어있으면 read.csv2.sql을 사용하자.

#그럼 데이터를 가지고 올때 summary를 해서 가지고 와보자.
Summary_iris <- read.csv.sql("c:\\Rproject\\EXAM\\iris.csv", 
                      sql = "select Species, avg(Sepal_Length) as Mean_Sepal_Length from file group by Species")
#다음과 같이 결과가 나왔다.
#Species Mean_Sepal_Length
#1     setosa             5.006
#2 versicolor             5.936
#3  virginica             6.588

#read.csv.sql, read.csv2.sql 함수를 사용할때는 csv file에서 조건을 걸어서 사용할 때 유용하지만, 모든 데이터를 사용할때는
#굳이 사용할 필요는 없을 것 같다. 다른 함수를 사용해도 무난하고. data.table package에서 재공하는 fread함수를 사용하면
#보다 빠른 속도로 데이터를 호출할 수 있다.

#sqldf : sql문을 사용하여 R data를 핸들링 할 수 있는 함수
#그럼 가장 유용하게 사용할 수 있는 sqldf 함수에 대하여 알아보자.
#데이터 핸들링 할때 sql문만 알고 있어도 데이터를 핸들링 할 수 있다.
#?sqldf
#sqldf(x, stringsAsFactors = FALSE,
#      row.names = FALSE, envir = parent.frame(), 
#      method = getOption("sqldf.method"),
#      file.format = list(), dbname, drv = getOption("sqldf.driver"), 
#      user, password = "", host = "localhost", port,
#      dll = getOption("sqldf.dll"), connection = getOption("sqldf.connection"),
#      verbose = isTRUE(getOption("sqldf.verbose")))

#전체 데이터에서 5개만 뽑아서 보자 head() 와 동일한 결과를 보인다.
#그런데 굳이 아래와 같이 사용할 필요가 있을까? head()함수를 쓰면 되는데..
sqldf("select * from iris1 limit 5")

#다음은 summary 하는 방법에 대하여 알아보도록 하자.
query.select <- "select Species, avg(Sepal_Length) as Mean_Sepal_Length, min(Sepal_Length) as Min_Sepal_Length, max(Sepal_Length) as Max_Sepal_Length"
query.from <- "from iris1"
query.group <- "group by Species"
query.x <- paste(query.select, query.from, query.group)
summary_iris <- sqldf(query.x)
#위와같이 그룹별 여러 통계량 값을 구할 수 있다.

#다음은 정렬에 대하여 알아보도록 하자. 디폴트는 오름차순이다.
query.x <- "select * from iris1 order by Sepal_Length" #오름 차순
sqldf(query.x)
#내림차순을 하기 위해서는 다음과 같이 사용하면 된다.
query.x <- "select * from iris1 order by Sepal_Length desc" #내림 차순
sqldf(query.x)

#다음은 join하는 방법에 대하여 알아보도록 하자.
query.x <- "select a.*, b.* from iris1 as a, summary_iris as b where a.Species = b.Species"
Result_df <- sqldf(query.x)
#위와 같이 사용하면 매칭하는 컬럼은 두개가 생성되어진다.
#그러므로 select 문에서 생성할 컬럼을 정의해주는게 좋다.

#DB에서 사용하는 sql 쿼리문은 동일 하게 사용할 수 있으므로 inner join outer join, full join 등 다양한 join을 사용할 수 있다.
#다양한 데이터를 사용하여 테스트 해보길 바란다.

#추가적으로 다음은 reshape하는 방법에 대하여 알아보도록 하자.
DF <- data.frame(g = rep(1:2, each = 5), t = rep(1:5, 2), v = 1:10)
a16s <- sqldf("select g, sum((t == 1) * v) t_1, sum((t == 2) * v) t_2, sum((t == 3) * v) t_3, sum((t == 4) * v) t_4, sum((t == 5) * v) t_5 from DF group by g")

#---------------------------------------------------------------------------------------------------------------------