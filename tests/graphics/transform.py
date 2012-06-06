import sfml as sf


t = sf.Vector2(50, 200)
r = 6.88
p = sf.Vector2(4, 7)

a = sf.Transform()
b = a.inverse

print(a)
print(b)

c = a.combine(b).translate(t).rotate(r, p)

print(c)
