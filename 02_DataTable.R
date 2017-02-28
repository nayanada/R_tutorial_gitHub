#data.table 기술문서

#서론-----------------------------------------------------------------------------------------------------------------
#시간이 갈수로 우리가 처리해야되는 데이터 size는 커지고 있다.
#이러한 현상으로 데이터 핸들링시 소요시간이 오래 걸리는 문제점을 가지고 있다.
#기존에 많이 사용하였던 data.frame형식을 벗어나서 좀더 빠르게 데이터 핸들링을 할수 있는 방법을 알아보기로 한다.
#첫번째 제시하는것은 data.table package를 추천한다.
#기존에 우리가 사용하던 data.frame형식과 유사하여 짧은 시간안에 사용방법을 숙지 할수 있을것으로 생각한다.
#---------------------------------------------------------------------------------------------------------------------

#Step1 : library Install----------------------------------------------------------------------------------------------
#data.table library install
#data.table을 사용하기 위해서는 CRAN에서 data.table package를 가지고와서 설치하여야 한다.
install.packages('data.table')
library(data.table)
#---------------------------------------------------------------------------------------------------------------------
?data.table
#Step2 : data.table Create--------------------------------------------------------------------------------------------
#data.table을 Create하는 방식은 data.frame과 동일 하다.
DF <- data.frame(x=c("b","b","b","a","a"),v=rnorm(5))
DT <- data.table(x=c("b","b","b","a","a"),v=rnorm(5))
DT
DF

CARS <- data.table(cars)
CARS2 <- CARS

#tables()함수를 사용하면 오브젝트에 생성되어진 data.table들의 정보를 보여준다.
tables()

#컬럼 생성
DT <- data.table(a=LETTERS[c(1,1:3)],b=4:7,key="a")
DT[,c:=8]        # c라는 컬럼이름으로 생성되어지며 값은 8을 넣은다.
DT[2,c:=10]     # c의 컬럼의 두번째 Row의 값을 10으로 변경한다.
DT[,c:=NULL]     # c컬럼을 삭제한다.
DT   
DT$c <- 8 #이런 방법을 사용해도 위의 DT[,c:=8]방법과 동일하다.
#---------------------------------------------------------------------------------------------------------------------

#Step3 : 데이터 추출 1------------------------------------------------------------------------------------------------
#data.table 데이터 추출
DT
DT[, x] #data.table에서 컬럼을 하나를 추출할때 컬럼명에 따음표("")를 입력하지 않음
DT[, "x"] # 다음과 같이 출력되어짐 ->   [1] "x"
DT$x #data.frame과 같은 방법으로 사용할 수 있음
DT[DT$x == "b",] #x컬럼의 값에서 b인  데이터를 추출하는 방식은 data.frame과 동일하다.
#그럼 data.table에서 subset함수를 사용할수 있을까?
subset(DT, x == "b") #당연히 가능하다.!!!

#그럼 데이터를 추출할때 꼭 컬럼명을 써야 데이터를 추출할 수 있는것인가? 값만 입력을 해도 데이터를 가지고 올수 없을까?
#그러한 경우에는 setkey()함수를 사용하면 된다.
#먼저 setkey(데이터 테이블 명, 키로 설정할 컬럼명)를 설정하여야 한다.
setkey(DT, x)
tables() #tables()함수로 각가가의 data.table정보를 보면 DT data.table에 KEY로 x가 설정되어진것을 확인할 수 있다.
#그럼 한번 데이터를 추출해 볼까?
DT["b", ] #아래의 결과와 같이 컬럼명을 입력하지 않아도 x컬럼의 값중에서 b인것만 추출되어 졌다.

#---결과------#
x          v
1: b -1.7456812
2: b  1.2293077
3: b -0.2452216
#-------------#

#다음은 옵션에서 mult를 알아보기로 하자 
DT[,mult="first"] #다음과 같을때는 인식이 안된네... 그럼 어떨때 사용하는 거지? 아! 좀전에 x컬럼에 키값으로 정의를 하였지!!
DT["b", mult = "first"] #x의 값이 b인 데이터에서 첫번쨰 값을 뽑아오는 구나..

