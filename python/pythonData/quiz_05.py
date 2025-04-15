import pandas as pd

filename = 'NewChickenResult.csv'

#시도별로 치킨집 카운팅

df = pd.read_csv(filename, encoding='utf-8') # 시,도가 아닌 항목 삭제
df = df[~df['sido'].astype(str).str.isnumeric()] # astype: sido컬럼의 값들을 문자열로 변환환, isnumeric: 숫자로만 이루어진 문자열인지 체크하여 ~ 숫자가 아닌애들만 남김
df = df[~df['sido'].astype(str).str.contains('테스트')] # 테스트라고 적힌 항목 삭제

df['sido'] = df['sido'].replace({'서울특별시' : "서울"})  # 두 항목을 하나로 합치기
df['sido'] = df['sido'].replace({'부산광역시' : "부산"})  
df['sido'] = df['sido'].replace({'인천광역시' : "인천"})  
df['sido'] = df['sido'].replace({'대전광역시' : "대전"})  
df['sido'] = df['sido'].replace({'광주광역시' : "광주"})  
df['sido'] = df['sido'].replace({'대구광역시' : "대구"})  
df['sido'] = df['sido'].replace({'울산광역시' : "울산"})  
df['sido'] = df['sido'].replace({'세종특별자치시' : "세종"})  
df['sido'] = df['sido'].replace({'제주특별자치도도' : "제주"})  
df['sido'] = df['sido'].replace({'강원도' : "강원"})  
df['sido'] = df['sido'].replace({'경기도' : "경기"})  
df['sido'] = df['sido'].replace({'경상남도' : "경남"})  
df['sido'] = df['sido'].replace({'경상북도' : "경북"})  
df['sido'] = df['sido'].replace({'전라남도' : "전남"})  
df['sido'] = df['sido'].replace({'전라북도' : "전북"})  
df['sido'] = df['sido'].replace({'충청남도' : "충남"})  
df['sido'] = df['sido'].replace({'충청북도' : "충북"}) 


result = df.groupby(['sido', 'brand']).size().reset_index(name='count') #sido와 brand 컬럼을 기준으로 그룹을 짓는데 각 그룹마다 몇 개의 행이 있는지 세고    결과를 DataFrame 형태로 정리하고 이름을 count로 지정
print(result)

result.to_csv('xx_chicken.csv', encoding='utf-8', index=False)
print("\nFile Saved")
