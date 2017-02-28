#-----------------------------------------------------------------------------------
#Title : CSV File Import
#Csv File Import�Ҷ� data.table�� �������.
#���� read.csv()�Լ��� ����� �� ���� �ӵ��� ������.
#�ٸ��� �� �ð��� �����ѵ� ������ ȣ�� �ϴ� �ð��� ���� �������� ���߿� �����̴�.
#�׽�Ʈ ��ǻ�� ȯ���� windows 7 64bit memory 8GB
#�׽�Ʈ Result : fread > read.table >  read.csv.ffdf > read.csv.sql > read.csv
#package : sqldf, data.table, ff
#���� : 32bit ��ǻ�Ϳ����� ff package�� ����� �ȵɼ� ����
#-----------------------------------------------------------------------------------


# ���� �׽�Ʈ�� Sample ������ ��������.
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

# �����Ǿ��� File�� CSV File�� ����
write.table(DT,"c:\\Rproject\\test.csv",sep=",",row.names=FALSE,quote=FALSE)
cat("File size (MB):", round(file.info("c:\\Rproject\\test.csv")$size/1024^2),"\n")
# 50 MB (1e6 rows x 6 columns)

#Test1 : read.csv()�� csv file import
system.time(DF1 <-read.csv("c:\\Rproject\\test.csv",stringsAsFactors=FALSE))
#�����  �ý��� elapsed 
#12.87    0.05   12.92 
# 13 sec (first time in fresh R session)

#�ѹ� ȣ���� ���Ŀ� �ٽ� ���� �̸����� ȣ���ϸ� �ణ�� �ӵ� ���� ȿ���� �ִ�.
#������ �ѹ� ȣ���� �����͸� �ٽ� ȣ���� ��찡 ������?
system.time(DF1 <- read.csv("c:\\Rproject\\test.csv",stringsAsFactors=FALSE))
#�����  �ý��� elapsed 
#11.88    0.06   11.96
# 12 sec (immediate repeat is faster, varies)

#Test2 : read.table()�� csv file import
system.time(DF2 <- read.table("c:\\Rproject\\test.csv",header=TRUE,sep=",",quote="",
                              stringsAsFactors=FALSE,comment.char="",nrows=n,
                              colClasses=c("integer","integer","numeric",
                                           "character","numeric","integer")))
#�����  �ý��� elapsed 
#6.07    0.06    6.13
# 6 sec (consistently). All known tricks and known nrows, see references.

#Test3 : fread()�� csv file import
#data.frame�������� �����͸� ȣ���� �� read.csv, read.table�� ���� 6 ~ 13�� �ɷȴ�.
#�׷� �̹����� data.table package���� �����ϴ� fread()�Լ��� ����Ͽ� �����͸� ȣ���غ���.
system.time(DT1 <- fread("c:\\Rproject\\test.csv"))
#�����  �ý��� elapsed 
#2.14    0.00    2.14
#  2 sec (faster and friendlier)
#������ ����� ������� �ּ� 3�迡�� �ִ� 6���̻��� �ӵ����̸� �����ְ� �ִ�.

#Test4: read.csv.sql()�� csv file import
require(sqldf)
system.time(SQLDF <- read.csv.sql("c:\\Rproject\\test.csv",dbname=NULL))
#�����  �ý��� elapsed 
#7.80    0.11    7.93 
# 8 sec (friendly too, good defaults)
#����������ٴ� ���ų� ���� ���� �ӵ��� �����ְ� ������ fread���ٴ� 3���̻��� �ӵ� ���̸� ���̰� �ִ�.

#Test5: read.csv.ffdf()�� csv file import
install.packages('ff')
require(ff)
system.time(FFDF <- read.csv.ffdf(file="c:\\Rproject\\test.csv",nrows=n))
#�����  �ý��� elapsed 
#6.71    0.11    6.82
# 6.82 sec (friendly too, good defaults)
#ff package�� ����Ͽ� �����͸� ȣ���ϴ� �ӵ��� ����������� ���ų� ���� ���� �ӵ��� ����������, �츮�� ���� ����ϴ� ������ ������ �ƴϴ�.
head(FFDF)

#Test6: 500MB csv file Import Test
# �׷� �̹����� ���� ū Size �����͸� ������ �׽�Ʈ�� �غ���
#������ �����ͺ��� 10�� ū �������̴�.
l = vector("list",10)
for (i in 1:10) l[[i]] = DT
DTbig = rbindlist(l)
tables()
write.table(DTbig,"c:\\Rproject\\testbig.csv",sep=",",row.names=FALSE,quote=FALSE)
# 500MB (10 million rows x 6 columns)
gc(reset = T)

#�׷� ���ÿ� ���ֻ���ϴ� ������� csv File�� ȣ���� ����.
system.time(DF3 <- read.table("c:\\Rproject\\testbig.csv",header=TRUE,sep=",",         
                             quote="",stringsAsFactors=FALSE,comment.char="",nrows=1e7,                     
                             colClasses=c("integer","integer","numeric",
                                          "character","numeric","integer")))
#�����  �ý��� elapsed 
#60.31    0.69   61.00 
# 61�� ��ȴ�. ���򿡴� 1GB�̻��� �����͵� ȣ���� ���� ������.. 
gc(reset = T)

#�׷� �̹����� fread�� csv File�� ȣ���غ���.
system.time(DT3 <- fread("c:\\Rproject\\testbig.csv"))
#�����  �ý��� elapsed 
#21.53    0.11   21.67
# 21�� �ɷȴ�. ��������� ���� ���� �������. 3���̻��� �ӵ����̸� ���̰� �ִ�.

#�׷� �츮�� csv file�� ȣ���� �� ���� ���� ���� read.csv()�Լ��� �׽�Ʈ�� �غ���. �󸶳� �ɸ���?
system.time(DF4 <- read.csv("c:\\Rproject\\testbig.csv",stringsAsFactors=FALSE))
#�����  �ý��� elapsed 
#78.03    1.11   79.45
#80�� ���� �ҿ�Ǿ����� �ִ�.

#�׷� �ε����� ������ ������? �ѹ� Ȯ���� ����.
all(mapply(all.equal, DF3, DT3))
#����� TRUE�� ���Դ�.