#그럼 혹시 처음 방법은 x의 값이 a와 b가 있어서 그런건 아닐까?
DT2 <- data.table(x=c("b","b","b","b","b"),v=rnorm(5)) #새로운 data.table을 만들어 보자 x컬럼의 값은 b로만 하고 key값은 정의 안해본다.
DT2[ , mult = "first"] #이런 방법으로 는 안되는 구나. 그럼 x컬럼에 key값을 정의해서 다시 해보자.

setkey(DT2, x)
DT2[ , mult = "first"] #이방법도 안된다. 그럼 결국은 다음과 같은 방법을 사용하였을 때나 가능한 방법인가 보다.
DT2["b" , mult = "first"] #그렇구나. 그럼 혹시 x의 컬럼의 값들(a,b)를 동시에 첫번쨰만 뽑아올수 있을까?
DT[c("a","b"), mult = "first"] #된다 !!!!

#결국 mult = "first"는 키값으로 정의되어진 x의 컬럼의 값에서 요인별 첫번째 값을 추출할떄 사용 하는 방법이다.
#mult의 변수는 "all" ,"first", "last"가 있다.
#그리고 x의 컬럼에 키값을 설정하면 다음과 같이 사용할 수 있다.
DT["a"] #이렇게 아래와 같이 사용을 안해도 된다.
DT["a", ]

#그럼 DT 데이터 테이블에 컬럼을 추가 할떄는? data.frame과 동일하다.
DT$z <- 1
DT
DT["a"] #이방법은 나머지 모든 컬럼이 같이 나오게 된다. 그럼 x의 컬럼이 a일때 v,z의 컬럼만 보고 싶을떄는 어떻게 해야 할까?
DT["a", c(v,z)] #헐 이상하게 뽑힌다. V1이라는 새로운 컬럼이 생성되어지면서 v, z의 값이 들어가 있는것을 확인할 수 있다.
DT[i = "a", j = list(v,z)] #list()안에 컬럼명을 입력하면 되어진다. 
DT["a", list(v, z)]
DT["a", list("v", "z")] #컬럼명에 따옴표를 사용하면 안된다. 꼭!!!
#---------------------------------------------------------------------------------------------------------------------

#Step3 : 데이터 추출 2------------------------------------------------------------------------------------------------
#그럼 이번에는 좀더 많은 데이터를 가지고 data.frame과 data.table의 데이터 추출의 속도를 알아보기로 하자.

#먼저 예제 데이터를 만들고
grpsize <-ceiling(1e7/26^2)
tt <- system.time( DF <- data.frame(x=rep(LETTERS,each=26*grpsize),
                                 y=rep(letters,each=grpsize),
                                 v=runif(grpsize*26^2),
                                 stringsAsFactors=FALSE))
#DF = row : 10,000,068, col = 3
head(DF,3)
tail(DF,3)

#data.frame에서 x컬럼의 값중에서 "R"을 y컬럼의 값중에서 "h"를 추출하여 ana1의 새로운 data.frame에 저장하는 시간을 알아보자
tt <- system.time(ans1 <- DF[DF$x=="R" & DF$y=="h",]) #1.7초 걸린다. 단순이 데이터 Select하는데 1초 이상이 걸리다니.

#그럼 subset()함수를 사용하였을때는 얼마나 나올까?
tt <- system.time(ana1.1 <- subset(DF, x == "R" & y == "h")) #위의 방법보다 속도가 더 오래 걸린다. 1.9초

#그럼 x, y의 컬럼을 factor로 변경하면 속도가 빨라질까?
DF$x <- as.factor(DF$x)
DF$y <- as.factor(DF$y)
tt <- system.time(ans1.2 <- DF[DF$x=="R" & DF$y=="h",]) #헐~~ factor로 변경하였더니 속도가 더 오래건리는것으로 나타났다.
#사용자  시스템 elapsed 
#2.74    0.09    2.84
tt <- system.time(ana1.3 <- subset(DF, x == "R" & y == "h"))
#사용자  시스템 elapsed 
#2.98    0.11    3.09 

#그럼 이번에는 data.frame의 DF를 data.table로 생성하여 데이터를 추출해보자. 
DT <- data.table(DF)
setkey(DT,x,y) #알고 있겠지만 동시에 여러 컬럼에 key값을 설정할 수 있다. 몰랐다면 지금 이라도 알면 된다.
ss <- system.time(ans2 <- DT[J("R","h")]) #여기서 보면 J라는 함수를 사용하였다. J는 data.table안에서만 사용할 수있다. 자세한 내용은 다음에 하겠다.
#위의 결과는 순식간에 데이터를 추출하게된다. 0초다.. 

