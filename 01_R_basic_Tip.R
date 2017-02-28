#R 교육 실습 예제
#================목차===================== 
#1일차 실습: 1. Help 사용
#1일차 실습: 2. package 설치 및 호출
#1일차 실습: 3. 데이터 다루기

#2일차 실습: 1. 연산자 및 기본적인 R 함수
#2일차 실습: 2. 그래프
#2일차 실습: 3. 함수 생성

#3일차 실습: 1. Tip
#=========================================

#-1일차 실습: 1. Help 사용-----------
#R에서는 하나의 명령어 함수에 대한 자세한 옵션기능의 사용법과 함께 관련함수를 동시에 제공해 주기 때문에 
#프로그램의 모든 과정에서 이 기능을 최대한 활용한다면 더욱 간단하면서도 세련된 프로그램을 작성할 수 있음.

#예제1
help() #전체 Help 메뉴가 나타남
help(plot) #그래프를 그려주는 함수인 plot에 대한 Help
?plot
?"plot"
help("[[") #특수문자 등의 사용법에 대해서서도 help 기능을 이용할 수 있음
?"[["

#--------------------------

#-1일차 실습: 2. Package 설치 및 호출-----------
#Package 설치
#메뉴창에서 Package를 찾아서 설치를 할수도 있지만 command에서도 install.packages()함수를 사용하여 Package를 설치할 수 있음
#예제1
install.packages('data.table')

#Package 호출
#Package가 설치되었다하여 Package안에 있는 함수를 바로 사용할 수 없다.
#require() 또는 library()함수를 사용하여 사용자가 필요한 Package를 호출 후 사용함.
#예제2
require("data.table")
library(data.table)

#search() 또는 searchpaths()함수를 사용하여 Package가 호출되었는지 확인 할 수 있음
#예제3
search()
searchpaths()
ls(pos = 2)
#-----------------------------------


#-1일차 실습: 3. 데이터 다루기-----------

#3.1 자료 입력 출력, 백터(Vector)
#자료 입력
#R의 함수 중 하나인 c() 함수와 scan() 함수를 이용하여 직접 자료를 입력할 수 있음

#사용자가 직접 할당자와 c() 함수를 이용하여 벡터를 입력할 수 있
#예제1
grp <- c(1,1,1,2,2,2,3,3,3,4,4,4,5,5,5)
grp

#scan() 함수를 이용하면 직접 데이터를 입력하여 생성할 수 있음
#scan() 함수를 이용하는 경우 한 줄의 입력이 끝난 후 다음 줄의 처음에서 Enter 키를 누르면 
#자동적으로 scan() 함수가 불러지고 계속적으로 데이터를 입력할 수 있다. 
#새로운 줄에서 데이터를 입력하지 않고 Enter 키를 누르면 scan() 함수가 종료되고 값이 저장
#예제2
grp <- scan()
grp

#scan() 함수는 default 값으로 숫자임. 문자를 입력시 다음과 같이 사용함.
#예제3
grp <- scan(what=character(0))
grp

#행렬 입력
#행렬을 입력하기 위하여 matrix() 함수에서 scan() 함수를 사용한 후 byrow 변수를 사용하여 행단위로 데이터를 입력할 수 있음
#예제1
height <- matrix(scan(), byrow=T, ncol=2)
height

#리스트 입력
#리스트를 입력할 때도 scan() 함수가 사용되어지는데 주의할 점은 각 성분들의 개수가 같아야 함. 
#즉, 직사각형 꼴의 데이터 형태와 같은 의미임. 만약 결측치가 존재한다면 NA들로 채워져야만 함.
#예제1
heart <- scan(what=list("",0,0))

#자료 출력
#sink() 함수는 R 명령어로부터 나오는 출력을 터미널로 보내지 않고 파일로 만드는 함수
#예제1
tmp.x <- data.frame(AA = rnorm(10), BB = rnorm(10))
sink("c:\\Rproject\\OUT\\info.txt")
summary(tmp.x)
tmp.x
sink()

#Vector(백터)
#벡터란 한 개 이상의 원소로 구성된 자료구조로서 R의 자료 객체 중에서 가장 기본이 되는 자료 객채임.
#그리고 하나의 벡터의 원소는 한 가지 형태(mode)만이 가능

#백터 생성
#예제1
scan()
seq(1, by=0.05, along=1:5)    #seq(시작값, by=증가분, 조건지정)
seq(1, 7, by=2)
seq(1, -1, by=-0.5)
seq(1,7,length=3)
rev(seq(1:5))   #rev : 자료의 순서를 역순으로 만드는 함수

#예제2
rep(c(1,2,3),3)  #rep(a,b)는 a를 b만큼 반복
rep(1:3,3)      #a:b는 a부터 b까지의 수
rep(c(4,2), times=2)
rep(c(4,2), times=c(2,1))
rep(c(4,2), length=3)
paste("no", 1:5)     #반복되는 문자에 첨자를 붙여줌

#기본함수
#예제1
v1 <- c(1,2,3)   #숫자형 벡터 생성
v2 <- c("a", "b", "c")   #문자형 벡터 생성
v3 <- c(T, F, T)
height <- c(160, 140, 155)     #height 벡터 생성
people <- c("Ned", "Jill", "Pat") 
names(height) <- people   #height 벡터의 원소에 이름을 할당
height["Ned"]
names(height) <- NULL      #height 벡터의 원소의 이름을 삭제

#관련함수
#벡터에서 자료를 삽입하고 삭제와 관련된 다양한 함수들을 살펴본다.
#이러한 함수들에는 replace(), append(), order(), sort() 함수 등이 있음.

#예제1
vec1 <- c(1,2,3,4,5)  #1~5까지 자료를 갖는 vec1 변수 생성
vec1[2]     #두 번째 자료
vec1[c(2,3,5)]    #vec1의 2, 3, 5의 값만 표현
vec1[c(-2,-3)]    #vec1의 2, 3번째 자료 값 삭제
vec1[vec1>2]    #vec1에서 2보다 큰 값만 표현
vec1[2] <- 6    #두 번째 위치의 2값이 6으로 대체됨
replace(vec1, 3, 2)   #vec1의 세 번째 자료를 2로 변경
append(vec1, 8, 5)    #vec1의 5번째 자료 다음에 8을 삽입
v1 <- 1:3
v2 <- 2:4
v1 * v2   #벡터의 각 원소간 곱셈

#예제2
height <- 175   #height 스칼라 생성
heights <- c(160,140,155)   #heights 벡터 생성
heights[c(2,1,2)]    #heights의 2, 1, 2번째 원소 추출
heights <- append(heights, height)    #heights와 height를 결합
heights.1 <- append(heights,180,after=2)   #heights의 2번째 다음에 180 추가
heights <- replace(heights, 2,142)  #heights의 2번째 원소를 142로 변경
heights.2 <- replace(heights,c(2,4),c(140,142)) #2번째 140, 4번째 142로 변경
numbers <- 1:5  #1~5의 값을 갖는 벡터 생성
heights <- heights.2[2:4]  heights.2에서 2~4번째 값까지만 생성
length(heights)    #벡터의 길이 지정

#예제3
x <- c(rep(1,3),seq(1,5,by=2),rev(seq(1,5,length=3)),rep(2,3))
unique(x)  #반복없이 벡터의 원소 표시
sort(x)  #오름차순 정렬
rev(sort(x))   #내림차순 정렬
rank(x)    #자료의 순위를 지정
order(x)    #오름차순에 의한 자료의 위치값


