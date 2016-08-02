import time
start = time.time()

START = 1
END = 1000

a = []
kap_mem = []

while START < END:
	i = START
	digit = 0
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
	a = []
	if m2 - m1 == START:
			kap_mem.append(START)
	START += 1

print '---------------'
for mem in kap_mem:
	print mem 

elapsed_time = time.time() - start
print("elapsed_time:{0}".format(elapsed_time))