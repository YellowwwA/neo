import urllib.request
from bs4 import BeautifulSoup
import pandas as pd
import matplotlib.pyplot as plt

url = "https://www.moviechart.co.kr/rank/boxoffice"
html = urllib.request.urlopen(url)
soup = BeautifulSoup(html, 'html.parser')
plt.rcParams['font.family'] = 'NanumBarunGothic'

infos = soup.findAll('div', attrs={'class':'listTable group1'})

# print('-' * 40)
# print(infos)
# print('-' * 40)

mydata0 = [i for i in range(1,20)]

result = []
title = soup.select("td.title")    
for i in title:
    result.append(i.text)
mydata1 = result
print(mydata1)

result = []
score = soup.select("td.date")     
for i in score:
    result.append(i.text)
mydata2 = result
print(mydata2)

result = []
reserv = soup.select("td.audience")       
for i in reserv:
    result.append(i.text.split(' ')[0]) 
mydata3 = result
print(mydata3)

result = []
reserv = soup.select("td.cumulative")       
for i in reserv:
    result.append(i.text.split(' ')[0])  
mydata4 = result
print(mydata4)

result = []
reserv = soup.select("td.sales")       
for i in reserv:
    result.append(i.text.split(' ')[0])  
mydata5 = result
print(mydata5)



mycolumn = ['순위', '제목', '개봉일', '관객수', '누적관객수', '누적매출액']

title = '영화별 관객수와 누적관객수'


myframe = pd.DataFrame(data = list(zip(mydata0, mydata1, mydata2, mydata3, mydata4, mydata5)), columns=mycolumn)
myframe = myframe.set_index(keys=['순위']) 
print(myframe)
print('-' * 40)

filename = 'quiz_03_MovieChart.csv'
myframe.to_csv(filename, encoding='utf-8', index=False)
print(filename, ' saved...', sep='')
print('finished')

dfmovie = myframe.reindex(columns=['제목', '관객수', '누적관객수'])
print(dfmovie)

mygroup0 = dfmovie['제목']
mygroup1 = dfmovie['관객수']
mygroup1 = mygroup1.str.replace(',','') 
mygroup2 = dfmovie['누적관객수']
mygroup2 = mygroup2.str.replace(',','') 

df = pd.concat([mygroup1, mygroup2], axis=1) 
df = df.set_index(mygroup0)
df.columns = ['관객수', '누적관객수']
print(df)

df.astype(int).plot(kind='barh', title='영화별 관객수와 누적관객수', rot=0) 
filename = 'quiz_03_MovieChartGraph.png'
plt.savefig(filename, dpi=400, bbox_inches='tight')
plt.show()