#3.2 행렬(Matrix), 배열(Array)
#행렬(Matrix)
#행렬은 동일한 형으로 구성된 2차원의 데이터 구조
#행의 차원과 열의 차원을 갖는 행렬은 수학에서의 행렬과는 달리 문자형이나 논리형 등을 원소로 사용할 수 있음.
#그러나 행렬의 원소는 한가지 형의 자료만 허락된다.

#행렬의 속성: 벡터의 속성에다가 행과 열의 개수, 이름을 나타내는 dim과 dimnames가 포함
#예제1
matr <- matrix(1:9, nrow=3)                   #3행 3열 행렬 생성
dimnames(matr) <- list(paste("row", c(1:3)), paste("col", c(1:3))) #행과 열의 이름 지점
length(matr)                                   #자료의 개수
mode(matr)                                    #자료의 형태
dim(matr)                                      #행과 열의 개수
dimnames(matr)                                #행과 열의 이름 확인

#기본함수
#행렬(matrix)은 여러 변수들이 이차원적으로 모여 있는 개체로, 
#행렬을 생성하기 위해서는 matrix() 함수를 사용
#matrix() 함수 이외에 cbind(), rbind(), dim() 등을 이용하여 행렬을 생성시킬 수 있음
#예제1
matrix(1:9, nrow=3)                            #nrow  : 행의 개수 지정
matrix(c(1,4,7,2,5,8,3,6,9), byrow=T, ncol=3)  #ncol : 열의 개수 지정 byrow=T : 행 기준 행렬을 생성
r1 <- c(1,4,7)                                 #r1, r2, r3 행 벡터 생성
r2 <- c(2,5,8)
r3 <- c(3,6,9)
rbind(r1, r2, r3)                                #rbind : 행을 기준으로 결합
cbind(r1, r2, r3)                              #cbind : 열을 기준으로 결합

#예제2
m1 <- 1:9
dim(m1) <- c(3,3) 

#관련함수
#행렬과 관련된 여러 함수와 성분의 추출과 삭제 등에 관해 알아봄

#예제1
mat <- matrix(c(1,2,3,4,5,6,7,8,9), ncol=3, byrow=T) #행 기준 3열의 행렬 생성
mat[1,]                                       #행렬 mat의 1행의 값
mat[,3]                                       #행렬 mat의 3열의 값
mat[mat[,3] > 4, 1]                           #3열에서 4보다 큰 행의 값 중 1열의 모든 값
mat[mat[,3] > 4, 2]                           #3열에서 4보다 큰 행의 값 중 2열의 모든 값
mat[2,, drop=F]                               #2행 값만을 추출
is.matrix(mat[2,,drop=F])                       #mat[2,,drop=F]가 행렬인지 확인 
dim(mat)                                      #차수 표시 : 3행 3열
nrow(mat)                                     #행의 개수 표시 : 3행
ncol(mat)                                      #열의 개수 표시 : 3열
y <- diag(1:3)   #diag : 대각행렬을 생성
diag(y)                                        # diag(y) : 대각원소 표현
col(y)                                         #col(y) : 원소들의 열 번호 표현

#예제2
height <- c(140,155,142,175)                  #height 벡터 생성
size.1 <- matrix(c(130,26,110,24,118,25,112,25), ncol=2, byrow=T, dimnames=list(c("Abe", "Bob", "Carol", "Deb"), c("Weight", "Waist")))
size <- cbind(size.1, height) # size.1 행렬과 height 벡터의 열 기준 결합
colmean <- apply(size, 2, mean)              #2열의 평균값을 계산
rowmean <- apply(size, 1, mean)              #1행의 평균값을 계산
colvar <- apply(size, 2, var)                   #2열의 분산값을 계산
rowvar <- apply(size, 1, var)                   #1행의 분산값을 계산
sweep(size, 2, colmean)                       #size 각 열의 값과 colmean의 차.  
# size - matrix(rep(colmean, 4), byrow=T, nrow=4)

sweep(size, 1, rowmean)                       #size 각 행의 값과 rowmean의 차
sweep(size, 1, c(1,2,3,4), "+")                 #size 각 행의 값에 c(1,2,3,4)값을 더해줌
                                        # in case of sweep(, 1,,), to get left operands, 
                                        # we repeat the same value as the referece to the number of columns 
                                        # size  + matrix(rep(c(1,2,3,4), 3), nrow=4)

#행렬 연산
#여러 가지 함수를 이용하여 행렬의 곱셈, 역행렬, 대각행렬, 전치행렬 등의 다양한 연산을 할 수 있음
#예제1
m1 <- matrix(1:4, nrow=2)                     #1~4까지 2행 2열의 행렬 생성
m2 <- matrix(5:8, nrow=2)                     #5~8까지 2행 2열의 행렬 생성
m1*1:2                                        #m1의 1행×1, 2행×2
m1%*%m2                                     #m1과 m2 행렬의 곱셈
solve(m1)                                      #m1행렬의 역 행렬 생성
t(m1)                                          #m1행렬의 전치행렬 생성
vec1 <- as.vector(m1)                         #행렬을 벡터로 변환

#배열(Array)
#배열(Array)은 행렬을 2차원 이상으로 확장시킨 객체
#따라서 2차원의 구조를 갖는 행렬도 배열의 한 종류
#그러나 일반적으로 3차원 이상의 차원을 갖는 데이터 객체를 배열이라고 부름

#배열의 속성 :  행렬의 속성과 같이 자료의 개수를 나타내는 length, 형태를 보여주는 mode, 
#               각 차원의 벡터의 크기를 나타내는 dim 그리고 각 차원의 리스트 이름을 나타내는 dimnames로 구성
#예제1
arr <- array(1:24, c(3,3,2))                    #1~18까지의 자료 생성
dimnames(arr) <- list(paste("row", c(1:3)),paste("col", c(1:3)),paste("ar", c(1:2)))  #각 차원의 이름을 지정
length(arr)                                     #자료의 개수 확인
mode(arr)                                     #자료의 형태 확인
dim(arr)                                       #각 차원 벡터의 크기
dimnames(arr)                                 #각 차원 리스트의 이름

#배열의 생성
#배열을 생성하기 위한 함수로 array() 함수와 dim() 함수가 있음
#예제1
array(1:6)                                      #1~6의 자료로 1차원 배열 생성
array(1:6, c(2,3))                              #1~6의 자료로 2차원 배열 생성
array(1:8, c(2,2,2))                             #1~8의 자료로 3차원 배열 생성
arr <- c(1:24)                                 #1~24의 자료 생성
dim(arr) <- c(3,4,2)                           #dim() 함수를 이용하여 3행 4열의 행렬 2개 생성

#배열의 연산
#예제1
ary1 <- array(1:8, dim = c(2,2,2))  
ary2 <- array(8:1, dim = c(2,2,2))
ary1 + ary2                                    #자료의 덧셈
ary1 * ary2                                    #자료의 곱셈
ary1 %*% ary2                                #두 배열 원소들의 곱의 합
sum(ary1 * ary2)                             # ary1 %*% ary2 와 같은 결과를 냄

#배열원소의 추출 및 삭제
#예제1
ary1[,,1]
ary1[1,1,]
ary1[1,,-2]

