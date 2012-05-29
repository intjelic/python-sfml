import sfml as sf

time = sf.Time()
print(time.__repr__())
print(time)

clock = sf.Clock()
print(clock.__repr__())
print(clock)

sf.sleep(sf.microseconds(500000))
sf.sleep(sf.milliseconds(500))
sf.sleep(sf.seconds(0.5))

time = clock.elapsed_time
print(time.__repr__())
print(time)

time.reset()
print(time.__repr__())
print(time)
