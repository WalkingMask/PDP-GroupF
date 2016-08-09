# -*- coding: utf-8 -*-
import time
start = time.time()

#カプレカ数を求める

START = 1
END = 1000

a = []
kap_mem = []

while START < END:
	i = START
	digit = 0    #桁数
	while i != 0: #桁数のカウント
		i = i / 10
		digit += 1
	i = 0
	while i < digit: #配列に数を詰める
		x = 10 ** i
		y = START / x % 10
		a.append(y)
		i += 1
	a.sort()    #ソート
	buf1 = a[:]
	a.reverse() #逆ソート
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
	m1 = int(d)  #文字列を数値に変換
	i = 0
	while i < digit: #文字列に変換
		buf2[i] = str(buf2[i])
		i += 1
	i = 0
	d = ''
	while i < digit:
		d += buf2[i]
		i += 1
	m2 = int(d)  #文字列を数値に変換
	a = []
	if m2 - m1 == START: #カプレカ数の場合,kap_memに追加
			kap_mem.append(START)
	START += 1

print '---------------'
for mem in kap_mem:
	print mem 

elapsed_time = time.time() - start #時刻の差から処理時間を計測
print("elapsed_time:{0}".format(elapsed_time))