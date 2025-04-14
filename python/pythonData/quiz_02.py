import urllib.request
from bs4 import BeautifulSoup
import pandas as pd
import matplotlib.pyplot as plt

url = "http://www.cgv.co.kr/movies/?it=1&ft=0"
html = urllib.request.urlopen(url)
soup = BeautifulSoup(html, 'html.parser')
plt.rcParams['font.family'] = 'NanumBarunGothic'

infos = soup.findAll('div', attrs={'class':'sect-movie-chart'})

# print('-' * 40)
# print(infos)
# print('-' * 40)

mydata0 = [i for i in range(1,20)]

result = []
title = soup.select("strong.title")     #strong 태그 중에서 class="title"인 것만 선택해서 리스트로 가져옴
for i in title:
    result.append(i.text)
mydata1 = result
print(mydata1)

result = []
score = soup.select("span.percent")     #span 태그 중에서 class="percent"인 것만 선택해서 리스트로 가져옴
for i in score:
    result.append(i.text)
mydata2 = result
print(mydata2)

result = []
reserv = soup.select("strong.percent")       #strong 태그 중에서 class="percent"인 것만 선택해서 리스트로 가져옴
for i in reserv:
    result.append(i.text.lstrip('예매율'))  #lstrip : 문자열의 맨 왼쪽부터 '예매율'이 나오는동안 '예매율'글자를 계속 없앰
mydata3 = result
print(mydata3)

result = []
release = soup.select("span > strong")       #span 태그 중에서 span 바로 아래에 있는 strong 태그를 선택해서 리스트로 가져옴
for i in release:
    result.append(i.text.strip()[0:10])  #strip:문자열 양쪽 공백 제거, [0:10]:문자열의 0부터 10까지만 가져옴
mydata4 = result
print(mydata4)

mycolumn = ['순위', '제목', '평점', '예매율', '개봉일']
#zip : 각 리스트들을 같은 인덱스끼리 하나의 튜플로 묶어줌, 튜플을 묶은 후 list로 감싸서 보기 편하게 만듦
myframe = pd.DataFrame(data = list(zip(mydata0, mydata1, mydata2, mydata3, mydata4)), columns=mycolumn)
myframe = myframe.set_index(keys=['순위']) #순위를 인덱스로 설정
print(myframe)
print('-' * 40)

filename = 'quiz_02_cgvMovie.csv'
myframe.to_csv(filename, encoding='utf-8', index=False)
print(filename, ' saved...', sep='')
print('finished')

dfmovie = myframe.reindex(columns=['제목', '평점', '예매율']) #열 순서를 재정렬  =>제목은 첫번째에 들어가서 아마 항목으로 쓰이고 평점, 예매율은 그래프에 쓰임임
print(dfmovie)

mygroup0 = dfmovie['제목']
mygroup1 = dfmovie['평점'] #평점 이라는 이름의 열을 Series로 추출
mygroup1 = mygroup1.str.replace('%','')   #시리즈 mygroup1에서 %를 찾아서 공백'' 으로 모두 바꿈
mygroup1 = mygroup1.str.replace('?','0')
mygroup2 = dfmovie['예매율']
mygroup2 = mygroup2.str.replace('%','')
mygroup2 = mygroup2.str.replace('?','0')

df = pd.concat([mygroup1, mygroup2], axis=1) #두 개의 시리즈즈(mygroup1, mygroup2)를 합쳐서 하나의 DataFrame 리스트로 만듦,    axis=1 열기준으로 결합
df = df.set_index(mygroup0)
df.columns = ['평점', '예매율']
print(df)

df.astype(float).plot(kind='barh', title='영화별 평점과 예매율', rot=0) #df.astype(float): 모든 열을 float 타입으로 변환
filename = 'quiz_02_cgvMovieGraph.png'
plt.savefig(filename, dpi=400, bbox_inches='tight')
plt.show()