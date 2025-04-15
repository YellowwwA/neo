from itertools import count
from p340_ChickenUtil import ChickenStore

brandName = 'pelicana'
url = 'https://www.pelicana.co.kr/store/store.html'

def getData():
    savedData = []
    
    for page_idx in count():
        url = base_url + '?page=' + str(page_idx + 1)
        print(url)
        
print(brandName + ' 매장 크롤링 시작')
getData()
print(brandName + ' 매장 크롤링 완료')