#3.3 List, Data Frame
#List(리스트)
#리스트(List)는 서로 다른 형태(mode)의 자료를 포함하는 하나의 객체
#리스트를 생성하는 함수는 list()
#예제1
li <- list("top", c(2,4,6),c(T,F,T))              #list(문자, 숫자, 논리형 객체) 
li[[1]]                                        #[[1]]:첫 번째 성분
#예제2
mat1 <- matrix(1:4, nrow=2)
list1 <- list("A", 1:8, mat1)
#예제3
son <- list(son.name = c("Minsu", "Minchul"), son.cnt = 2, son.age = c(2.6))

#리스트 속성 : 벡터의 속성과 같이 자료의 개수, 형태, 구성요소의 이름 등을 보여주는 length, mode, names로 구성
#예제1
a <- 1:10
b <- 11:15
klist <- list(vec1=a, vec2=b, descrip="example")
length(klist)                                   #klist 리스트 자료의 개수
mode(klist)                                    #klist 리스트 자료의 형태
names(klist)                                   #klist 리스트 각 구성요소의 이름

#리스트 생성 및 다양한 변화
#리스트에서의 성분을 추출하는 방법은 [[]] 를 사용
#성분의 이름을 지정하였다면 $ 연산자를 사용
#성분의 원소를 추출하고자 하는 경우에는 [] 연산자를 사용
#리스트에서 성분과 성분의 원소를 추가 또는 삭제할 수도 있음
#예제1(생성)
exm <- list(c("Abe", "Bob", "Carol", "Deb"),c("Weight","Waist")) #exm의 이름으로 list생성
exm[[2]]                                      #리스트의 2번째 성분
exm[[2]][2]                                  #2번째 성분 2번째 원소
names(exm) <- c("Rows","Columns")           #exm 리스트에 성분 이름 부여
exm$Rows                                    #exm의 Rows 성분만 표현
exm$Rows[2]                                 #Rows 성분 2번째 원소 표현
exm$Columns                                 #exm의 Columns 성분만 표현

#예제2(추가 및 삭제)
list1 <- list("A", 1:8)                         #list1 리스트 생성
list1[[3]] <- list(c(T, F))                      #세 번째 성분을 추가
list1[[2]][9] <- 9                             #두 번째 성분에 원소 추가
ist1[3] <- NULL                             #세 번째 성분 삭제
list1[[2]] <- list1[[2]][-9]                   #두 번째 성분의 9번째 원소 삭제

#관련함수
#리스트는 성분에 리스트와 벡터 등을 사용할 수 있음
#예제1
a <- 1:10
b <- 11:15                                    #벡터 a, b 생성
klist <- list(vec1=a, vec2=b, descrip="example")
klist[[2]][5]                                  #두 번째 성분 vec2의 5번째 원소
klist$vec2[c(2,3)]                             #vec2의 2, 3번째 원소

#data.frame(데이터프레임)
#데이터 프레임은 행렬과 비슷한 형태로 되어 있으나, 
#행렬은 차원으로 표시되며 같은 형태(mode)의 객체를 가지는 반면, 
#데이터 프레임은 각 열(column)들이 서로 다른 형태(mode)의 객체를 가질 수 있으므로 
#범주형 변수를 가질 수도 있기 때문에 범주형 자료분석에도 유용하게 사용

#데이터프레임 생성
#read.table()
#예제1
test1 <- read.table("c:\\Rproject\\EXAM\\story.txt")
test2 <- read.table("c:\\Rproject\\EXAM\\story.txt",row.names = 'no', header = T) #첫번째행을 컬럼명으로 정의
#read.table() 함수의 인수 중에서 row.names = 'no' 는 행 이름임을 알려주며, header = T 는 첫 번째 줄이 헤드라인임을 알려줌

#data.frame() : 이미 생성되어 있는 벡터들을 결합하여 데이터 프레임을 생성
#예제1
char1 <- rep(LETTERS[1:3],c(2,2,1))          #벡터 char1
num1 <- rep(1:3,c(2,2,1))                     #벡터 num1
test1 <- data.frame(char1, num1)              #test1 데이터 프레임 생성

#as.data.frame() :모든 다른 종류의 자료객체들을 데이터 프레임으로 변환
#예제1
a1 <- c("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o")
dim(a1) <- c(5,3)
test3 <- as.data.frame(a1)                     #a1을 데이터 프레임으로 변환

#데이터 프레임 합치기
#예제1
cbind(test1,test3)                            #test1과 test2를 옆으로 합친 형태
#예제2
char1 <- rep(LETTERS[1:3],c(1,2,2))
num1 <- rep(1:3,c(1,1,3))
test4 <- data.frame(char1, num1)
rbind(test1, test4)                          #아래로 합친 형태  
#예제3
merge(test1, test4)                          #test1, test4를 병합한 형태

#행 자료 및 변수의 추가/삭제
#예제1
test5 <- cbind(test1, married = c(T, T, T, F, F, T))  #test1 데이터 프레임에 변수 married 추가
test6 <- test5[-2,]                            #두번째 행 삭제
est7 <- test5[,-4]                            #네 번째 변수 삭제

#1일차 교육이 끝났습니다. 수고하셨습니다.
#----------------------------


#-2일차 실습: 1. 연산자 및 기본적인 R 함수-----------
#1.1 연산자
#산술연산자(사칙연산)
1+2 
x<-3
y<-2
x+y
x-y
x*y
x/y

a<-c(1,2)
b<-c(3,4)
a+b #벡터 변수의 덧셈
a-b #벡터 변수의 뺄셈
a*b #벡터 변수의 곱셈
a/b #벡터 변수의 나눗셈

A<-matrix(c(5,10,2,1), ncol=2)
B<-matrix(c(3,4,5,6), ncol=2)
A+B #행렬변수의 덧셈
A-B #행렬변수의 뺄셈
A*B #행렬변수의 곱셈
A/B #행렬변수의 나눗셈

2^2 #일반적인 숫자의 제곱(2의 2제곱)
x<-4
y<-3
x^y #값을 변수에 할당한 후에 제곱(4의 세제곱)
a<-c(4,5)
b<-c(2,3)
a^b #벡터변수의 제곱(구성 요소들간의 제곱, 4^2, 5^3)
A<-matrix(c(5,10,2,1), ncol=2)
B<-matrix(c(2,2,2,2), ncol=2)
A^B #행렬변수의 제곱(각 구성 요소들간의 제곱)

#%/% : 나눗셈에서 몫만 출력함
4%/%2 
x<-3
y<-2
x%/%y #실제 값이 1.5이지만 정수부분인 1만 출력

a<-c(7,2)
b<-c(3,4)
a%/%b #벡터 변수의 정수나눗셈

A<-matrix(c(5,10,2,1), ncol=2)
B<-matrix(c(3,4,5,6), ncol=2)
A%/%B #행렬변수의 정수나눗셈

#행렬의 곱
A<-matrix(c(5,10,2,1), ncol=2)
B<-matrix(c(3,4,5,6), ncol=2)
#(5*3) + (2*4) ; (5*5) + (2*6) ; (10*3) + (1*4) ; (10*5) + (1*6)
A%*%B

#산술연산자(비교연산)
# '==' 비교되는 두 항이 같은지를 비교함. 같을 경우 True, 다를 경우 False
1==2
x<-2
y<-3
x==y

