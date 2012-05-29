System
------

time.py ::

	import sfml.system as sf

	print("# Seconds + convertisor")
	a = sf.seconds(50)
	a_ms = a.milliseconds
	a_us = a.microseconds

	print(a)
	print(a_ms)
	print(a_us)

	print("# Milliseconds + convertisor")
	b = sf.milliseconds(50000)
	b_s = b.seconds
	b_us = b.microseconds

	print(b)
	print(b_s)
	print(b_us)

	print("# Microseconds + convertisor")
	c = sf.microseconds(50000000)
	c_s = c.seconds
	c_ms = c.milliseconds

	print(c)
	print(c_s)
	print(c_ms)

	print("# Overload operators")
	d = a + b + c
	e = a - b - c
	f = a + b - c
	g = a - b + c

	print(d)
	print(e)
	print(f)
	print(g)

	print("# In-place operators")
	h = a.copy()
	h += b
	h += c


	i = a.copy()
	i -= b
	i -= c

	j = a.copy()
	j += b
	j -= c

	k = a.copy()
	k -= b
	k += c

	print(h)
	print(i)
	print(j)
	print(k)

	print("# Do overload opeartors compute the same result")
	assert h == d
	assert i == e
	assert j == f
	assert k == g
	print("It seems ok!")

sleep.py ::

	import sfml.system as sf

	print("Wait 2 seconds")
	sf.sleep(sf.seconds(2))
	print("Wait 1000 milliseconds")
	sf.sleep(sf.milliseconds(1000))
	print("Wait 500000 microseconds")
	sf.sleep(sf.microseconds(500000))

clock.py ::

	import sfml.system as sf

	clock = sf.Clock()
	input()
	a = clock.elapsed_time
	input()
	b = clock.elapsed_time
	input()
	c = clock.elapsed_time

	print(a)
	print(b)
	print(c)

	assert type(a) == sf.Time
	assert type(b) == sf.Time
	assert type(c) == sf.Time

	input()
	d = clock.restart()
	print(d)
	assert type(d) == sf.Time


size.py ::

	import sfml.system as sf

	a = sf.Size()
	b = sf.Size(height=50)
	c = sf.Size(width=50)
	d = sf.Size(50, 100)

	print(a)
	print(b)
	print(c)
	print(d)

	assert type(a) == sf.Size
	assert type(b) == sf.Size
	assert type(c) == sf.Size
	assert type(d) == sf.Size

	# TODO: add overload operators tests
	assert a == (0, 0)
	assert b == sf.Position(0, 50)
	assert c == sf.Size(50, 0)
	assert d == [50, 100]

rectangle.py ::

	import sfml.system as sf

	a = sf.Rectangle()
	b = sf.Rectangle(position=sf.Position(25, 50))
	c = sf.Rectangle(position=(25, 50))
	d = sf.Rectangle(size=sf.Size(75, 100))
	e = sf.Rectangle(size=(75, 100))
	f = sf.Rectangle(sf.Position(25, 50), sf.Size(75, 100))
	g = sf.Rectangle((25, 50), (75, 100))

	print(a)
	print(b)
	print(c)
	print(d)
	print(e)
	print(f)
	print(g)

	assert type(a) == sf.Rectangle
	assert type(b) == sf.Rectangle
	assert type(c) == sf.Rectangle
	assert type(d) == sf.Rectangle
	assert type(e) == sf.Rectangle
	assert type(f) == sf.Rectangle
	assert type(g) == sf.Rectangle

	# TODO: add overload operators tests
	#assert a == sf.Rectangle(0, 0)
	#assert b == sf.Position(0, 50)
	#assert c == sf.Size(50, 0)
	#assert d == [50, 100]