#문득 이런 생각이 든다. x y컬럼을 key값으로 정의 안하면 얼마나 걸린지.. 그럼 한번 해보자..
DT2 <- data.table(DF)
ss <- system.time(ans3 <- DT2[DT2$x == "R" & DT2$y == "h"]) #data.frame보다는 빠른 속도를 보여주지만 컬럼에 키값을 설정한것 보다는 속도가 느리게 나왔다.
#사용자  시스템 elapsed 
#0.94    0.01    0.96

unique(ans2 == ans3) #추출되어지는 결과는 동일하다.

ss <- system.time(ana4 <- subset(DT2, x == "R" & y == "h")) #subset()함수를 사용할때는 소요시간이 더 오래 걸리는 것으로 나왔다.
#사용자  시스템 elapsed 
#1.13    0.09    1.21

#그럼 정리해보자. 다음과 같은순이 데이터 추출하는데 빠른순이다.
#1. key값을 설정한 data.table < 2. key값을 설정안한 data.table < 3. key값을 설정안한 data.table을 subset()함수로 추출
#    < 4. data.frame < 5. subset()함수로 추출한 data.frame < 6. factor로 바꾼 data.frame < 7. factor로 바꾼 data.frame을 subset()함수로 추출
# 데이터 추출시 data.table로 사용하여 데이터를 추출하는게 가장 소요시간이 적게 나왔다. 많이 사용하자.
#---------------------------------------------------------------------------------------------------------------------

#Step4 : 데이터 그룹------------------------------------------------------------------------------------------------
#이번에는 그룹별 데이터를 summary하는 방법과 소요시간에 대하여 알아보기로 한다.
#데이터 추출할때 data.table이 빠르지만 그룹별 summary할때 data.frame가 빠르면 무슨 소용이 있겠는가.
#데이터 추출할떄 data.table이 빨랐으니까 이번에도 기대하고 진행해 보기로 하자.

#그룹별 통계량 구하기
#data.frame에서는 그룹별 sum하는 것은 aggregate를 추천한다.
#다른 방법을 사용해보았지만 aggregate가 가장 빠르게 나왔다. 개인적 테스트로는....

#먼저 예제 데이터를 만들고..
DF <- data.frame(x=rep(LETTERS,each=26*grpsize),
                 y=rep(letters,each=grpsize),
                 v=runif(grpsize*26^2),
                 stringsAsFactors=FALSE)
DT <- data.table(DF)
setkey(DT,x,y) #키값도 정의하고..

#우선적으로 data.frame를 테스트 해보자 얼마나 속도가 나오는지.
tt <- system.time(Sum_DF <- aggregate(DF$v, by = list(DF$x), sum))
head(Sum_DF)
#사용자  시스템 elapsed 
#12.18    0.50   12.68 
#data.frame을 그룹별로 sum하는 소요시간은 12.68초가 소요되었다. 생각 외로 오래 걸린다.

#그럼 data.table을 테스트 해보자. data.table은 aggregate함수를 사용하지 않고 내부적으로 그룹별로 sum을 할수 있다.
ss <- system.time(Sum_DT <- DT[,sum(v),by=x])
head(Sum_DT)
#사용자  시스템 elapsed 
#0.24    0.03    0.26 
# 1초도 안되는 시간에 결과가 나왔다. 48배의 속도의 차이가 났다. 어마어마 한 속도다.

#그럼 data.table에 aggregate함수를 사용해서 그룹별 sum을 하였을 때는 얼마나 걸릴까?
ss <- system.time(Sum_DT2 <- aggregate(DT$v, by = list(DT$x), sum))
#사용자  시스템 elapsed 
#11.98    0.53   12.51
#이런 방법은 사용하지 말자 data.frame과 거의 같은 결과가 나왔다. 

#그럼 동시에 sum, min, max, median을 구해보기로 하자 
ss <- system.time(Sum_DT3 <- DT[,list(SUM1 = sum(v),
                                      MIN1 = min(v),
                                      MAx1 = max(v),
                                      MED1 = median(v)),by=x])