# '!=' 비교되는 두 항이 다른지를 비교함. 같을 경우 False, 다를 경우 True
1!=2
x<-2
y<-3
x!=y

# '<=' 왼쪽 항이 오른쪽 항보다 작거나 같음을 비교함. 작거나 같으면 True, 크면 False
1<=2
x<-2
y<-2
x<=y

# '<' 왼쪽 항이 오른쪽 항보다 작음을 비교함. 작으면 True, 크면 False
1<2

# '>' 왼쪽 항이 오른쪽 항보다 큼을 비교함. 크면 True, 작으면 False
1>2

# '>=' 왼쪽 항이 오른쪽 항보다 크거나 같음을 비교함. 크거나 같으면 True, 작으면 False
1>=2

#산술연산자(논리연산)
# && : 일반적인 and 논리 연산자
2==2 && 3>4
3==3 && 3>2

# & : 벡터에서의 and 논리 연산자
2==2 && c(2==2, 3>4) #벡터에서 && 연산자를 사용해도 결과는 나오지만 틀린 결과가 출력된다.
2==2 & c(2==2, 3>4)

# || : 일반적인 or 논리 연산자
2==2 || 3>4

# | : 벡터에서의 or 논리 연산자
2!=2 || c(2==2, 3>4) #벡터에서 || 연산자를 사용해도 결과는 나오지만 틀린 결과가 출력된다.
2!=2 | c(2==2, 3>4)

# ! : not 연산자
!TRUE

#1.2 기본적인 R 함수
#만약 R기본적인 함수가 없다면 R언어는 매우 어려운 프로그램이 될 것이다. 
#sin()함수를 예로 들어보면 이 함수가 만들어져 있지 않다면 R사용자들은 sin함수를 만들어서 그 값을 구해야 할 것이다. 
#하지만 이미 R 개발자들이 자주 사용하는 함수를 이미 만들었기 때문에 우리는 그것을 사용하기만 하면 된다. 
#그러므로 우리는 가능한 많은 기본적인 함수를 알아둘 필요가 있다.

#1.2.1 수치함수
pi
options(digits=20) : 소수점 20리에서 반올림
pi

#log(x) : 자연로그 함수
log(2)

#log10(x): 상용 로그 함수
log10(10)

#exp(x): 지수 로그 함수
exp(10)

#sqrt(x) : 루트함수
sqrt(10)

#sin(x): sin 함수
sin(10)

#cos(x): cosine 함수
cos(10)

#tan(x): tangent 함수
tan(10)

#asin(x) : arcsin 함수
asin(1)

#acos(x): arc cosine 함수
acos(0)

#atan(x):arc tangent 함수
atan(0.6)

#min(x) :벡터에서 최소값
min(c(1:10))

#max(x): 벡터에서 최대값
max(c(1:10))

#min(x1, x2,…) : 전체 벡터 중에서 최소값
x1<-c(1,2,-3,4)
x2<-c(2,4,-6,7)
min(x1, x2)

#range(x): 벡터의 범위 => c(min(x), max(x))와 유사
x<-c(1,2,-3,4)
range(x)
c(min(x), max(x))

#pmin(x1,x2) : 벡터들의 대칭되는 원소들 사이의 최소값 
x1<-c(1,2,-3,4)
x2<-c(2,4,-6,7)
pmin(x1,x2)

#pmax(x1,x2) : 벡터들의 대칭되는 원소들 사이의 최대값
pmax(x1,x2)

#1.2.2 통계함수
#mean(x1): 평균
x1<-c(1,2,3,4,5,6)
mean(x1)

#sd(x1): 표준 편차
sd(x1)

#var(x1): 분산
var(x1)

#median(x1): 중앙값
median(x1)

#quantile(x,p): (100*p)%에 해당하는 값
quantile(x1, 0.5)

#cor(x,y) : 상관 계수
x<-c(1,2,3,4,5,6,7,8,9,10)
y<-c(10,9,8,7,6,5,4,3,2,5)
cor(x, y)

#----------------------------------------



#-2일차 실습: 2. 그래프-----------
#그래프는 데이터를 시각적으로 보여주는데 중요한 역할을 한다. 
#R프로그램에서 그래프 함수를 잘 활용하면 데이터를 보다 명료하고 해석이 용이하게 할 수 있다.

#2.1 기본적인 그래프 함수
#Plot() 함수
#plot(x,y,main=,sub=,xlab =, ylab=, type=,axes=“”,col=“”,pch=“”)
# x : X축의 자료, y: Y축의 자료
#main : plot의 전체 제목
#sub : plot의 부 제목
#xlab : x축 제목, ylab: y축의 제목.
#type : plot의 형태를 결정.
#type의 종류
#           "p" : 점
#           "l" : 선
#           "b" : 점과 선  ⇒ "c" : “b"에서 점 제외.
#           "o" : 점을 선이 통과
#           "h" : 수직선으로 된 “histogram"
#           "s" : 계단형 그래프
#           "S" : 다른 계단형 그래프
#           "n" : 그래프 없음
#axes : plot의 테두리 관련
#col : plot의 색

x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
y<-c(1,2,3,4,5,6,7,8,9,10,11,12)
plot(x, y, main="PLOT", sub="Test", xlab="number", ylab="value") 

plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="p") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="l") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="b") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="c") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="o") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="h") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="s") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="S") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="n") 

#points() 함수
#points(x, y, pch= , cex= )
#pch=" " : " " 안에 내용이 바로 출력
#pch=숫자 : 숫자에 해당되는 형태 출력
#cex=숫자 : 숫자가 클수록 큰 점이 출력
x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
y<-c(1,2,3,4,5,6,7,8,9,10,11,12)
z<-c(3.5, 2.2, 1.5, 4.6, 6.9)
a<-c(1,9,13) 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="n") 
points(z, pch=1, cex=1)
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="n") 
points(z, pch=3, cex=1)
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="n") 
points(z, pch=5, cex=1)
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="n") 
points(z, pch=7, cex=1)
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="n") 
points(z, pch=9, cex=1)
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="n") 
points(z, pch=11, cex=1)
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="n") 
points(z, pch=13, cex=1)
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="n") 
points(z, pch=15, cex=1)
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="n") 
points(z, pch=17, cex=1)
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="n") 
points(z, pch=19, cex=1)

#lines() 함수 선을 그리는 함수
#lines(x, lty=, col=, pch= , lwd= )
#lwd = 숫자 : 숫자가 클수록 굵은 선이 출력
plot(0:6,0:6,type="n", ylim=c(0,20)) 
lines(c(1,3),c(20,20), lty=1)
lines(c(1,3),c(19,19), lty=2)
lines(c(1,3),c(18,18), lty=3)
lines(c(1,3),c(17,17), lty=4)
lines(c(1,3),c(16,16), lty=5)
lines(c(1,3),c(15,15), lty=6)
lines(c(1,3),c(14,14), lty="blank")
lines(c(1,3),c(13,13), lty="solid")
lines(c(1,3),c(12,12), lty="dashed")
lines(c(1,3),c(11,11), lty="dotted")
lines(c(1,3),c(10,10), lty="dotdash")
lines(c(1,3),c(9,9), lty="longdash")
lines(c(1,3),c(8,8), lty="twodash")
lines(c(1,3),c(7,7), lty="33")
lines(c(1,3),c(6,6), lty="24")
lines(c(1,3),c(5,5), lty="F2")
lines(c(1,3),c(4,4), lty="2F")
lines(c(1,3),c(3,3), lty="3313")
lines(c(1,3),c(2,2), lty="F252")
lines(c(1,3),c(1,1), lty="FF29")

