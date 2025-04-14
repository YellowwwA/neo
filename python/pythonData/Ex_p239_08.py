import pandas as pd
import matplotlib.pyplot as plt

filename = 'tips.csv'

plt.rcParams['font.family'] = 'NanumBarunGothic'

myframe = pd.read_csv(filename, encoding='utf-8')

mycolor = ['r', 'b']
labels = ['Female', 'Male']

cnt=0

for finditem in labels:
    xdata = myframe.loc[myframe['sex'] == finditem,'total_bill']
    ydata = myframe.loc[myframe['sex'] == finditem,'tip']
    plt.plot(xdata,ydata, label=finditem, color=mycolor[cnt], marker='o', linestyle='None')
    cnt += 1

plt.legend(loc=2)
plt.xlabel('결제 총액')
plt.ylabel('팁 비용')
plt.title('결제 총액과 팁 비용의 산점도')
plt.grid(True)

filename = 'Ex_p239_08.png'
plt.savefig(filename, dpi=400, bbox_inches = 'tight')
print(filename + 'saved')
plt.show()