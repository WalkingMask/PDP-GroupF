from multiprocessing import Pool
from multiprocessing import Process
import time

def function(x):
	START = x
	a = []
	i = START
	digit = 0
	if i != 0:
		while i != 0:
			i = i / 10
			digit += 1
		i = 0
		while i < digit:
			x = 10 ** i
			y = START / x % 10
			a.append(y)
			i += 1
		a.sort()
		buf1 = a[:]
		a.reverse()
		buf2 = a[:]
		i = 0
		while i < digit:
			buf1[i] = str(buf1[i])
			i += 1
		i = 0
		d = ''
		while i < digit:
			d += buf1[i]
			i += 1
		m1 = int(d)
		i = 0
		while i < digit:
			buf2[i] = str(buf2[i])
			i += 1
		i = 0
		d = ''
		while i < digit:
			d += buf2[i]
			i += 1
		m2 = int(d)
		if m2 - m1 == START:
			print START

def multi(n):
	tasks = [[] for i in range(4)]
	for i in range(n):
		tasks[i%4].append(i)
	p = Pool(4)
	for i in range(4):
		p.map(function, tasks[i])

def main():
	data = multi(100000)
	print '---------'
	
start = time.time()        
main()
elapsed_time = time.time() - start
print("elapsed_time:{0}".format(elapsed_time))