#2.2 Plot 그릴 때 유용한 함수
#par() 함수
#그림을 조절하거나 그림창의 특성을 지정하기 위해서 사용
#선의 굵기와 종류, 문자의 크기와 글꼴, 색깔도 지정 가능
#그림의 위치 지정 가능
#한 plot을 여러 창으로 나눌 때 사용
x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
y<-c(1,2,3,4,5,6,7,8,9,10,11,12)
par(mfrow=c(2,5)) #2행 5열의 그래프를 그릴 수 있음
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="p") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="l") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="b") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="c") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="o") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="h") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="s") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="S") 
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="n")

x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
y<-c(1,2,3,4,5,6,7,8,9,10,11,12)
par(mfrow = c(1,1), bg="orange") #백그라운드색을 오랜지색으로 정의
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="p") 

#text() 함수 : 그래프 안에 글자를 넣는다.
par(mfrow = c(1,1), bg = "white")
x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
y<-c(1,2,3,4,5,6,7,8,9,10,11,12)
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="p") 
text(3,5,"Plotting",col="red") #(3, 5)지점에 "Plotting" 이라는 글자를 넣는다.

#abline() 함수 : 그래프 안에 새로운 수직선을 넣는다.
x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
y<-c(1,2,3,4,5,6,7,8,9,10,11,12)
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="p") 
abline(h=3, v=4, lty=3) #x축 4, y축 3을 통과하는 수직선이 그려진다.

#axis() 함수 : 그래프 상,하,좌,우 축을 넣는다.
x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
y<-c(1,2,3,4,5,6,7,8,9,10,11,12)
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="n") 
points(x,y,col="red")
abline(h=3, v=4, lty=3)
axis(2, at = 3, label="3") #왼쪽 축에 3을 출력한다.
text(4.5, 3.5, "(4, 3)", col="blue") #(4, 3)을 화면에 출력한다.

#legend() 함수 : 범례를 그래프 안에 넣어주는 함수
x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
y<-c(1,2,3,4,5,6,7,8,9,10,11,12)
plot(x, y, type='n')
legend("bottomright", "(x,y)", pch=1, title="bottomright")
legend("bottom", "(x,y)", pch=1, title="bottom")
legend("bottomleft", "(x,y)", pch=1, title="bottomleft")
legend("left", "(x,y)", pch=1, title="left")
legend("topleft", "(x,y)", pch=1, title="topleft, inset = .05", inset = .05)
legend("top", "(x,y)", pch=1, title="top")
legend("topright", "(x,y)", pch=1, title="topright, inset = .02", inset = .02)
legend("right", "(x,y)", pch=1, title="right")
legend("center", "(x,y)", pch=1, title="center")
legend(8,4,"Legend(범례)")  #(8, 3) 지점에 범례를 위치시킨다.

x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
y<-c(1,2,3,4,5,6,7,8,9,10,11,12)
plot(x, y, type='n')
legend(locator(1),"Legend(범례)") #locator(1) : 마우스로 그래프 위에 원하는 곳에 찍으면 그곳에 범례가 출력됨.

#box() 함수 : 그래프 안과 밖에 박스를 그리는 함수.
op <- par(mar=c(4,4,4,4), oma=c(4,4,4,4))
x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
y<-c(1,2,3,4,5,6,7,8,9,10,11,12)
plot(x, y, type="p",axes=F)
s<-c("outer", "inner", "plot", "figure") #outer:그래픽상자의 바깥쪽, inner:outer 주변의 안쪽, plot:plot 영역의 테두리 figure:figure 영역의 테두리
box(which=s[1], lty=1)
box(which=s[2], lty=2)
box(which=s[3], lty=3)
box(which=s[4], lty=4)
par(op)

#curve() 함수 곡선 그리기 함수
x<- rnorm(100, mean=5, sd=1) #평균이 5이고 표준편차가 1인 정규분포에서 100의 샘플을 생성
hist(x) 
hist(x, freq=F) #freq=F : 빈도가 아닌 밀도로 표시
curve(dnorm(x, mean=5, sd=1), add=T) #평균이 5이고 표준편차가 1인 정규분포의 밀도 함수 곡선을 그린다. add=T : 겹쳐 그림.

#layout() 함수
x <- pmin(3, pmax(-3, rnorm(50)))
y <- pmin(3, pmax(-3, rnorm(50)))
xhist <- hist(x, breaks=seq(-3,3,0.5), plot=FALSE)
yhist <- hist(y, breaks=seq(-3,3,0.5), plot=FALSE)
top <- max(c(xhist$counts, yhist$counts))
xrange <- c(-3,3)
yrange <- c(-3,3)
nf <- layout(matrix(c(2,0,1,3),2,2,byrow=TRUE), c(3,1), c(1,3), TRUE)
layout.show(nf)

par(mar=c(3,3,1,1))
plot(x, y, xlim=xrange, ylim=yrange, xlab="", ylab="")
par(mar=c(0,3,1,1))
barplot(xhist$counts, axes=FALSE, ylim=c(0, top), space=0)
par(mar=c(3,0,1,1))
barplot(yhist$counts, axes=FALSE, xlim=c(0, top), space=0, horiz=TRUE)

#pairs()함수: 많은 변수들의 그래프를 한 화면에 출력한다.
x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
y<-c(1,2,3,4,5,6,7,8,9,10,11,12)
a<-data.frame(x,y)
pairs(a) 

#box plot(상자그림)
par(mfrow = c(1,1))
x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
z<-c(3.5, 2.2, 1.5, 4.6, 6.9)
boxplot(x,z)

#파이차트
x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
pie(x)

#Bar plot
x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
barplot(x)

#히스토그램 : hist(x, freq=) freq=T : 빈도 출력(기본 값) , freq=F : 밀도 출력
x<-c(2,5,8,5,7,10,11,3,4,7,12,15)
hist(x)

#---------------------


#-2일차 실습: 3. 함수 생성-----------
#많은 함수들이 R에서 제공되지만 우리가 필요로하는 상황에 맞는 함수를 찾지 못할 수도 있다. 
#이런 경우 앞으로 배울 제어구문과 함수의 구조를 익혀서 직접 함수를 만들어서 활용해야 한다

#3.1 제어구문
#조건문
#특정한 조건을 만족했을 경우에만 프로그램 코드를 수행하는 제어 구문
#항상 논리 연산이 수반 된다

#if(조건) 실행문
#예제1
x <- c(1,2,3,4)
y <- c(2,1,4,5)
if(sum(x) < sum(y)) print(x) #x의 합이 y의 합보다 작을 경우 실행

#예제2
x <- c(1,2,3,4)
y <- c(2,1,4,5)
if(sum(x) < sum(y)) {
   print(mean(x))
   print(var(x))
}

#if(조건) 조건이 참일 때 실행문 else 조건이 참이 아닐 때 실행문
#괄호안의 조건이 참이면 참일때의 실행문을 수행하고 거짓일 때는 참이 아닐때의 실행문을 수행하는 표현식
x <- c(1,2,3,4)
y <- c(2,1,4,5)
if(mean(x)>mean(y)) print("Mean(x)>Mean(y)") else print("Mean(x)<Mean(y)")

