# move the listener to the position (1, 0, -5)
sf.Listener.set_position(sf.Vector3(1, 0, -5))

# make it face the right axis (1, 0, 0)
sf.Listener.set_direction(sf.Vector3(1, 0, 0))

# reduce the global volume
sf.Listener.set_global_volume = 50
