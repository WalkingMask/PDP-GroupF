# -*- coding: utf-8 -*-
from multiprocessing import Pool
from multiprocessing import Process
import time

#カプレカ数を求める関数
def function(x):
	START = x
	a = []
	i = START
	digit = 0   #桁数
	if i != 0:
		while i != 0:  #桁数のカウント
			i = i / 10
			digit += 1
		i = 0
		while i < digit: #配列に数を詰める
			x = 10 ** i
			y = START / x % 10
			a.append(y)
			i += 1
		a.sort()         #ソート
		buf1 = a[:]
		a.reverse()      #逆ソート
		buf2 = a[:]
		i = 0
		while i < digit: #文字列に変換
			buf1[i] = str(buf1[i])
			i += 1
		i = 0
		d = ''
		while i < digit:
			d += buf1[i]
			i += 1
		m1 = int(d)      #文字列を数値に変換
		i = 0
		while i < digit:　#文字列に変換
			buf2[i] = str(buf2[i])
			i += 1
		i = 0
		d = ''
		while i < digit:
			d += buf2[i]
			i += 1
		m2 = int(d)      #文字列を数値に変換
		if m2 - m1 == START: #カプレカ数の場合,表示
			print START

def multi(n): #並列化
	tasks = [[] for i in range(4)] #負荷分散
	for i in range(n):
		tasks[i%4].append(i)
	p = Pool(4) #ワークプールを作成
	for i in range(4):
		p.map(function, tasks[i])

def main():
	data = multi(100000)
	print '---------'
	
start = time.time()        
main()
elapsed_time = time.time() - start #時刻の差から処理時間を計測
print("elapsed_time:{0}".format(elapsed_time))