#중첩 조건문 : 조건문 안에 조건문이 있는 표현식
x <- c(1,2,3,4)
y <- c(2,1,4,5)
if(length(x)==5) {
  if(sum(x) == 10) print("length=5, sum=10")
} else {
  print("length=4, sum=10")
}

#ifelse(조건, 조건이 참일때의 실행문, 조건이 참이 아닐때의 실행문)
#예제1
x <- c(1,2,3,4)
y <- c(2,1,4,5)
ifelse(x<y, x, y)

#예제2
x <- c(1,2,3,4)
y <- c(2,1,4,5)
ifelse(sum(x-y) > 0, "positive", ifelse(sum(x-y) < 0 , "negative", "zero"))

#switch(인수, 표현식1, 표현식2, ....)
#예제1 :인수의 결과값이 문자열을 가질 때
#type이라는 문자열 인수값(var)에 해당하는 인수(var)를 찾아서 인수값(var(x))을 실행
x <- c(1,2,3,4)
type<-"var"
switch(type, mean=mean(x), median=median(x), sum=sum(x), var=var(x))

#예제2 : 인수의 결과값이 1보다 큰 정수 값을 가질 때
#정수 값에 해당하는 순서의 표현식을 실행한다. 정수값이 1이므로 첫 번째표현식(mean(x))을 실행한다.
x <- c(1,2,3,4)
switch(1, mean(x), median(x), sum(x), var(x))


#반복문
#유사한 패턴을 갖는 작업을 여러번 반복해서 수행하는 제어 구문
#for(변수 in 반복횟수) 실행문 : 실행문을 반복횟수만큼 실행

#예제1
#변수 i가 1에서 5까지의 값을 갖을 때까지 print(rep(i,i))라는 실행문을 실행한다. 
#i=1이면 print(rep(1,1))을 실행하고 i=2이면 print(rep(2,2))을 실행한다. 이렇게 i=5일때까지 실행을 하게된다.
for(i in 1:5) print(rep(i,i))

#예제2 : 1부터 10까지 합 구하기
sum.x<-0
for(i in 1:10)
 sum.x<-sum.x + i
sum.x

#while(조건) 실행문 : 조건이 참일 때까지 실행문을 수행
#예제1
a<-1
while(a<=5) {
   print(rep(a,a)) 
   a<-a+1
}

#예제2 : 1부터 10까지 합 구하기
a<-1
sum.a<-0
while(a <= 10) {
   sum.a<-sum.a + a
   a<-a+1
}
sum.a

#repeat 실행문 : 실행문을 계속 수행하다 실행문에서 break문을 만나서 반복수행을 그만둔다
#예제1
a<-1
repeat {
  if(a > 5) break
   print(rep(a,a)) 
   a<-a+1
}  

#예제2 : 1부터 10까지 합 구하기
a<-1
sum.a<-0
repeat {
   if(a > 10) break 
   sum.a<-sum.a + a
   a<-a+1
}
sum.a

#중첩 루프 : 반복문 안에 반복문이 있는 구문
#예제1 : 구구단 만들기
gugu<-matrix(0, ncol=9, nrow=9)
for(i in 1:9) {
 for(j in 1:9) {
 gugu[i,j]<-i*j
 }
}
gugu


#3.2 함수만들기
#함수의 정의 : 함수(function)란 특정한 작업을 독립적으로 수행하는 프로그램 코드의 집합체로서 R객체의 한 종류이다. 
#이전 장에서 알아봤던 R의 내장 함수와 같은 것이다

#함수 사용의 이점
#1) 커다란 프로그램을 작업 단위 별로 분할하여 작성할 수 있다.
#2) 동일한 프로그램 코드를 매번 기입하는 수고를 덜어 준다.
#3) 프로그램을 체계적으로 작성할 수 있어 유지 보수가 용이하다.
#4) 간결한 프로그램을 제작할 수 있어 이해가 수월하다.

#함수의 구조
#함수이름 <- function(인수) {함수의 몸체}
#function : 함수를 정의하는데 사용하는 예약어이다.
#인수 : 함수가 사용할 인수들.
#함수의 몸체 : 함수가 호출되면 실행하게 될 프로그램 코드들의 집합.
#함수이름 : 정의된 함수를 할당하므로 생성되는 객체이름.

#함수생성 방법
#1) R 콘솔에서 직접 입력.
d.mean<-function(data) {sum(data) / length(data)}
x<-rnorm(100, mean=4, sd=1)
d.mean(x)

#2) fix 함수를 이용 : fix(생성할 함수 이름)
fix(d.var) #함수생성 창이 호출된다. 호출되어진 창에 아래의 로직을 입력하면 d.var이라는 함수명으로 생성됨.

function (data) 
{
  data.var <- sum((data - d.mean(data))^2) / (length(data)-1)
  return(data.var)
}

#edit함수를 사용하여 함수를 수정할 수 있음
edit(d.var)

#3) 외부파일에 정의한 함수를 저장하고 필요할 때 source 함수를 이용하여 읽어들이거나 
#파일메뉴에서 R코드의 소스에서 외부에 저장한 파일을 열어서 함수를 생성
source("C:\\Rproject\\RSC\\d.range.txt")

#2일차 교육이 끝났습니다. 수고하셨습니다.
#------------------------


#-3일차 실습: 1. Tip-----------

#7.1 R 코드작성 팁
#R코드를 작성하는데 있어서 동일한 결과를 다양한 방법으로 도출해 낼수 있음.
#아래의 방법뿐만 아니라 다양한 방법이 존재함으로써 사용자는 많은 실습을 통하여 자신만의 최적의 R 코드 작성을 스킬을 숙지할 필요가 있음

#7.1.1데이터 추출
Sample.df <- data.frame(AA = rep(letters[1:5],10), BB = sample(60:70, 50, replace = T), stringsAsFactors = FALSE)

#AA컬럼의 값중에서 a인 값만 추출
#Type1
Sample.df[Sample.df$AA == "a",] 

#Type2
subset(Sample.df, AA == "a") 

#Type3
for(i in 1:nrow(Sample.df)) 
{
  if(Sample.df[i,"AA"] == "a")
  {
    if(i == 1)
    {
      Select.df <- Sample.df[i,]
    }else{
      Select.df <- rbind(Select.df, Sample.df[i,])
    }
  }
}

#AA컬럼의 값중에서 a 와 b의 값만 추출
#Type1
Sample.df[Sample.df$AA %in% c("a","b"),]

#Type2
subset(Sample.df, AA %in% c("a","b"))

#7.1.2 컬럼 생성
#CC컬럼을 생성시 AA컬럼의 값이 a이면 1, b이면 2 그렇지 않은면 3의 값을 생성
#Type1
Sample.df[Sample.df$AA == "a", "CC"] <- 1 
Sample.df[Sample.df$AA == "b", "CC"] <- 2 
Sample.df[!(Sample.df$AA %in% c("a","b")), "CC"] <- 3 

#Type2
Sample.df$CC1 <- ifelse(Sample.df$AA == "a", 1, ifelse(Sample.df$AA == "b",2,3))

#Type3
for(i in 1:nrow(Sample.df))
{
  if(Sample.df$AA[i] %in% c("a","b"))
  {
    if(Sample.df$AA[i] == "a")
    {
      Sample.df$CC2[i] <- 1
    }else{
      Sample.df$CC2[i] <- 2
    }
  }else{
    Sample.df$CC2[i] <- 3 
  }
}

