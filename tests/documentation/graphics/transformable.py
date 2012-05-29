class MyEntity(sf.TransformableDrawable):
	def __init__(self):
		sf.TransformableDrawable.__init__(self)
		
	def draw(self, target, states):
		states.transform *= get_transform()
		target.draw(..., states)
		
entity = MyEntity()
entity.position = (10, 20)
entity.rotation = 45
window.draw(entity)




class MyEntity(sf.Drawable):
	def __init__(self):
		sf.Drawable.__init__(self)
		
		self.transformable = sf.Transformable()
		
	def draw(self, target, states):
		target.draw(..., self.transformable.transform)
		
	def _get_position(self):
		return self.transformable.position
		
	def _set_position(self, position):
		self.transformable.position = position
		
	position = property(_get_position, _set_position)
	
		
entity = MyEntity()
entity.position = (10, 20)
entity.rotation = 45
window.draw(entity)



class MyEntity(sf.Drawable):
{
public :
 void SetPosition(const MyVector& v)
 {
	 myTransform.setPosition(v.x(), v.y());
 }

 void Draw(sf::RenderTarget& target) const
 {
	 target.draw(..., myTransform.getTransform());
 }

private :
 sf::Transformable myTransform;
};
