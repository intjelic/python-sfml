import sfml as sf


t = sf.Position(50, 200)
r = 6.88
p = sf.Position(4, 7)

a = sf.Transform()
b = a.inverse

print(a)
print(b)

c = a.combine(b).translate(t).rotate(r, p)

print(c)