#7.1.3 필요한 컬럼 Select
Sample.df1 <- Sample.df
#Type1
Sample.df1[,c("AA","BB","CC")]

#Type2
Sample.df1[,c(1,2,3)]

#Type3
Sample.df1[,c(-4,-5)]

#Type4
subset(Sample.df1,select = c("AA","BB","CC"))

#Type5
subset(Sample.df1,select = c(AA, BB, CC))

#Type6
subset(Sample.df1,select = c(-CC1,-CC2))

#7.1.4 for문을 활용한 여러개의 csv File을 호출
#csv File을 R에 호출할때 사용하는 함수는 read.csv() 이다.
#만약 호출하려고 하는 데이터가 여러개(수십 수백개)일때 R코드는 수십줄 수백개줄이 소요된다.
#다음과 같은 방식을 사용하면 여러개의 데이터를 쉽게 R로 호출할 수 있을것이다.

#기본방법
import_csv_1_df <- read.csv(paste(file.dir, "Link_A000001_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_2_df <- read.csv(paste(file.dir, "Link_A000002_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_3_df <- read.csv(paste(file.dir, "Link_A000003_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_4_df <- read.csv(paste(file.dir, "Link_A000004_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_5_df <- read.csv(paste(file.dir, "Link_A000005_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_6_df <- read.csv(paste(file.dir, "Link_A000006_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_7_df <- read.csv(paste(file.dir, "Link_A000007_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_8_df <- read.csv(paste(file.dir, "Link_A000008_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_9_df <- read.csv(paste(file.dir, "Link_A000009_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_10_df <- read.csv(paste(file.dir, "Link_A000010_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_11_df <- read.csv(paste(file.dir, "Link_A000011_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_12_df <- read.csv(paste(file.dir, "Link_A000012_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_13_df <- read.csv(paste(file.dir, "Link_A000013_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_14_df <- read.csv(paste(file.dir, "Link_A000014_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_15_df <- read.csv(paste(file.dir, "Link_A000015_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_16_df <- read.csv(paste(file.dir, "Link_A000016_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_17_df <- read.csv(paste(file.dir, "Link_A000017_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_18_df <- read.csv(paste(file.dir, "Link_A000018_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_19_df <- read.csv(paste(file.dir, "Link_A000019_df.csv", sep = ""),stringsAsFactor = FALSE)
import_csv_20_df <- read.csv(paste(file.dir, "Link_A000020_df.csv", sep = ""),stringsAsFactor = FALSE)

#수정방법
# 1) 자료불러오기
# 1.1) CSV File 불러오기
# 자료를 불러오기 위하여 디렉토리와 File이름을 정의한다. 
file.dir <- "C:\\Rproject\\EXAM1\\"

# 불러들일 자료는 속도와 교통량이 들어있는 20개의 파일임.
file.name <- shell(paste("dir ", file.dir, "*.CSV /b /w /a-d", sep = ""), intern = TRUE)

for(file.i in 1:length(file.name))
{
  temp.df <- read.csv(paste(file.dir, file.name[file.i], sep = ""),stringsAsFactor = FALSE)
  names(temp.df) <- c("LINK_ID","TIME","SPEED","VOLUMN")
  cat(file.i, "/", length(file.name), "[ N :", nrow(temp.df), "]", "\n")
  assign(paste("import_csv", file.i, "df", sep = "_"), temp.df)
}
#임시파일 삭제
rm(temp.df, file.i)
ls()

#7.1.5 for문을 활용한 여러개의 데이터 하나의 데이터로 합치기
#호출되어진 20개의 파일을 Total_Csv_Speed 이름을 생성
#기존방법
Total_Csv_Speed <- rbind(import_csv_1_df,import_csv_2_df,import_csv_3_df,import_csv_4_df,import_csv_5_df
                         ,import_csv_6_df,import_csv_7_df,import_csv_8_df,import_csv_9_df,import_csv_10_df
                         ,import_csv_11_df,import_csv_12_df,import_csv_13_df,import_csv_14_df,import_csv_15_df
                         ,import_csv_16_df,import_csv_17_df,import_csv_18_df,import_csv_19_df,import_csv_20_df)

#수정방법
import_csv_names <- apropos("import_csv_")

for(i in 1:length(import_csv_names))
{
  if(i == 1)
  {
    Total_Csv_Speed <- get(import_csv_names[i], pos = 1)
  }
  else
  {
    temp.df <- get(import_csv_names[i], pos = 1)
    Total_Csv_Speed <- rbind(Total_Csv_Speed, temp.df)
  }
}

#임시파일 삭제
rm(temp.df, i)

#7.1.6 디렉토리 생성
# 저장위치는 C:\\Rproject\\OUT\\Result로 하는데, 
# 만약 폴더가 없다면 저장할 때 오류가 생기므로 폴더가 없다면 
# DOS 명령어를 이용하여 디렉토리를 생성한다.
dir.name <- shell("dir c:\\Rproject\\OUT /ad /b /w ", intern = TRUE)
if(sum(dir.name %in% "Result") == 0) {
  cat("Result 디렉토리 만들기", "\n")
  shell(paste("mkdir ", "c:\\Rproject\\OUT\\Result", sep = ""))
}


#7.2 sqldf()함수를 활용한 데이터 핸들링
#R프로그래밍이 익숙하지 않은 사용자가 sql문은 능숙할때 사용할수 있다.
#R에서는 sqldf Package를 통하여 sql문으로 R에서 데이터 핸들링을 할수 있는 기능을 제공함.
#sqldf에서는 변수명에 "."를 사용할 수 없음

library(sqldf) #sqldf Package 호출
summary(Total_Csv_Speed)

#예제1 LINK_ID별 평균속도 생성
query.x <- "select LINK_ID, avg(SPEED) as MEAN_SPEED from Total_Csv_Speed group by LINK_ID"
Summary_df <- sqldf(query.x)
head(Summary_df)

#예제2 Total_Csv_Speed 와 Summary_df 결합
query.y <- "select A.*, B.MEAN_SPEED from Total_Csv_Speed as A, Summary_df as B where A.LINK_ID = B.LINK_ID"
Merge_df <- sqldf(query.y)
head(Merge_df)


#7.3 연산속도
#R 코드를 어떻게 작성하느냐에 따라 연산속도는 확연이 차이가 난다.
#지금도 R의 연산속도를 높이기 위하여 다양한 Package가 나오고 있다.
#이번 마지막 챕터에서는 동일한 결과를 출력할때 다양한 방법으로 사용하여 어떠한 방식으로 사용하여야 
#오랜 시간을 소요하지 않고 결과를 낼수 있는 방법에 대하여 알아보기로 한다.
#아래의 예제는 몇가지의 방법에 대해서만 소개하고 있으며 이밖에도 더많은 방법이 있다.

#Test1 #AA컬럼값과 BB컬럼값의 합을 구함
#방법1
sample.df1 <- data.frame(AA = c(50000:1), BB = c(1:50000))

system.time(for(i in 1:nrow(sample.df1))
{
  sample.df1$RESULT[i] <- sample.df1$AA[i] + sample.df1$BB[i] 
})
#사용자  시스템 elapsed 
#25.9     0.0    25.9

#방법2
sample.df2 <- data.frame(AA = c(50000:1), BB = c(1:50000))
system.time(sample.df2$RESULT <- sample.df2$AA + sample.df2$BB)
#사용자  시스템 elapsed 
#0       0       0 

#방법3
sample.df3 <- data.frame(AA = c(50000:1), BB = c(1:50000))
system.time(sample.df3$RESULT <- apply(sample.df3, 1, sum))
#사용자  시스템 elapsed 
#0.15    0.00    0.16

#방법4
sample.df4 <- data.frame(AA = c(50000:1), BB = c(1:50000))
sample.df4$RESULT <- NULL
system.time(for(i in 1:nrow(sample.df1))
{
  sample.df4$RESULT[i] <- sample.df4$AA[i] + sample.df4$BB[i] 
})
#사용자  시스템 elapsed 
#21.42    0.00   21.43


#Test2
#방법1
system.time(for(i in 1:10000)
{
  if(i == 1)
  {
    result.x <- sample.df[i,]
  }
  else
  {
    result.x <- rbind(result.x, sample.df[i, ])
  }
})
#사용자  시스템 elapsed 
#10.1     0.0    10.1 

#방법2
result.y <- data.frame(AA = numeric(), BB = numeric(), RESULT = numeric())
system.time(for(i in 1:10000)
{
  result.y[i, ] <- sample.df[i,]
})
#사용자  시스템 elapsed 
#6.48    0.00    6.48 

#방법3
result.list <- list()
system.time(for(i in 1:10000)
{
  result.list[[i]] <- sample.df[i,]
})
system.time(result.z <- do.call(rbind, result.list))
#사용자  시스템 elapsed 
#1.23    0.00    1.23
#사용자  시스템 elapsed 
#1.41    0.00    1.40

#test3 data.frame, data.table 비교
#data.frame
result.list <- list()
system.time(for(i in 1:1000)
{
  result.list[[i]] <- sample.df
})
system.time(result.z <- do.call(rbind, result.list))
#사용자  시스템 elapsed 
#0.01    0.00    0.03 
#사용자  시스템 elapsed 
#18.80    0.16   19.59 

#data.table
result.list <- list()
system.time(for(i in 1:1000)
{
  result.list[[i]] <- as.data.table(sample.df)
})
system.time(result.w <- do.call(rbind, result.list))
#사용자  시스템 elapsed 
#0.25    0.01    0.59
#사용자  시스템 elapsed 
#0.35    0.04    0.50 

#test4 중첩for문 사용
#Sample1
m1 <- matrix(0, nrow = 1000, ncol = 1000)
system.time(for(i in 1:ncol(m1))
{
  for(j in 1:nrow(m1))
    ifelse(i == j, m1[j,i] <- 1,  m1[j,i] <- 2)
})
#사용자  시스템 elapsed 
#16.67    0.00   16.67

#Sample1 개선 방안
system.time(for(i in 1:nrow(m1))
{
  t1 <- c(1:ncol(m1))
  t1 <- t1[t1 != i]
  m1[i,i] <- 1
  m1[i, t1] <- 2  
})
#사용자  시스템 elapsed 
#1.62    0.00    1.64

#test5
#matrix, data.frame, data.table apply()에서 연산속도
#matrix
m2 <- matrix(rnorm(1e+05), 10000, 10000)
df1 <- as.data.frame(m2)
dt1 <- as.data.table(m2)
system.time(result1 <- apply(m2, 2, sd))
#사용자  시스템 elapsed 
#3.21    0.06    3.28
#data.frame
system.time(result2 <- apply(df1, 2, sd))
#사용자  시스템 elapsed 
#3.88    0.14    4.54 
#data.table
system.time(result3 <- apply(dt1, 2, sd))
#사용자  시스템 elapsed 
#3.42    0.26    3.68
head(result2)


#test6
#Character형식의 값을 factor처리되어진 속도와 numeric형식의 갓을 factor처리되어진 속도 비교
arr <- rep(letters, 1000)
system.time(for (i in 1:1000) foo1 <- factor(arr))
#사용자  시스템 elapsed 
#1.15    0.00    1.16 

arr <- rep(1:26, 1000)
system.time(for (i in 1:1000) foo2 <- factor(arr))
#사용자  시스템 elapsed 
#9.14    0.00    9.16 

#test7 값중에서 큰값을 도출
x <- rnorm(1e07); y <- rnorm(1e07)
#방법1
system.time(pmax(x, y))
#사용자  시스템 elapsed 
#0.5     0.0     0.5

#방법2
system.time(ifelse(x < y, y, x))
#사용자  시스템 elapsed 
#3.52    0.00    3.52 

#test8 괄호 개수에 따른 연산 속도
x <- rnorm(50); y <- rnorm(50); n <- 1000000
#예시1
system.time(for(i in 1:n) x + y)
#사용자  시스템 elapsed 
#0.53    0.00    0.53
system.time(for(i in 1:n) (((((x + y))))) )
#사용자  시스템 elapsed 
#1.10    0.00    1.11 
#괄호가 많을 수록 속도가 오래 걸림.

#test9 compiler Package를 활용한 Function 연산 속도 향상
library(compiler)
myFunction<-function() { for(i in 1:10000000) { 1*(1+1) } }
myCompiledFunction <- cmpfun(myFunction) # Compiled function

system.time( myFunction() )
#사용자  시스템 elapsed 
#7.87    0.01    7.88  
system.time( myCompiledFunction() )
#사용자  시스템 elapsed 
#0.42    0.00    0.43 


#test10 Group별 Summary1
Sample.df <- data.frame(AA = rep(c(letters, paste(letters,"-1", sep = ""), paste(letters,"-2", sep = "")),100000), BB = rnorm(2600000*3), stringsAsFactors = FALSE)

#aggregate함수를 사용하여 median 과 mean 연산 소요시간비교
system.time(Result.df1 <- aggregate(Sample.df$BB, by = list(Sample.df$AA), mean))
# 사용자  시스템 elapsed 
#11.12    0.00   11.31
system.time(Result.df2 <- aggregate(Sample.df$BB, by = list(Sample.df$AA), median))
# 사용자  시스템 elapsed 
#11.06    0.00   11.31

#for문을 사용하여 median 과 mean 연산 소요시간비교
uni.id <- unique(Sample.df$AA)
system.time(for(i in 1:length(uni.id))
{
  if(i == 1)
  {
    Result.df1a <- data.frame(AA = uni.id[i], VALUE = mean(Sample.df[Sample.df$AA == uni.id[i], "BB"]))
  }
  else{
    Result.df1a <- rbind(Result.df1a, data.frame(AA = uni.id[i], VALUE = mean(Sample.df[Sample.df$AA == uni.id[i], "BB"])))
  }
})
#사용자  시스템 elapsed 
#30.59    0.00   31.34

system.time(for(i in 1:length(uni.id))
{
  if(i == 1)
  {
    Result.df1a <- data.frame(AA = uni.id[i], VALUE = median(Sample.df[Sample.df$AA == uni.id[i], "BB"]))
  }
  else{
    Result.df1a <- rbind(Result.df1a, data.frame(AA = uni.id[i], VALUE = median(Sample.df[Sample.df$AA == uni.id[i], "BB"])))
  }
})
#사용자  시스템 elapsed 
#31.15    0.01   31.90

#3일차 교육이 끝났습니다. 수고하셨습니다.
#------------------
