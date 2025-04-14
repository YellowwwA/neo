from bs4 import BeautifulSoup
import numpy as np
from pandas import DataFrame as df
import matplotlib.pyplot as plt

plt.rcParams['font.family'] = 'NanumBarunGothic'

html = open('/work/neo/html/source/5/ex5-10.html', 'r', encoding='utf-8')
soup = BeautifulSoup(html, 'html.parser')

result = []
tbody = soup.find('tbody')   #구하려는 값의 바로 위 부모만 find로 가져오면 됨
tds = tbody.find_all('td')   #td태그를 전부 (find_all) 가져오기
for data in tds:    #tds에 있는 모든 값들을 순회하며 result 리스트에 추가
    result.append(data.text)
print(result)
print('-' * 50)

mycolumns = ['이름','국어','영어']

myframe = df(np.reshape(np.array(result), (4,3)), columns=mycolumns)
myframe = myframe.set_index('이름')
print(myframe)
print('-' * 50)

myframe.astype(float).plot(kind='line', title='Score', legend=True)

filename = 'quiz_01_scoreGraph.png'
plt.savefig(filename, dpi=400, bbox_inches='tight')
print(filename + 'saved')
plt.show()
