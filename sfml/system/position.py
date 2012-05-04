class Position:
    def __init__(self, x=0, y=0):
        self._x = x
        self._y = y

    def __repr__(self):
        return "({0}, {1})".format(self.x, self.y)

    def __str__(self):
        return "({0}, {1})".format(self.x, self.y)

    def __iter__(self):
        return iter((self.x, self.y))

    def __getitem__(self, key):
        if key == 0: return self.x
        else: return self.y
        
    def __setitem__(self, key, value):
        if key == 0: self.x = value
        else: self.y = value
        
    def __add__(self, other):
        x, y = other
        return Position(self.x + x, self.y + y)

    def __sub__(self, other):
        x, y = other
        return Position(self.x - x, self.y - y)
        
    def __mul__(self, other):
        x, y = other
        return Position(self.x * x, self.y * y)
        
    def __truediv__(self, other):
        x, y = other
        return Position(self.x / x, self.y / y)
        
    def __floordiv__(self, other):
        x, y = other
        return Position(self.x // x, self.y // y)

    def __mod__(self, other):
        x, y = other
        return Position(self.x % x, self.y % y)
        
    def __divmod__(self, other):
        return self // other, self % other
        
    def __radd__(self, other):
        x, y = other
        return Position(x + self.x, y + self.y)

    def __rsub__(self, other):
        x, y = other
        return Position(x - self.x, y - self.y)

    def __rmul__(self, other):
        x, y = other
        return Position(x * self.x, y * self.y)
        
    def __rtruediv__(self, other):
        x, y = other
        return Position(x / self.x, y / self.y)
        
    def __rfloordiv__(self, other):
        x, y = other
        return Position(x // self.x, y // self.y)
        
    def __rmod__(self, other):
        x, y = other
        return Position(x % self.x, y % self.y)

    def __iadd__(self, other):
        x, y = other
        self.x += x
        self.y += y
        return self
        
    def __isub__(self, other):
        x, y = other
        self.x -= x
        self.y -= y
        return self
        
    def __imul__(self, other):
        x, y = other
        self.x *= x
        self.y *= y
        return self
        
    def __itruediv__(self, other):
        x, y = other
        self.x /= x
        self.y /= y
        return self
        
    def __ifloordiv__(self, other):
        x, y = other
        self.x //= x
        self.y //= y
        return self
        
    def __imod__(self, other):
        x, y = other
        self.x %= x
        self.y %= y
        return self
        
    def _get_x(self):
        return self._x

    def _set_x(self, x):
        self._x = x

    def _get_y(self):
        return self._y

    def _set_y(self, y):
        self._y = y

    x = property(_get_x, _set_x)
    y = property(_get_y, _set_y)

if __name__ == "__main__":
    pos1 = Position(3, 5)
    pos2 = Position(4, 6)
    print(pos1 + (4, 6))
    print(pos1 - (4, 6))
    print((3, 5) + pos2)
    print((3, 5) - pos2)
    pos1 += pos2
    print(pos1)
    pos2 -= pos1
    print(pos2)
    