#사용자  시스템 elapsed 
#0.55    0.02    0.56
#역시나 1분이 안되는 시간에 결과가 나왔다.

#확장 예제
ss <- system.time(Sum_DT4 <- DT[,sum(v),by= list(x, y)]) #x, y별로 그룹하여 sum한 결과도 0.18초가 나왔다.
tt <- system.time(Sum_DF2 <- aggregate(DF$v, by = list(DF$x, DF$y), sum))
#사용자  시스템 elapsed 
#14.29    0.81   15.10 

#다음과 같이 필요한 데이터만 추출하여 그룹별 sum을 구할수도 있다.
ss <- system.time(Sum_DF5 <- DT[c("A","B"), sum(v)]) 
#데이터 처리할때 aggregate가 젤 좋다고 생각한 내가 한심해진다. ㅜ,.ㅜ
#---------------------------------------------------------------------------------------------------------------------

#Step5: 데이터 합치기------------------------------------------------------------------------------------------------
#이번에는 여러 데이터를 합치는 방법에 대하여 알아보기로 하자.
#data.frame에서 데이터를 합치기 위해서 사용하는 방법은 rbind, cbind, merge, sqldf가 있었다.
#data.table에서도 위의 방법을 사용할 수 있는지 먼저 알아보고, 다른 방법에 대해서도 알아보기로 하자.
#이번장은 처리 속도 위주보다는 기능 위주로 진행하겠다.

#먼제 예제 데이터를 만들고..
DF_1 <- data.frame(AA = letters[1:5], BB = rnorm(5), stringsAsFactors=FALSE)
DF_2 <- data.frame(AA = letters[1:10], CC = c(1:10), stringsAsFactors=FALSE)
DF_3 <- data.frame(EE = LETTERS[1:5], DD = sample(1:100, 5), stringsAsFactors=FALSE)
DF_4 <- data.frame(AA = letters[6:8], BB = rnorm(3), stringsAsFactors=FALSE)

DT_1 <- data.table(DF_1)
DT_2 <- data.table(DF_2)
DT_3 <- data.table(DF_3)
DT_4 <- data.table(DF_4)

#먼저 cbind를 해보자
cbind(DF_1, DF_3)
cbind(DT_1, DT_3)
#data.frame과 data.table과 같은 결과가 나왔다.

#그럼 rbind는 ?
rbind(DF_1, DF_4)
rbind(DT_1, DT_4)
#역시나 동일한 결과가 나왔다.

#그럼 마지막 테스트 merge다
merge(DF_1, DF_2, all.x = T)
merge(DT_1, DT_2, all.x = T) #Error가 난다. 왜지? 혹시 key값을 설정 안해서? 그럼 한번 Key 값을 설정하자.
merge(DT_1, DT_2, by = "AA", all.x = T) #그전에 by를 사용해서 기준 컬럼을 설정해보자. 잘나온다. key 값을 설정을 하지 않아서 결과가 나오지 않는 것이 아니라
#옵션이서 by를 하지 않아서 그런것이다.

setkey(DT_1,AA)
setkey(DT_2,AA)
merge(DT_1, DT_2, all.x = T) 

#그럼 key 설정을 해지하는 것은 어떻게 해야 할까? 
setkey(DT_1, NULL) #key 설정 해지방법은 NULL을 사용하면 된다.

#테스트를 한결과 data.table도 rbind, cbind, merge를 사용할 수 있다.
#그러면 rbind, cbind, merge와 같은 결과를 내는 방법이 있을지 알아보기로 하자.
DT_1[DT_2] #이방법은 Key 값을 설정해야 사용할 수 있다. 그런데 outer join과 같은 결과가 나오네..
#그럼 left join과 같은 결과가 나오려면 어떻게 해야 하지?
DT_1[DT_2, nomatch = 0] #nomatch = 0으로 설정하면 된다.
DT_2[DT_1] #이방법을 사용해도 된다.
#하지만 위 방법보다는 확실한 merge()함수를 사용하기로 하자.

#참고자료
#여기서 다양한 데이터 합치는 방법을 숙지하자..
http://blog.espol.edu.ec/nemo/2013/12/23/merge-data-a-review-of-the-differences-between-merge-inner-join-left-join-right-join-full-join-cbind-and-rbind-when-used-data-table-objects-in-r/
#---------------------------------------------------------------------------------------------------------------------


