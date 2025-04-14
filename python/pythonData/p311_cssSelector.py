import re
from bs4 import BeautifulSoup

myencoding = 'utf-8'
myparser = 'html.parser'
filename = 'css01.html'

html = open(filename, encoding=myencoding)
soup = BeautifulSoup(html, myparser)

h1 = soup.select_one('div#cartoon > h1').string
print("h1 = ", h1)
print("-" * 50)

li_list = soup.select('div#cartoon > ul.elements > li')
for li in li_list:
    print(li.string)
print("-" * 50)