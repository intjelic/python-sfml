polygon = sf.ConvexShape()
polygon.point_count = 3
polygon.set_point(0, (0, 0))
polygon.set_point(1, (0, 10))
polygon.set_point(2, (25, 5))
polygon.outline_color = sf.Color.RED
polygon.outlinne_thickness = 5
polygon.position = (10, 20)
# ...
window.draw(polygon)
